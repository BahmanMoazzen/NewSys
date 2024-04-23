select * from dbo.profiles 
where 
	email in (select email from dbo.modir_users)
	and
	email in (select owner from dbo.profile_photos)