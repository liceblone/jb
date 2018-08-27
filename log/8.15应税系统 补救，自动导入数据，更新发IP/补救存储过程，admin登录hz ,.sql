/*
select boola as fHz,boolb as fWz,boolC as fYq ,boolD as fBj  from sys_finditem where 1<>1


fHz,fWz,fYq,fBj

alter table sys_finditem add boolC bit
alter table sys_finditem add boolD bit



select *from T201 order by f01 desc


select *from systabs

drop proc Pr_AccessDataForTax

exec jingbeisyspub.dbo.Pr_AccessDataForTax 1,0,1,0

*/
go
use jingbeisyspub

create   proc Pr_AccessDataForTax 
@fHz bit ,@fWz bit,@fYq bit,@fBj bit
as

if exists(select *from tempdb..sysobjects where name= '##TAccessDataForTax' )
begin
	drop table ##TAccessDataForTax
end
  
 create table ##TAccessDataForTax (  Fname varchar(20),IsTax bit ,filialeid int) 

 
 insert into ##TAccessDataForTax( Fname ,IsTax ,filialeid ) values('hz',@fHz, 5) ;
 insert into ##TAccessDataForTax( Fname ,IsTax ,filialeid ) values('wz',@fWz, 6) ;
 insert into ##TAccessDataForTax( Fname ,IsTax ,filialeid ) values('yq',@fYq, 7) ;
 insert into ##TAccessDataForTax( Fname ,IsTax ,filialeid ) values('bj',@fBj, 8) ;
 select Fname    ,filialeid ,case when  IsTax=1 then 'ÊÇ' else '·ñ' end as Istax   From ##TAccessDataForTax



go
use jbhzuserdata
create proc Pr_AccessDataForTax 
@fHz bit ,@fWz bit,@fYq bit,@fBj bit
as
exec jingbeisyspub.dbo.Pr_AccessDataForTax @fHz   ,@fWz  ,@fYq  ,@fBj

