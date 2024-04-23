begin tran
declare c cursor for  select email from USR.modir_users 
declare @email varchar(75)

open c
fetch next from c into @email
update USR.modir_users set pwd=cast(round(rand()*1000,0) as char(3)) where email=@email
while @@fetch_status =0
begin
fetch next from c into @email
update USR.modir_users set pwd=cast(round(rand()*1000,0) as char(3)) where email=@email
end

close c
deallocate c

commit tran
