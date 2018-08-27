/*
select m.Code,m.WhId,d.WareId,d.Qty,isnull( m.FQtyChk , m.IsChk ) as isChk into #tmp2 
from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId	where m.billtime>='2014-1-13'
                        
union all                          
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk 
from ph_return m inner join ph_returndl d on m.Code=d.ReturnId   where m.billtime>='2014-1-13'                      
union all                          
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk 
from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId  where m.billtime>='2014-1-13'                       
union all                          
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk 
from sl_return m inner join sl_returndl d on m.Code=d.ReturnId    where m.billtime>='2014-1-13'                 
union all                          
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk 
from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId    where m.billtime>='2014-1-13'                    
union all                          
                        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId 
where m.InTypeId in (select Code from wh_inout where code='I02') and   m.billtime>='2014-1-13'                         
union all                          
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId 
where m.OutTypeId in (select Code from wh_inout where code='X02') and   m.billtime>='2014-1-13'                        
                        
union all                          
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId
 where m.InTypeId in (select Code from wh_inout where sys=0) and   m.billtime>='2014-1-13'                             
union all                          
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId 
where m.OutTypeId in (select Code from wh_inout where sys=0) and   m.billtime>='2014-1-13'                           
																   
							--   select * from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout 
					
*/
 

-- select F_ID,FwhinCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FMainQty,Fprice,FWhCode,Fnote from erpUserData.dbo.Twhindl
go
delete erpUserData.dbo.Twhin 
go

insert into erpUserData.dbo.Twhin(F_ID,FWhinCode,FWhCode,FisSys,FVendorCode,FinDate,FinEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt )
--采购入库
select newid(), m.Code,m.WhId,1,m.clientid,m.ArriveDate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,'I01' ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end   ,1 ,m.TaxRate*100  ,GetFund
from [122.234.137.80,7709].jbhzuserdata.dbo.ph_arrive m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all  --销售退货
select newid(), m.Code,m.WhId,1,m.clientid,m.returndate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,'I03' ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end  ,1 ,m.TaxRate*100,GetFund
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_return m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all	 --调拨入库单			 没有客商
select newid(), m.Code,m.WhId,1,m.clientid,m.indate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,m.InTypeId ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1	 , 0,WareFund
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_in m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.InTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where code='I02') and   m.billtime>='2014-1-13'   and m.chktime<'2014-4-1'
union all	 --晶贝入库单
select newid(), m.Code,m.WhId,1,m.clientid,m.indate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,m.InTypeId ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end  ,1 ,m.TaxRate*100,WareFund
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_in m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
 where m.InTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where sys=0) and   m.billtime>='2014-1-13'    and m.chktime<'2014-4-1'


go     
 delete erpUserData.dbo.Twhindl
go
insert into  erpUserData.dbo.Twhindl 
(F_ID,FwhinCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FMainQty,Fprice,FWhCode,Fnote ,FTaxRate)
--采购入库
select newid(),  m.Code,d.wareid, wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from [122.234.137.80,7709].jbhzuserdata.dbo.ph_arrive m 
inner join [122.234.137.80,7709].jbhzuserdata.dbo.ph_arrivedl d on m.Code=d.ArriveId	
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id 
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all -- 销售退货
select newid(),  m.Code,d.wareid, wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_return m 
inner join [122.234.137.80,7709].jbhzuserdata.dbo.sl_returndl d on m.Code=d.returnId	
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id 
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all	-- 调拨入库
select newid(), m.Code, m.WhId,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_in m  
join [122.234.137.80,7709].jbhzuserdata.dbo.wh_indl d on m.code=d.inid 
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.InTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where code='I02') and   m.billtime>='2014-1-13'   and m.chktime<'2014-4-1'
  union all	   --晶贝 入库单
  select newid(), m.Code, m.WhId,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_in m  
join [122.234.137.80,7709].jbhzuserdata.dbo.wh_indl d on m.code=d.inid 
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where m.InTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where sys=0) and   m.billtime>='2014-1-13'    and m.chktime<'2014-4-1'
		






----出库
-- select F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt from erpUserData.dbo.TWhOutM
go
delete erpUserData.dbo.TWhOutM
go
insert into erpUserData.dbo.TWhOutM
(F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt)
--采购退货
select newid(), m.code,m.whid,1,m.clientid,m.returnDate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X03', 0, case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1,m.TaxRate*100,	m.GetFund
from [122.234.137.80,7709].jbhzuserdata.dbo.ph_return m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all	-- 销售出库
select newid(), m.code,m.whid,1,m.clientid,m.invoicedate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X01', 0, case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1,m.TaxRate*100,	m.GetFund
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_invoice m 
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all  --零售
select newid(), m.code,m.whid,1,'',m.retaildate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X00', 0, 1 ,1,m.TaxRate*100,	m.GetFund
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_retail m			  
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all --调拨出库
select newid(), m.code,m.whid,1,'',m.outdate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   m.outTypeId, 0, 1 ,1,0 ,	m.WareFund
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_out m			  
where   m.OutTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where code='X02')  
and m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all --出库单
select newid(), m.code,m.whid,1,'',m.outdate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   m.outTypeId, 0, 1 ,1,0 ,	m.WareFund
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_out m	 where m.OutTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where sys=0) 
and m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'





-- select F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate from erpUserData.dbo.TWhOutDL
 go
 delete		  erpUserData.dbo.TWhOutDL
 go
insert into erpUserData.dbo.TWhOutDL
(F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate,FinOutTypeCode)
--采购退货
select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100	 ,'X03'
from [122.234.137.80,7709].jbhzuserdata.dbo.ph_return m
inner join [122.234.137.80,7709].jbhzuserdata.dbo.ph_returndl d on m.Code=d.ReturnId   
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
 union all --销售出库
 select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100 , 'X01'
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_invoice m
inner join [122.234.137.80,7709].jbhzuserdata.dbo.sl_invoicedl d on m.Code=d.invoiceid   
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
 union all --   零售
select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100	 ,'X00'
from [122.234.137.80,7709].jbhzuserdata.dbo.sl_retail m
inner join [122.234.137.80,7709].jbhzuserdata.dbo.sl_retaildl d on m.Code=d.RetailId   
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union all -- 调拨出库
select  newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,0 ,m.outtypeid
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_out m
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wh_outdl d on m.Code=d.outid   
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where   m.OutTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where code='X02')  
and m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1'
union --出库单
select  newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,0  ,m.outtypeid
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_out m
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wh_outdl d on m.Code=d.outid   
inner join [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where m.OutTypeId in (select Code from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout where sys=0) 
and m.billtime>='2014-1-13'   and m.ischk=1 and m.chktime<'2014-4-1' 


/*
导入期初
delete erpUserData.dbo.TInvCostAcctMonthEndClose
select * from erpUserData.dbo.TInvCostAcctMonthEndClose

delete erpUserData.dbo.TMtrLStorageHis
select *from erpUserData.dbo.TMtrLStorageHis

insert into  erpUserData.dbo.TMtrLStorageHis
(F_ID,FinvCode,Fnote,FAvgPrice,FisChk,FMonth ,FWhCode,FStorage,FAmt)
  select 
  newid(),FinvCode,Fnote,FUltimoPrice ,0 ,'2013-12-1',FWhCode,FStorage	 ,FUltimoPrice*	FStorage
  from	  erpUserData.dbo.TMtrLStorage
	
*/