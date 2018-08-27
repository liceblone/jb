alter  proc SP_ShowPriceChange    
@model varchar(30),    
@partno varchar(30) ,
@Note varchar(30)   
as    
    
/*  
declare @model varchar(30)  
declare @partno varchar(30)    
set  @model='IRF740'  
*/  
  
set @model=isnull(@model,'')  
set @partno=isnull(@partno,'')  
  
select w.*   into #wr   
from wr_ware w inner join wr_class c on w.ClassId=c.Code   
where w.Model like '%'+@Model+'%' and w.PartNo like '%'+@PartNo+'%'   
  
    
select * from TPriceChangeInfo 
where wareid in (select id from #wr)	  
and  ( isnull(PriceChangeInfo ,'') like '%'+@Note+'%'  or  isnull(note            ,'') like '%'+@Note+'%')
    
drop table #wr    
  
  
  go
  