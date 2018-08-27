CREATE     PROCEDURE dbo.wh_ware_inout                  
                 @WhId varchar(20),                   
                 @WareId int,                  
                 @Filters varchar(20)                  
                  
AS                   
--（销售补货 销售发货）已审              
select 0 as xOrder,1 as IsCalc,m.ChkTime, m.ArriveDate as xDate,m.Code as BillCode,9 as BillId,(case m.IsChk when 1 then 'clBlack' else 'clRed' end) as FntClr,'采购到货入库 '+m.ClientName as Brief,d.Qty as InQty,null as OutQty,null as RmnQty ,billtime     
into #tmp     
from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId=@WareId and m.WhId=@WhId                  
                
union all                  
select 0,1,m.ChkTime,m.ReturnDate,m.Code,13,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'采购退货出库 '+m.ClientName,null,d.Qty,null ,billtime from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId=@WareId and m.WhId=@WhId      
            
union all                  
select 0,1,m.ChkTime,m.InvoiceDate,m.Code,19,'clRed',                                             '销售发货未审 '+m.ClientName,null,d.Qty,null ,billtime from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where m.IsChk<>1 and d.WareId=@WareId and 
m.WhId=@WhId                  
                
union all                  
--select 0,1,m.OutDate,m.LnkBlCd,19,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'销售发货出库 '+m.ClientName,null,d.Qty,null from wh_out m inner join wh_outdl d on m.Code=d.OutId where d.WareId=@WareId and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=1 
  
    
      
        
          
            
                
               
--union all                  
--select 0,1,m.OutDate,m.LnkBlCd,19,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'销售补货出库 '+m.ClientName,null,d.Qty,null from wh_out m inner join wh_outdl d on m.Code=d.OutId where d.WareId=@WareId and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=0 
  
    
      
        
          
            
                
 select 0,1,phf.ChkTime, Phf.InvoiceDate,m.LnkBlCd,19,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'销售发货出库 '+m.ClientName,null,d.Qty,null    ,Phf.billtime            
 from wh_out m               
 inner join wh_outdl d on m.Code=d.OutId               
 inner join sl_invoice Phf on  m.LnkBlCd=Phf.Code               
 where d.WareId=@WareId and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=1                 
              
 union all                  
 select 0,1,phb.ChkTime, Phb.InvoiceDate,m.LnkBlCd,19,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'销售补货出库 '+m.ClientName,null,d.Qty,null   ,Phb.billtime            
 from wh_out m               
 inner join wh_outdl d on m.Code=d.OutId              
 inner join sl_invoice Phb on  m.LnkBlCd=Phb.Code                
 where d.WareId=@WareId and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=0                     
union all              
            
/*  */               
select 0,1,m.ChkTime, m.ReturnDate,m.Code,20,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'销售退货入库 '+m.ClientName,d.Qty,null,null,billtime from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId=@WareId and m.WhId=@WhId      
            
union all                  
select 0,1,m.ChkTime, m.RetailDate,m.Code,3,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),'零售出库',null,d.Qty,null,billtime from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId=@WareId and m.WhId=@WhId                  
union all                  
          
          
 select 0,1,m.ChkTime, m.MoveDate,m.Code,23,(case Z.IsChk when 1 then 'clBlack' else 'clRed' end),          
 '调拨入库,'+m.OutWhId,d.Qty,null,null ,m.billtime           
 from wh_move m           
 inner join wh_movedl d on m.Code=d.MoveId           
 inner join wh_in     Z on Z.code=M.WhInCode          
 where d.WareId=@WareId and m.InWhId=@WhId                  
union all                  
          
 select 0,1,m.ChkTime, m.MoveDate,m.Code,23,(case Z.IsChk when 1 then 'clBlack' else 'clRed' end),          
 '调拨出库 '+m.InWhId,null,d.Qty,null,m.billtime           
 from wh_move m           
 inner join wh_movedl d on m.Code=d.MoveId           
 inner join wh_Out    Z on Z.code=M.WhOutCode          
 where d.WareId=@WareId and m.OutWhId=@WhId                  
          
union all                  
select 0,1,m.ChkTime, m.InDate,m.Code,21,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),t.WhName+' '+IsNull(m.ClientName,''),d.Qty,null,null,billtime     
from wh_in m inner join wh_indl d on m.Code=d.InId left outer join wh_inout t on m.InTypeId=t.code where d.WareId=@WareId and t.sys=0 and m.WhId=@WhId                  
union all           
select 0,1,m.ChkTime, m.OutDate,m.Code,22,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),t.WhName+' '+IsNull(m.ClientName,''),null,d.Qty,null ,billtime     
from wh_out m inner join wh_outdl d on m.Code=d.OutId left outer join wh_inout t on m.OutTypeId=t.Code where d.WareId=@WareId and t.sys=0 and m.WhId=@WhId                  
              
              
union all                  
select 0,1,xdate,xDate,'',-1,'clBlack','盘盈增加 '+BillmanId,Qty,null,null ,xDate from wh_regulate where WareId=@WareId and WhId=@WhId and Qty>0                  
union all                  
select 0,1,xdate,xDate,'',-1,'clBlack','盘亏减少 '+BillmanId,null,abs(Qty),null ,xDate from wh_regulate where WareId=@WareId and WhId=@WhId and Qty<0                  
order by xOrder,xDate                  
                  
if @Filters='实际库存'                   
  delete from #tmp where FntClr='clRed'                  
                  
select top 0 xOrder,IsCalc,  ChkTime, xDate,BillCode,BillId,FntClr,Brief,InQty,OutQty,RmnQty  ,billtime into #Rpt from #tmp                   
        
insert into #Rpt         
select xOrder,IsCalc,ChkTime,xDate,BillCode,BillId,FntClr,Brief,InQty,OutQty,RmnQty  ,billtime from #tmp                   
union all                  
select 1,1,null,null,null,-1,'clBlack','结余',null,null,(select sum(IsNull(InQty,0))-sum(IsNull(OutQty,0)) from #tmp)  ,null                
order by xOrder               
                  
                  
select *From #Rpt   order by xOrder,xDate      
        
drop table #Rpt         
drop table #tmp 