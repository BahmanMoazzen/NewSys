
alter database [divan] add filegroup [NWS]
alter database [divan] add filegroup [USR]
alter database [divan] add filegroup [ART]
alter database [divan] add filegroup [stat]

--alter database [divan] MODIFY FILE ( NAME =N'divansalar_com', FILENAME = N'E:\Databases\divansalar\' )
--alter database [divan] MODIFY FILE ( NAME =N'divansalar_com_log', FILENAME = N'E:\Databases\divansalar\' )

ALTER DATABASE [divan] ADD FILE ( NAME = N'divan_ART', FILENAME = N'e:\webspace\resadmin\moazz375\divansalar.moazzen.net\db\divan_ART.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ) TO FILEGROUP [ART]
ALTER DATABASE [divan] ADD FILE ( NAME = N'divan_NWS', FILENAME = N'e:\webspace\resadmin\moazz375\divansalar.moazzen.net\db\divan_nws.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ) TO FILEGROUP [NWS]
ALTER DATABASE [divan] ADD FILE ( NAME = N'divan_USR', FILENAME = N'e:\webspace\resadmin\moazz375\divansalar.moazzen.net\db\divan_USR.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ) TO FILEGROUP [USR]
ALTER DATABASE [divan] ADD FILE ( NAME = N'divan_STAT', FILENAME = N'e:\webspace\resadmin\moazz375\divansalar.moazzen.net\db\divan_STAT.ndf' , SIZE = 1024KB , FILEGROWTH = 1024KB ) TO FILEGROUP [STAT]
--create DATABASE [divansalar_com] ON  PRIMARY 
--( NAME = N'Modir_GNR', FILENAME = N'D:\Inetpub\wwwroot\DB\Modir_GNR.mdf'  , FILEGROWTH = 1024KB ), 
-- FILEGROUP [NWS] 
--( NAME = N'Modir_NWS', FILENAME = N'D:\Inetpub\wwwroot\DB\Modir_NWS.ndf' , FILEGROWTH = 1024KB ), 
-- FILEGROUP [USR] 
--( NAME = N'Modir_USR', FILENAME = N'D:\Inetpub\wwwroot\DB\Modir_USR.ndf'  , FILEGROWTH = 1024KB )
-- LOG ON 
--( NAME = N'Modir_LOG', FILENAME = N'D:\Inetpub\wwwroot\DB\Modir_LOG.ldf'  , MAXSIZE = 10240KB , FILEGROWTH = 1024KB )
-- COLLATE Arabic_CI_AI
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'divansalar_com', @new_cmptlevel=90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [divansalar_com].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [divansalar_com] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [divansalar_com] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [divansalar_com] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [divansalar_com] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [divansalar_com] SET ARITHABORT OFF 
GO
ALTER DATABASE [divansalar_com] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [divansalar_com] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [divansalar_com] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [divansalar_com] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [divansalar_com] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [divansalar_com] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [divansalar_com] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [divansalar_com] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [divansalar_com] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [divansalar_com] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [divansalar_com] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [divansalar_com] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [divansalar_com] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [divansalar_com] SET  READ_WRITE 
GO
ALTER DATABASE [divansalar_com] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [divansalar_com] SET  MULTI_USER 
GO
ALTER DATABASE [divansalar_com] SET PAGE_VERIFY CHECKSUM  
GO
USE [divansalar_com]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [divan] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
CREATE SCHEMA NWS
Go
CREATE SCHEMA GNR
Go
CREATE SCHEMA USR
Go
CREATE SCHEMA ART
CREATE SCHEMA STAT