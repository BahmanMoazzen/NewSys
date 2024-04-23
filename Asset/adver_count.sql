declare @url_from nvarchar(max)
DECLARE @tbl TABLE

(

  url nvarchar(max),

  total bigint

)
declare  c cursor for
select distinct  url_from from GNR.adver_stat
open c
fetch next from c into @url_from
insert into @tbl 
select @url_from,count(@url_from) from GNR.adver_stat where url_from=@url_from

WHILE @@FETCH_STATUS = 0
BEGIN
	fetch next from c into @url_from
	insert into @tbl 
select @url_from,count(@url_from) from GNR.adver_stat where url_from=@url_from
end
select * from @tbl
close c
deallocate c