(select art_id as id,art_title as title ,art_add_date as [add_date],'art' as part from ART.articles
union
select nws_id as id,nws_title as title,nws_add_date as [add_date], 'nws' as part from NWS.news) order by add_date desc