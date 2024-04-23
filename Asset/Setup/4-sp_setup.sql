use [divansalar_com]
GO
create proc [USR].[sp_ins_user] @email nvarchar(50),@display_name nvarchar(255)
		,@password nvarchar(75),@kind tinyint,@active bit
		as
begin
	INSERT INTO [USR].[users]
           ([email]
           ,[password]
           ,[kind]
           ,[active]
           ,[display_name])
     VALUES
           (@email
           ,@password
           ,@kind
           ,@active
           ,@display_name)
	INSERT INTO [USR].[login_stat]
           ([user_ref]
          
           ,[logins_total])
     VALUES
           (@email
           
           ,0)
	
	
end
GO

	

GO
create trigger trg_del_user on usr.users instead of delete as
begin
	
	delete from USR.login_stat where user_ref in (select email from deleted)
	delete from ART.articles where user_ref in (select email from deleted)
	delete from NWS.news where user_ref in (select email from deleted)
	delete from USR.users where email in (select email from deleted)

end
GO
create proc usr.sp_login_user @email nvarchar(50),@password nvarchar(75) as
begin
	declare @er_no tinyint,@er_desc nvarchar(150),@kind tinyint,@display_name nvarchar(75)
	select @er_no=0,@er_desc=N'بدون خطا',@kind=0
	if not exists (select email from usr.users where email=@email)
		select @er_no=1,@er_desc=N'چنین کاربری وجود ندارد'
	else
		if not exists(select kind from usr.users where email=@email and password=@password)
			select @er_no=2,@er_desc=N'کلمه عبور صحیح نیست'
		else
			if not exists(select kind from usr.users where email=@email and password=@password and active = 1)
				select @er_no=3,@er_desc=N'کاربر غیر فعال است'
			else
				begin
					select @kind=kind,@display_name=display_name from usr.users where email=@email and password=@password and active = 1
					update USR.login_stat set logins_total=logins_total+1 , last_login_date = getdate() where user_ref=@email
				end
			
	select @er_no as [ErNo],@er_desc as [ErDesc],@kind as [Kind],isnull(@display_name,'[noname]') as [Display_Name],@email as [email]
end

GO
create proc [NWS].[sp_add_news] @title nvarchar(255),@context nvarchar(MAX),@user_ref nvarchar(50) ,@keyword nvarchar(150) as

begin
	
	INSERT INTO [NWS].[news]
           ([nws_title]
           ,[nws_context]
           ,[user_ref]
			,[nws_keyword]
           )
     VALUES
           (@title
           ,@context
           ,@user_ref
			,@keyword
           )
	INSERT INTO [NWS].[news_stat]
           ([nws_id_ref])
     VALUES
           (@@identity)
end

GO
create proc [NWS].[sp_change_news] @nws_id bigint ,@title nvarchar(255),@context nvarchar(MAX),@keyword nvarchar(150) as

begin
	UPDATE [NWS].[news]
	SET [nws_title] = @title
      ,[nws_context] = @context
		,[nws_keyword]=@keyword
      
      
	WHERE nws_id=@nws_id
	
	
end
GO
create proc nws.sp_reset_news_status @nws_id bigint,@nws_status tinyint
as 
update nws.news_stat set nws_status=@nws_status where nws_id_ref=@nws_id
GO
create trigger trg_del_news on nws.news after delete as
delete from NWS.news_stat where nws_id_ref in (select nws_id from deleted)

GO
create proc [USR].[is_user_available] @email nvarchar(50) as
begin
	if exists(select email from usr.users where email=@email)
		select 1 'Result'
	else
		select 0 'Result'
end

go

create proc [NWS].[sp_load_news] @nws_id bigint as
begin
	update NWS.news_stat set nws_visits=nws_visits+1 where nws_id_ref=@nws_id
	SELECT     nws_visits, nws_comments, nws_title, nws_context, nws_add_date, nws_keyword, display_name, email 
	FROM        NWS.vw_news 
	WHERE     (nws_id = @nws_id)
	
end
GO
create proc [USR].[sp_load_user] @email nvarchar(50) as
begin
	SELECT     @email as [email], kind, display_name,password,active
	FROM         USR.users
	WHERE     (email = @email)
end
GO
create proc nws.sp_add_comment @nws_id bigint ,@title nvarchar(175),@context nvarchar(400),@email nvarchar(50),@display_name nvarchar(255) 
as 
begin
	insert into NWS.news_comments(com_title,com_context,com_email,com_display_name,nws_id_ref)
	values (@title,@context,@email,@display_name,@nws_id)
	update NWS.news_stat set nws_comments=nws_comments+1 where nws_id_ref=@nws_id
end
Go
create trigger trg_del_comment on NWS.news_comments after delete as
begin
	update NWS.news_stat set nws_comments=nws_comments-1 where nws_id_ref in (select nws_id_ref from deleted)
end
Go
create trigger trg_del_article on art.articles instead of delete as
begin
	delete from art.article_stats where art_id_ref in (select art_id from deleted)
	delete from ART.article_writers where art_id_ref in (select art_id from deleted)
	delete from ART.articles where art_id in (select art_id from deleted)
end
Go
create trigger trg_ins_article on art.articles after insert as
begin
	insert into ART.article_stats (art_id_ref) values (@@identity)
end

Go 
create proc [ART].[sp_add_article] @title nvarchar(175),@abstract nvarchar(Max),@keyword nvarchar(175)
		,@user_ref nvarchar(50),@lang_id_ref char(2),@publish_year int,@pages int,@price int ,@file_type varchar(8)
as
begin
	insert into art.articles(art_title,art_abstract,art_keyword,art_publish_year,art_pages,art_price,user_ref,lang_id_ref,art_file_type) 
				values (@title,@abstract,@keyword,@publish_year,@pages,@price,@user_ref,@lang_id_ref,@file_type)
	select @@identity as art_id

end

go

create trigger trg_ins_writer on ART.article_writers instead of insert as 
begin
	declare @wrt_id bigint
	select @wrt_id=max(wrt_id)+1 from ART.article_writers
	insert into ART.article_writers (wrt_id,art_id_ref ,wrt_name ,wrt_email)
	select isnull(@wrt_id,1),art_id_ref ,wrt_name ,wrt_email from inserted

end

Go

create proc art.sp_load_article @art_id bigint as
begin
	update ART.article_stats set art_visits=art_visits+1 where art_id_ref=@art_id
	SELECT art_id,art_title, art_keyword, art_abstract, art_add_date, lang_name, lang_dir, display_name, art_publish_year, art_pages, art_price, art_downloads, art_visits,art_def_rating, art_user_rating, art_status_ref, email,art_file_type FROM ART.vw_articles WHERE (art_id =@art_id)
end
Go
create proc [ART].[sp_change_article] @art_id bigint, @title nvarchar(175),@abstract nvarchar(Max),@keyword nvarchar(175)
		,@lang_id_ref char(2),@publish_year int,@pages int,@price int ,@file_type varchar(8)
as
begin
	update art.articles set art_title=@title,art_abstract=@abstract,art_keyword=@keyword,art_publish_year=@publish_year
	,art_pages=@pages,art_price=@price,lang_id_ref=@lang_id_ref,art_file_type=@file_type
	where art_id=@art_id
	

end
Go
create function GNR.count_words(@phrase nvarchar(max),@word nvarchar(255)) returns int as
begin

	

	declare @pos bigint,@count int
	select @pos=patindex(@word,@phrase),@count=0
	while @pos != 0
	begin

		select @count=@count+1
		select @phrase=substring(@phrase,@pos+len(@word)-2,len(@phrase)-@pos)
		select @pos=patindex(@word,@phrase)


	end
return @count
end
Go
create function gnr.article_score(@art_id bigint,@word nvarchar(255)) returns int as
begin
	declare @tscore tinyint,@ascore tinyint,@kscore tinyint,@total int
	select @tscore= 7,@ascore= 5,@kscore= 10
	select @total=gnr.count_words(art_title,@word)*@tscore+
				gnr.count_words(art_abstract,@word)*@ascore+
				gnr.count_words(art_keyword,@word)*@kscore
	from art.articles
	where art_id=@art_id

return @total
end

Go
CREATE proc [ART].[search_article] @word nvarchar(255),@whois nvarchar(50)
as begin
	
	declare @tbl table(
		art_id bigint,
		score int
	)
	insert into @tbl 
	select art_id,gnr.article_score(art_id,N'%'+@word+'%') as [score] from art.articles
	declare @findings int	
	select @findings = count(*) from @tbl where score >0
	insert into GNR.search_stat (s_query,s_whois,s_findings,s_system) values (@word,@whois,@findings,'art')
	
	select q.art_id,q.score,a.art_title,a.art_visits,a.art_downloads,a.art_add_date,a.display_name from @tbl q inner join art.vw_articles a on q.art_id=a.art_id
	where q.score >0 
	order by q.score desc

	
	
	
end
Go
create trigger [trg_del_news] on [NWS].[news] after delete as
begin

	delete from NWS.news_stat where nws_id_ref in (select nws_id from deleted)
	delete from NWS.news_comments where nws_id_ref in (select nws_id from deleted)
end
Go

create proc gnr.sp_select_verse as
begin
		declare @tmp table(id uniqueidentifier,vid tinyint)
		declare @vid tinyint
		insert into @tmp
		select newid(),vid from GNR.verses

		select top 1 @vid=vid from @tmp order by id
		
		select  isnull(verse,'') 'verse' from GNR.verses where vid=@vid
end