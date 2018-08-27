
 alter   proc SP_QryWh_Inventroy          
@begindate datetime ,          
@enddate  datetime ,          
@model   varchar(50),          
@partno  varchar(50),          
@pack  varchar(50)          
as          
    
  
--if (@model is null ) and (@partno is null ) and (@pack is null )     
--set @model=''    
--select id into #wr  from wr_ware D  where D.model like '%'+@model+'%' or D.partno like  '%'+@partno+'%' or  D.Pack like '%'+@pack+'%'        
    
--select * from #wr    
    
/* 
declare @begindate datetime           
declare @enddate  datetime           
declare @model   varchar(50)          
declare @partno  varchar(50)          
declare @pack  varchar(50)     
set @begindate='2008-9-1'    
set @enddate  ='2009-2-1'    
set @model  ='9014'    
set @partno =''       
set @pack  =''    
 */  
select    24 as BillID,m.code as billcode, m.* ,D.dlId,
D.InvId,D.WareId,D.PartNo,D.Brand,D.Qty,D.Price,D.dlNote, D.pack,D.Origin,   wr.model  
from Wh_Inventroy M          
join Wh_InventroyDL D on M.code=D.invID   
left join wr_Ware   wr on wr.id=D.Wareid
where     
M.xdate>=@begindate and M.xdate<=@enddate      and      
isnull(wr.model,'')  like  @model+'%' and    
--isnull(D.partno,'') like  '%'+'9018'+'%')  
isnull(D.partno,'') like  @partno+'%' and  
isnull(D.pack,'') like  @pack+'%' 








/*
原来盘点单没有型号  ,现在加上型号搜索2009-9-3
  
select 'D.'+name+',',*From syscolumns where id=object_id('Wh_InventroyDL')



exec SP_QryWh_Inventroy '2008-9-1','2009-2-1','9018','',''



select top 10 24 as BillID,m.code as billcode, m.* ,d.*    
from Wh_Inventroy M          
join Wh_InventroyDL D on M.code=D.invID   
where isnull(D.model,'')  like '%'
*/