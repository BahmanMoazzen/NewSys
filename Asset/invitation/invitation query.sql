/****** Script for SelectTopNRows command from SSMS  ******/
select * from USR.modir_users where email not in (select email from USR.users)
and points>1 and logins>1
order by logins desc,points desc