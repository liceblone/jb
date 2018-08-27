alter     PROCEDURE [dbo].[wh_StokViewer]                               
                 @MyWhId varchar(20)='',                              
                 @Model varchar(50)='',                              
                 @PartNo varchar(100)='',                              
                 @ClassId varchar(100)=''   ,                
                 @pack   varchar(100)=''    ,                 
                 @brand   varchar(100)=''                          
AS                              
                   /*             
                  
declare                 @MyWhId varchar(20)                             
declare                 @Model varchar(50)                              
declare                 @PartNo varchar(100)                              
declare                 @ClassId varchar(100)               
declare                 @pack   varchar(100)              
declare                 @brand   varchar(100)                     
set @MyWhId='01'                              
set @Model=''                              
set @PartNo=''                              
set @ClassId=''                        
set @pack=''            
set @brand=''                 
          */                      
                      
--2006-7-12 更改调拨部分                             
                            
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.*       
into #wr       
from wr_ware w inner join wr_class c on w.ClassId=c.Code       
where w.Model like '%'+@Model+'%' and w.PartNo like '%'+@PartNo+'%' and w.ClassId like IsNull(@ClassId,'')+'%'       
order by w.PartNo,w.Brand,w.Pack                              
                      
      
select m.Code,m.WhId,d.WareId,d.Qty,isnull( m.FQtyChk , m.IsChk ) as isChk into #tmp2 from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId  --where d.WareId in (select Id from #wr)                              
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
                              
                      
                      
if exists(select * from sysobjects where id=OBJECT_ID('TMtrLStorage'))                    
   drop table TMtrLStorage    
                      
select w.*,                              
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and IsChk=1 ),0) as alStok,                              
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and WhId=@MyWhId),0) as LocalStock,                              
  IsNull((select sum(Qty) from #tmp2 where WareId=w.Id and IsChk=1 and WhId=@MyWhId),0) as myStok,                              
case when isnull(saleprice ,0)=0 then   w.Cost*w.myRate                    
            else  saleprice end  as SlPrice                       
into TMtrLStorage         
from #wr w        where isnull( pack ,'')like  @pack+'%'      and  isnull( brand ,'')like @brand +'%'                
order by w.id          
                  
                  
select *  from TMtrLStorage         
  
  
update wr_ware   set Stock = case when qty  =0 then null else qty end  
from wr_ware wr   
join ( select SUM(Qty)as qty, WareId from #tmp2  group by WareId ) stock on wr.id= stock.wareid  
  
  
  
drop table #wr                              
drop table #tmp2         
  