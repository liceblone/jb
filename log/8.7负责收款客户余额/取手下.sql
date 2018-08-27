

alter Proc Pr_GetSubordinate
@empcode varchar(30) 
as


---declare @empcode varchar(30) 
--set @empcode ='0005'


create table #tmp 
(FempCode varchar(30))
 
    insert into #tmp(FempCode)
select @empcode

while exists(
      select M.Code        
      from hr_employee M        
      join hr_employee Dn on M.Boss =Dn.code 
      where M.Boss  in (select FempCode from #tmp) and M.Code not in (select FempCode from #tmp)
     )
begin
      insert into #tmp(FempCode)
      select M.Code        
      from hr_employee M        
      join hr_employee Dn on M.Boss =Dn.code 
      where M.Boss  in (select FempCode from #tmp) and M.Code not in (select FempCode from #tmp)
end

select * from #tmp

drop table #tmp
