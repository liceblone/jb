

drop proc Pr_GetALLSubordinate 
go
--Pr_GetALLSubordinate '0006'
create proc Pr_GetALLSubordinate 
@EmployeeId varchar(30)
as

--declare @EmployeeId varchar(30) set @EmployeeId ='0006'

CREATE TABLE #TMP
(EmployeeID varchar(20))

select * ,0 as Used into #SS from hr_employee  

exec  Pr_GetALLSubordinateIteration @EmployeeId

select * From hr_employee where code in (select * From #tmp) or code =@EmployeeId
--select *From #tmp
 
drop table #SS
drop table #tmp

go
alter proc Pr_GetALLSubordinateIteration
@EmployeeId varchar(30)
as

declare @code varchar(30)
insert into #TMP (EmployeeID ) select Code  from hr_employee where  boss=@EmployeeId
 
while exists(select * from #ss where boss =@EmployeeId and used=0)
begin
    select @code=  Code from #ss where boss =@EmployeeId and used=0
   print @code
    update #ss set used=1 where boss =@EmployeeId and used=0 and code=  @Code 
    exec  Pr_GetALLSubordinateIteration @code
end