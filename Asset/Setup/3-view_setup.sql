use [divansalar_com]
Go
CREATE VIEW [NWS].[vw_news_list]
AS
SELECT     GNR.content_statuses.status_name, USR.users.display_name, USR.users.email, NWS.news.nws_title, NWS.news.nws_add_date, NWS.news.nws_id, 
                      NWS.news_stat.nws_visits, NWS.news_stat.nws_comments, NWS.news_stat.nws_status
FROM         NWS.news_stat INNER JOIN
                      NWS.news ON NWS.news_stat.nws_id_ref = NWS.news.nws_id INNER JOIN
                      USR.users ON NWS.news.user_ref = USR.users.email INNER JOIN
                      GNR.content_statuses ON NWS.news_stat.nws_status = GNR.content_statuses.status_id

GO

CREATE VIEW [NWS].[vw_news]
AS
SELECT     NWS.news_stat.nws_visits, NWS.news_stat.nws_comments, NWS.news.nws_title, NWS.news.nws_context, NWS.news.nws_add_date, NWS.news.nws_keyword, 
                      USR.users.display_name, USR.users.email, NWS.news.nws_id
FROM         USR.users INNER JOIN
                      NWS.news ON USR.users.email = NWS.news.user_ref INNER JOIN
                      NWS.news_stat ON NWS.news.nws_id = NWS.news_stat.nws_id_ref
Go

CREATE VIEW [ART].[vw_articles]
AS
SELECT     ART.articles.art_id, ART.articles.art_title, ART.articles.art_keyword, ART.articles.art_abstract, ART.articles.art_add_date, GNR.languages.lang_name, 
                      GNR.languages.lang_dir, USR.users.display_name, ART.articles.art_publish_year, ART.articles.art_pages, ART.articles.art_price, ART.article_stats.art_downloads, 
                      ART.article_stats.art_visits, ART.article_stats.art_def_rating, ART.article_stats.art_vrq / ART.article_stats.art_vrn AS art_user_rating, ART.article_stats.art_status_ref, 
                      ART.articles.art_file_type, USR.users.email, GNR.languages.lang_id
FROM         ART.article_stats INNER JOIN
                      ART.articles ON ART.article_stats.art_id_ref = ART.articles.art_id INNER JOIN
                      USR.users ON ART.articles.user_ref = USR.users.email INNER JOIN
                      GNR.languages ON ART.articles.lang_id_ref = GNR.languages.lang_id

GO

CREATE VIEW [ART].[vw_article_writers]
AS
SELECT     ART.article_writers.wrt_id, ART.article_writers.art_id_ref, ART.article_writers.wrt_name, ART.article_writers.wrt_email, USR.users.display_name
FROM         USR.users RIGHT OUTER JOIN
                      ART.article_writers ON USR.users.email = ART.article_writers.wrt_email 

GO

create view GNR.vw_right_banner as
SELECT     link_order, link_template, link_visibility_stat
FROM         GNR.right_banner

Go
CREATE VIEW [ART].[vw_my_articles]
AS
SELECT     ART.articles.art_title, ART.articles.user_ref, ART.article_stats.art_visits, ART.article_stats.art_downloads, GNR.content_statuses.status_name, 
                      ART.articles.art_id,ART.articles.art_add_date
FROM         ART.articles INNER JOIN
                      ART.article_stats ON ART.articles.art_id = ART.article_stats.art_id_ref INNER JOIN
                      GNR.content_statuses ON ART.article_stats.art_status_ref = GNR.content_statuses.status_id

GO