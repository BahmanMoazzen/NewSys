update ART.articles set art_title=replace(art_title,N'ي',N'ی') , art_keyword=replace(art_keyword,N'ي',N'ی'),art_abstract=replace(art_abstract,N'ي',N'ی'),art_source=replace(art_source,N'ي',N'ی')

update ART.article_writers set wrt_name=replace(wrt_name,N'ي',N'ی')

update NWS.news set nws_title=replace(nws_title,N'ي',N'ی'),nws_context=replace(nws_context,N'ي',N'ی'),nws_keyword=replace(nws_keyword,N'ي',N'ی')

update USR.users set display_name=replace(display_name,N'ي',N'ی')