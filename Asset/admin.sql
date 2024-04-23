/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 1000 
----[url_from]
----      ,[url_to]
----      ,[url_date]
--*
--  FROM [divansalar_com].[GNR].[adver_stat]
--  where url_to is not null 
--  and adver_ref=2
--   order by url_date desc

  --select count(*) from gnr.adver_stat where url_to is null
  --select count(*) from gnr.adver_stat where url_to is not null
  --select distinct(url_from) from gnr.adver_stat where url_to is null
  --select  url_to,adver_ref from gnr.adver_stat where url_to is not null
  
  
  --select count(*) from gnr.adver_stat where datediff(day,url_date,getdate())=0 and url_to is null
  select count(*) from usr.users
  --select count(*) from gnr.adver_stat where datediff(day,url_date,getdate())=0 and url_to is not null
  --update usr.users set email='mohammad_hamid43@yahoo.com' where email='www.mohammad_hamid43@yahoo.com'
  select top 20 *,datediff(day,join_date,getdate()) as [days] from usr.users order by join_date desc
  -- delete from usr.users where email=N'www.mohammad_hamid43@yahoo.com'
  select *, datediff(day,join_date,getdate()) as [days] from usr.users where datediff(day,join_date,getdate())>5 and datediff(day,join_date,getdate())<=10 and active=0 
  -- delete from usr.users where datediff(day,join_date,getdate())>10 and active=0
  select *, datediff(day,join_date,getdate()) from usr.users where datediff(day,join_date,getdate())>10 and active=0
  select *,datediff(day,accept_date,getdate()) from USR.invitations where datediff(day,accept_date,getdate())=0 
  select  * from STAT.users where datediff(day,last_login_date,getdate())=0
  -- select top 20 * from STAT.users order by points_total desc
  -- select * from GNR.transactions where bedehkar='hanafona_77@yahoo.com' or bestankar='hanafona_77@yahoo.com'
select * from STAT.articles where art_status_ref=1


select * from STAT.news where status_ref=1


select * from GNR.comments order by com_date desc
select * from STAT.search order by s_date desc

select *,datediff(day,nws_last_visit,getdate()) as [days] from STAT.news
select *,datediff(day,art_last_visit,getdate()) as [visit days],datediff(day,art_last_download,getdate()) as [download days],datediff(day,art_last_rate,getdate()) as [rate days] from STAT.articles order by art_id_ref desc

select top (20) *,datediff(day,download_date,getdate()) as [days] from  ART.vw_downloaded_articles order by download_date desc

select top(20) *,datediff(day,trn_date,getdate()) as [days] from GNR.transactions order by trn_date desc
select * from ART.vw_print_orders order by add_date desc

--select nws_title,user_ref from NWS.news order by nws_title
--select art_title,user_ref from art.articles  where art_title like N'%عدالت%' order by art_title
--select art_title,user_ref from art.articles   order by art_title

select * from STAT.advertisment_shows
select * from STAT.advertisment_visits
-- select distinct substring(replace( replace(url_from,'www.',''),'http://',''),0,CHARINDEX('/',replace( replace(url_from,'www.',''),'http://',''))) as url  from STAT.advertisment_shows where url_from not like 'file://%'
-- select distinct substring(replace( replace(url_from,'www.',''),'http://',''),0,CHARINDEX('/',replace( replace(url_from,'www.',''),'http://',''))) as url  from STAT.advertisment_visits where url_from not like 'file://%'