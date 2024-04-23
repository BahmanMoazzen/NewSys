use [divansalar_com]
Go
------------------
INSERT INTO [GNR].[languages]
           ([lang_id]
           ,[lang_name]
           ,[lang_dir]
           )
     VALUES
           ('Fa'
           ,N'فارسی'
           ,'RTL'
           )
INSERT INTO [GNR].[languages]
           ([lang_id]
           ,[lang_name]
           ,[lang_dir]
           )
     VALUES
           ('En'
           ,N'English'
           ,'LTR'
           )

----------------

INSERT INTO [USR].[user_types]
           ([user_type_name])
     VALUES
           (N'کاربر عادی')
INSERT INTO [USR].[user_types]
           ([user_type_name])
     VALUES
           (N'کاربر ویژه')
INSERT INTO [USR].[user_types]
           ([user_type_name])
     VALUES
           (N'همکار سایت')
INSERT INTO [USR].[user_types]
           ([user_type_name])
     VALUES
           (N'مدیر سایت')
------------------




------------------

EXECUTE [USR].[sp_ins_user] 
   N'webmaster@divansalar.com'
  ,N'مدیریت سایت'
  ,N'divan110'
  ,4
  ,1
  



-----------

--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار اقتصادی'
--           ,N'در این سرویس اخبار اقتصادی ارائه می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار سیاسی'
--           ,N'در این سرویس اخبار سیاسی ارائه می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار اجتماعی'
--           ,N'در این سرویس اخبار اجتماعی ارائه می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار فرهنگی'
--           ,N'در این سرویس اخبار مرتبط با فرهنگ ارائه می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار بین المللی'
--           ,N'در این سرویس اخبار مربوط به اوضاع بین المللی ارائه می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار مدیریت'
--           ,N'تازه ها و یافته های جدید مدیریت در این بخش ارائه می گردد.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار دانشجویی'
--           ,N'در این سرویس اتفاقات مرتبط با دانشجویان پیگیری می شود.'
--           ,3
--           ,1
--           ,0)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'شایعات'
--           ,N'در این سرویس اخبار تایید نشده قرار دارد.'
--           ,1
--           ,1
--           ,1)
--INSERT INTO [NWS].[news_cats]
--           ([nws_cat_name]
--           ,[nws_cat_desc]
--           ,[nws_cat_def_stat]
--           ,[nws_cat_min_level]
--           ,[nws_cat_min_visit_level])
--     VALUES
--           (N'اخبار سایت'
--           ,N'در این سرویس آخرین تغییرات سایت اعلام می گردد.'
--           ,3
--           ,4
--           ,0)
-------------

INSERT INTO [GNR].[content_statuses]
           ([status_name])
     VALUES
           (N'خبر تازه ارسال شده'
           )
INSERT INTO [GNR].[content_statuses]
           ([status_name])
     VALUES
           (N'عدم تایید خبر'
           )
INSERT INTO [GNR].[content_statuses]
           ([status_name])
     VALUES
           (N'خبر قابل روئیت'
           )
INSERT INTO [GNR].[content_statuses]
           ([status_name])
     VALUES
           (N'خبر برای اعضاء'
           )
---------

INSERT INTO [GNR].[right_banner]
           ([link_order]
           ,[link_front]
           ,[link_back]
           ,[link_template])
     VALUES
           (1
           ,null
           ,'/images/right_banner/first.jpg'
           ,'<img src="[$back$]" width="145" height="25" />')
INSERT INTO [GNR].[right_banner]
           ([link_order]
           ,[link_front]
           ,[link_back]
           ,[link_template])
     VALUES
           (2
           ,null
           ,'/images/right_banner/news.jpg'
           ,'<img src="[$back$]" width="145" height="25" />')
INSERT INTO [GNR].[right_banner]
           ([link_order]
           ,[link_front]
           ,[link_back]
           ,[link_template])
     VALUES
           (3
           ,null
           ,'/images/right_banner/article.jpg'
           ,'<img src="[$back$]" width="145" height="25" />')