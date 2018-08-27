alter PROCEDURE [dbo].[GetDistribut]   
                 @WareId int  
AS  
--set @MyWhId='001'  
--set @Model='556'  
--set @PartNo=''  
--set @ClassId=''  
select m.Code,m.WhId,d.WareId,d.Qty, isnull( m.FQtyChk , m.IsChk ) as isChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId=@WareId  
union all  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId=@WareId  
union all  
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId=@WareId  
union all  
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId=@WareId  
union all  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId=@WareId  
union all  
/*select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId=@WareId  
union all  
select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId=@WareId  
*/
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') and  d.WareId=@WareId                            
union all                            
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02')  and  d.WareId=@WareId                              
  
union all  
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId=@WareId  
union all  
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId=@WareId  
union all  
select '',WhId,WareId,Qty,1 from wh_regulate where WareId=@WareId  
  
                    
                          
select w.Code,w.Name,  
       Isnull((select sum(Qty) from #tmp where WhId=w.Code and IsChk=1),0) as Stock,  
       Isnull((select sum(Qty) from #tmp where WhId=w.Code),0) as AbleStock,   
       w.Assign  
from wh_warehouse w  
  
drop table #tmp