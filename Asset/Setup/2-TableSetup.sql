use [divansalar_com]
Go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO

CREATE TABLE [ART].[article_stats](
	[art_id_ref] [bigint] NOT NULL,
	[art_def_rating] [tinyint] NOT NULL CONSTRAINT [DF_article_stats_art_def_rating]  DEFAULT ((3)),
	[art_vrq] [bigint] NOT NULL CONSTRAINT [DF_article_stats_art_vrq]  DEFAULT ((3)),
	[art_vrn] [int] NOT NULL CONSTRAINT [DF_article_stats_art_vrn]  DEFAULT ((1)),
	[art_visits] [int] NOT NULL CONSTRAINT [DF_article_stats_art_visits]  DEFAULT ((0)),
	[art_downloads] [int] NOT NULL CONSTRAINT [DF_article_stats_art_downloads]  DEFAULT ((0)),
	[art_status_ref] [tinyint] NOT NULL CONSTRAINT [DF_article_stats_art_status_ref]  DEFAULT ((1)),
 CONSTRAINT [PK_article_stats] PRIMARY KEY CLUSTERED 
(
	[art_id_ref] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [ART]
) ON [ART]

Go
CREATE TABLE [ART].[article_writers](
	[wrt_id] [bigint] NOT NULL,
	[art_id_ref] [bigint] NOT NULL,
	[wrt_name] [nvarchar](35)  NOT NULL,
	[wrt_email] [nvarchar](50)  NULL,
 CONSTRAINT [PK_article_writers] PRIMARY KEY CLUSTERED 
(
	[wrt_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [ART]
) ON [ART]
Go
CREATE TABLE [ART].[articles](
	[art_id] [bigint] IDENTITY(1,1) NOT NULL,
	[art_title] [nvarchar](175)  NOT NULL,
	[art_keyword] [nvarchar](175)  NULL,
	[art_abstract] [nvarchar](max)  NULL,
	[art_add_date] [datetime] NOT NULL CONSTRAINT [DF_articles_art_add_date]  DEFAULT (getdate()),
	[user_ref] [nvarchar](50)  NOT NULL,
	[lang_id_ref] [char](10)  NOT NULL,
	[art_publish_year] [int] NULL,
	[art_pages] [int] NULL,
	[art_price] [int] NULL CONSTRAINT [DF_articles_art_price]  DEFAULT ((0)),
	[art_file_type] [varchar](8)  NULL,
 CONSTRAINT [PK_articles] PRIMARY KEY CLUSTERED 
(
	[art_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [ART]
) ON [ART]

GO
CREATE TABLE [GNR].[content_statuses](
	[status_id] [tinyint] IDENTITY(1,1) NOT NULL,
	[status_name] [nvarchar](30)  NULL,
 CONSTRAINT [PK_content_statuses] PRIMARY KEY CLUSTERED 
(
	[status_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
CREATE TABLE [GNR].[languages](
	[lang_id] [char](2)  NOT NULL,
	[lang_name] [nvarchar](25) NOT NULL,
	[lang_dir] [char](3)  NOT NULL,
 CONSTRAINT [PK_languages] PRIMARY KEY CLUSTERED 
(
	[lang_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
CREATE TABLE [GNR].[right_banner](
	[linkid] [tinyint] IDENTITY(1,1) NOT NULL,
	[link_order] [tinyint] NOT NULL,
	[link_template] [nvarchar](250)  NOT NULL,
	[link_visibility_stat] [tinyint] NULL,
 CONSTRAINT [PK_right_banner] PRIMARY KEY CLUSTERED 
(
	[linkid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
CREATE TABLE [GNR].[search_stat](
	[sid] [bigint] IDENTITY(1,1) NOT NULL,
	[s_query] [nvarchar](255)  NULL,
	[s_date] [datetime] NOT NULL CONSTRAINT [DF_search_stat_s_date]  DEFAULT (getdate()),
	[s_system] [char](3)  NULL,
	[s_whois] [nvarchar](50)  NULL,
	[s_findings] [int] NULL,
 CONSTRAINT [PK_search_stat] PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [NWS].[news](
	[nws_id] [bigint] IDENTITY(1,1) NOT NULL,
	[nws_title] [nvarchar](255)  NOT NULL,
	[nws_context] [nvarchar](max)  NULL,
	[user_ref] [nvarchar](50)  NULL,
	[nws_add_date] [datetime] NULL CONSTRAINT [DF_news_nws_add_date]  DEFAULT (getdate()),
	[nws_keyword] [nvarchar](150)  NULL,
 CONSTRAINT [PK_news] PRIMARY KEY CLUSTERED 
(
	[nws_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [NWS]
) ON [NWS]

GO

CREATE TABLE [NWS].[news_comments](
	[comid] [bigint] IDENTITY(1,1) NOT NULL,
	[com_title] [nvarchar](175)  NULL,
	[com_context] [nvarchar](400)  NOT NULL,
	[com_email] [nvarchar](50)  NOT NULL,
	[com_display_name] [nvarchar](255)  NOT NULL,
	[nws_id_ref] [bigint] NOT NULL,
 CONSTRAINT [PK_news_comments] PRIMARY KEY CLUSTERED 
(
	[comid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [NWS]
) ON [NWS]
GO
CREATE TABLE [NWS].[news_stat](
	[nws_id_ref] [bigint] NOT NULL,
	[nws_comments] [int] NOT NULL CONSTRAINT [DF_news_stat_nws_comments]  DEFAULT ((0)),
	[nws_visits] [int] NOT NULL CONSTRAINT [DF_news_stat_nws_visits]  DEFAULT ((0)),
	[nws_status] [tinyint] NOT NULL CONSTRAINT [DF_news_stat_nws_status]  DEFAULT ((3)),
 CONSTRAINT [PK_news_stat] PRIMARY KEY CLUSTERED 
(
	[nws_id_ref] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [NWS]
) ON [NWS]
Go

CREATE TABLE [USR].[login_stat](
	[user_ref] [nvarchar](50)  NOT NULL,
	[logins_total] [int] NOT NULL,
	[last_login_date] [datetime] NULL CONSTRAINT [DF_login_stat_last_login_date]  DEFAULT (getdate()),
 CONSTRAINT [PK_login_stat] PRIMARY KEY CLUSTERED 
(
	[user_ref] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [USR]
) ON [USR]
Go
CREATE TABLE [USR].[user_types](
	[user_type_id] [tinyint] IDENTITY(1,1) NOT NULL,
	[user_type_name] [nvarchar](35)  NULL,
 CONSTRAINT [PK_user_types] PRIMARY KEY CLUSTERED 
(
	[user_type_id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [USR]
) ON [USR]
Go
CREATE TABLE [USR].[users](
	[email] [nvarchar](50)  NOT NULL,
	[password] [nvarchar](75)  NOT NULL,
	[kind] [tinyint] NOT NULL,
	[active] [bit] NOT NULL,
	[display_name] [nvarchar](255)  NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [USR]
) ON [USR]

Go
CREATE TABLE [GNR].[verses](
	[vid] [tinyint] NOT NULL,
	[verse] [nvarchar](250)  NOT NULL,
 CONSTRAINT [PK_verses] PRIMARY KEY CLUSTERED 
(
	[vid] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
Go
SET ANSI_PADDING OFF