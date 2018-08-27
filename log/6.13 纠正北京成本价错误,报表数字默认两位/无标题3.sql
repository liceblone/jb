 select *from Wr_ware where price is null or cost is null 
and id in (select id from jbyquserdata.dbo.wr_ware where price is not null or cost   is not null )


sp_helptext wh_StokViewer


CREATE  
  PROCEDURE [dbo].[wh_StokViewer]                   
                 @MyWhId varchar(20)='',                  
                 @Model varchar(50)='',                  
                 @PartNo varchar(100)='',                  
                 @ClassId varchar(100)=''    ,    
                 @pack   varchar(100)=''    ,     
                 @brand   varchar(100)=''                
AS                  
                  
             
declare                 @MyWhId varchar(20)                 
declare                 @Model varchar(50)                  
declare                 @PartNo varchar(100)                  
declare                 @ClassId varchar(100)    
declare       		@pack   varchar(100) 
declare                 @brand   varchar(100) 
             
set @MyWhId=''                  
set @Model=''                  
set @PartNo=''                  
set @ClassId=''            
set @pack=''
set @brand=''
     /**/          
          
--2006-7-12 更改调拨部分                 
                
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.* into #wr from wr_ware w inner join wr_class c on w.ClassId=c.Code where w.Model like '%'+@Model+'%' and w.PartNo like '%'+@PartNo+'%' and w.ClassId like IsNull(@ClassId,'')+'%' order by w.PartNo,w.Brand
  
    
      
        
     ,w.Pack                  
          
                  
          
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp2 from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId  --where d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId --where d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId --where d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId --where d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId --where d.WareId in (select Id from #wr)                  
union all                  
                
--select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                  
--union all                  
--select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                  
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') --and d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02') --and d.WareId in (select Id from #wr)                  
                
union all                  
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) --and d.WareId in (select Id from #wr)                  
union all                  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) --and d.WareId in (select Id from #wr)                  
union all                  
select '',WhId,WareId,Qty,1 from wh_regulate --where WareId in (select Id from #wr)                  
                  
          
          
          
          
select w.*,                  
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and IsChk=1 ),0) as alStok,                  
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and WhId=@MyWhId),0) as LocalStock,                  
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and IsChk=1 and WhId=@MyWhId),0) as myStok,                  
case when isnull(saleprice ,0)=0 then   w.Cost*w.myRate        
            else  saleprice end  as SlPrice           
            
from #wr w        where isnull( pack ,'')like  @pack+'%'      and  isnull( brand ,'')like @brand +'%'    
          
      
      
select sum(Qty ) as Qty ,WareId into #TmpSum From #tmp2 group by WareId      
update wr_ware set stock=b.qty  from wr_ware A join #TmpSum B on a.id=b.WareId      
where isnull(a.stock,0)<isnull(b.qty,0)      
      
--  select *  From #TmpSum      
--  select top 100 pack ,brand,*  From wr_ware  #tmp A join #wr B on A.id=B.id          
          
      
drop table #TmpSum      
          
                  
drop table #wr                  
drop table #tmp2          
          
                
                
                


go

drop table #N

select * into #N from #k where alStok is not null and alStok>0 and (cost is null or price is null)
                

select alStok,* from #N  

select alStok,* from #N where id in (
select wareid from ph_arrivedl)




select b.cost,b.price,A.cost,A.price,alStok,* 
from #N    A
join jbyquserdata.dbo.wr_ware B   on A.id=b.id

update #N set  cost=b.cost ,price=b.price
from #N    A
join jbyquserdata.dbo.wr_ware B   on A.id=b.id


select  cost, price ,*from #N where cost is null


select b.cost,b.price,A.cost,A.price,alStok,* 
from #N    A
join jbhzuserdata.dbo.wr_ware B   on A.id=b.id where A.cost is null


 

select b.cost,b.price,A.cost,A.price,alStok,* 
from jbbjuserdata.dbo.wr_ware     A
join  #N  B   on A.id=b.id where A.cost is null


update   jbbjuserdata.dbo.wr_ware   set cost=b.cost ,price=b.price   
from jbbjuserdata.dbo.wr_ware     A
join  #N  B   on A.id=b.id where A.cost is null


select * from jbbjuserdata.dbo.wr_ware where  cost is not  null
        
        
select price,cost ,* from jbyquserdata.dbo.wr_ware where id=35743
select price,cost ,* from jbhzuserdata.dbo.wr_ware where id=35743
select price,cost ,* from jbwzuserdata.dbo.wr_ware where id=35743
select price,cost ,* from jbbjuserdata.dbo.wr_ware where id=35743



      
    
  
