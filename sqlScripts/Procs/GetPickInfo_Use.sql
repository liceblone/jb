alter PROCEDURE [dbo].[GetPickInfo_Use]                
                 @partNo varchar(50),                       
                 @Model varchar(50),                      
                 @WhId varchar(20)                      
AS                      
          --2009.07.12 只显示未被停用的规格  
/*                      
declare              
                 @partNo varchar(50),              
                 @Model varchar(50),              
                 @WhId varchar(20)              
select @partNo='%%'            
select @Model='74%'              
select @WhId='01'              
select top 20 * from wr_ware  
   
  */          
          
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.* into #wr   
      from wr_ware w   
inner join wr_class c on w.ClassId=c.Code   
where w.isUse=1 and w.Model like  @Model   and  w.partno like  @partno order by w.PartNo,w.Brand,w.Pack                    
                   
                  
                      
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)                      
union all                      
/*        
select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                      
*/        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') and d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02') and d.WareId in (select Id from #wr)                      
            
union all                      
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                      
union all                      
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                      
union all                      
select '',WhId,WareId,Qty,1 from wh_regulate where WareId in (select Id from #wr)                      
               
            
    --declare      @WhId varchar(20)              
    --select @WhId='01'                  
          
select w.*,IsNull((select sum(Qty) from #tmp where WareId=w.Id),0) as alStok,                      
           IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok
      ,w.Price*w.myRate as Fund
      ,w.id as wareid
      ,case when w.isdel=1 then 'clred'         else 'clblack' end as fntclr 
             
--into #wr_tmp                    
from #wr w                      
                    
--select * from #wr_tmp order by partno,model,brand,pack, alStok desc ,myStok desc                    
--drop table #wr_tmp                      
drop table #wr                      
drop table #tmp                    
      