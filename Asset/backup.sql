BACKUP DATABASE [divansalar_com] TO  DISK = N'e:\webspace\resadmin\moazz375\divansalar.moazzen.net\db\divansalar_com_13900229_1700.bak' 
GO
USE [divansalar_com]
GO
DBCC SHRINKDATABASE(N'divansalar_com' )
GO