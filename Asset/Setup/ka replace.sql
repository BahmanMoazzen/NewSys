update ART.articles set art_title=replace(art_title,N'ك',N'ک') , art_keyword=replace(art_keyword,N'ك',N'ک'),art_abstract=replace(art_abstract,N'ك',N'ک'),art_source=replace(art_source,N'ك',N'ک')

update ART.article_writers set wrt_name=replace(wrt_name,N'ك',N'ک')

update NWS.news set nws_title=replace(nws_title,N'ك',N'ک'),nws_context=replace(nws_context,N'ك',N'ک'),nws_keyword=replace(nws_keyword,N'ك',N'ک')

update USR.users set display_name=replace(display_name,N'ك',N'ک')