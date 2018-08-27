select isuse,* from wr_ware where isnull(isuse,0)=0


采购询价
297
GetPickInfo

供应商报价

select * from wr_ware where PartNo like :PartNo and Model like :Model order by PartNo,Brand,Pack

采购订单
GetPickInfo

供应商发货通知
GetPickInfo

采购到货单
GetPickInfo

采购退货
GetPickInfo


销售报价
sl_InvRfs   --389

销售订单
sl_InvRfs

发货单
sl_InvRfs

销售退货单
GetPickInfo


零售单
GetPickInfo


入库单
GetPickInfo


出库单
GetPickInfo

本地调拔，

GetPickInfo
异地调拨

GetPickInfo


sp_helptext GetPickInfo

exec GetPickInfo  'LF357N%','%','%' 

exec GetPickInfo_Use  'LF357N%','%','%' 


CREATE PROCEDURE [dbo].[GetPickInfo_Use]   --old 297   new    --723        
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
           IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok,                    
       w.Price*w.myRate as Fund       ,    
        case when w.isdel=1 then 'clred'         else 'clblack' end as fntclr    
--into #wr_tmp                  
from #wr w                    
                    
--select * from #wr_tmp order by partno,model,brand,pack, alStok desc ,myStok desc                  
--drop table #wr_tmp                    
drop table #wr                    
drop table #tmp                  
    


sp_helptext sl_InvRfs


--  select * from wr_ware where isnull(isuse,0)=0
  


exec sl_InvRfs_Use 'LF357N%','','',''

exec sl_InvRfs  'LF357N%','%','%',''

CREATE      PROCEDURE [dbo].[sl_InvRfs_Use]     --old 389   new         --724
--declare            
                 @partNo varchar(50),            
                 @Model varchar(50),            
                 @WhId varchar(20),            
                 @ClientId varchar(20)            
AS      
 --2009.07.12 只显示未被停用的规格      
/*          
declare            
                 @partNo varchar(50),            
                 @Model varchar(50),            
                 @WhId varchar(20),            
                 @ClientId varchar(20)            
select @partNo='%%'          
select @Model='74%'            
select @WhId='01'            
select @ClientId='HZ000453'            
*/          
            
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.* into #wr 
      from wr_ware w 
inner join wr_class c on w.ClassId=c.Code 
where w.isUse=1 and w.Model like @Model and w.partno like @partNo order by w.PartNo,w.Brand,w.Pack            
            
select  d.WareId,d.qty,d.Price,m.istax into #inv from sl_invoice m inner join sl_invoicedl d on ClientId=@ClientId and d.WareId in (select Id from #wr)   and m.Code=d.InvoiceId order by m.InvoiceDate desc,d.dlId desc            
            
select d.WareId,d.Price into #qot from sl_quote m inner join sl_quotedl d on ClientId=@ClientId and d.WareId in (select Id from #wr) and m.IsChk=1 and m.Code=d.QuoteId order by m.QuoteDate desc,d.dlId desc            
            
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)            
union all            
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)            
union all            
select m.Code,m.WhId,d.WareId,-d.Qty+d.RmnQty,m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)            
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
            
          
          
select w.*,            
  IsNull((select sum(Qty) from #tmp where WareId=w.Id),0) as alStok,            
  IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok,            
  w.Cost*w.myRate as Fund,            
  Isnull((select top 1 Price from #qot where WareId=w.Id),0) as QotPrice,            
  Isnull((select top 1 Price from #inv TV where WareId=w.Id and isnull(TV.istax,0)=1 ),0) as SlTaxPrice ,          
  Isnull((select top 1 Price from #inv V  where WareId=w.Id and isnull( v.istax,0)=0 ),0) as SlPrice  ,          
  B.MinPrice as PriceChange    ,      
 case when isdel=1 then 'clred' else 'clblack' end as fntclr      
from #wr w            
left join TPriceChangeInfo  B on W.id=B.wareid          
          
          
            
drop table #wr            
drop table #tmp            
drop table #inv            
drop table #qot            
    





----------
 select name+',',* from syscolumns where id=object_id('t505')

insert into t505
select 
723,F23,F04,F05,F06,F07,F08,F09,
F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,
F20,F21,F22,F03,F24,F25,F26,F27
from t505 where f02=297

select * from t505 where f02=389
select * from t505 where f02=724



insert into t505
select 
724,F23,F04,F05,F06,F07,F08,F09,
F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,
F20,F21,F22,F03,F24,F25,F26,F27
from t505 where f02=389
  

