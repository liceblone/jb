						  
		/* 
		 select tableEname,CodeField,NameField 
		 ,'delete erpUserData.dbo.'+TableEname  +'   go '+char(13)+' insert into erpUserData.dbo.'+tableEname+'(F_ID, '+CodeField+','   +NameField+' ,FPhoneticize ) select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from  jbhzuserdata.dbo.'
		  from Tallusertable	  where FisBasicTable =1	   
		  
		  
			select name+',' from TAllFields  fld join Tallusertable tbl on fld.ownerPk= tbl.pk where tbl.TableEname='TMtrLStorage'
 
		  */
use erpUserData
go		  
			  
		  
delete erpUserData.dbo.TDept
go  
insert into erpUserData.dbo.TDept(F_ID, FDeptCode,FDeptName ,FPhoneticize ) 
select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from  jbhzuserdata.dbo.hr_dept
-- select * from  erpUserData.dbo.TDept  
go
		   
		 
		   
delete erpUserData.dbo.TEmployee   
go   
insert into erpUserData.dbo.TEmployee(F_ID, FEmpCode,FEmpName ,FPhoneticize,FSex,FDeptCode ) 
select newid(), code,name ,dbo.FN_GetPhoneticize(name) ,'',DeptId from  jbhzuserdata.dbo.hr_employee
--select *from erpUserData.dbo.TEmployee 

go

delete erpUserData.dbo.TCltType   
go   
insert into erpUserData.dbo.TCltType(F_ID, FCltTypeCode,FCltTypeName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from  jbhzuserdata.dbo.crm_clientclass 
-- select *from erpUserData.dbo.TCltType   


go
delete erpUserData.dbo.TClient  
go   

select newid() F_ID, code,name ,dbo.FN_GetPhoneticize(name) as Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId into #tmpClt
from  jbhzuserdata.dbo.crm_client			 where ClassId='01'	 

update  #tmpClt set name = name+code   where name in (
  select  name						 
  from  jbhzuserdata.dbo.crm_client			 where ClassId='01'	  
   group by name having count(*)>1 
)

 insert into erpUserData.dbo.TClient(F_ID, FCltCode,FCltName ,FPhoneticize,FLinkMan ,FTel,FFax,FTaxId ,FBankAccount ,FBank ,FAddr ,FCltTypeCode )
 select F_ID, code,name ,  Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr  ,ClassId from #tmpClt
 
  insert into erpUserData.dbo.TClient(F_ID, FCltCode,FCltName ,FPhoneticize,FCltTypeCode )
 select NEWID(), 'C000000','临时客户','lskh' ,  '01'
 
drop table #tmpClt

go



delete erpUserData.dbo.TCity   
go   
insert into erpUserData.dbo.TCity(F_ID, FCityCode,FCityName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from  jbhzuserdata.dbo.co_region 
-- select * from erpUserData.dbo.TClient  

go


delete erpUserData.dbo.TInvType 
go
      
select newid() as F_ID , code,name ,dbo.FN_GetPhoneticize(name) Phoneticize ,PriceRate ,1 as FisMtrl into #tmo 
from  jbhzuserdata.dbo.wr_class 
								 	 
update #tmo set Name =Name+code where name in (select name from #tmo group by name having count(*)>1)
	
insert into erpUserData.dbo.TInvType(F_ID, FInvTypeCode,FInvTypeName ,FPhoneticize ,FProfixRate, FisMtrl)
select  F_ID , code,name , Phoneticize ,PriceRate , FisMtrl from #tmo
		
drop table #tmo

--	select * from erpUserData.dbo.TInvType 




go

delete erpUserData.dbo.TVendorType   
go   
insert into erpUserData.dbo.TVendorType(F_ID, FVendorTypeCode,FVendorTypeName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from  jbhzuserdata.dbo.crm_clientclass 

-- select * from erpUserData.dbo.TVendorType 

/*
delete erpUserData.dbo.TUnit   go 
  insert into erpUserData.dbo.TUnit(F_ID, FUnitCode,FUnitName ,FPhoneticize )
   select distinct newid(), code,unit ,dbo.FN_GetPhoneticize(unit) 
   from  jbhzuserdata.dbo.wr_ware
*/

go
  
delete erpUserData.dbo.TWareHouse  
 go   
insert into erpUserData.dbo.TWareHouse(F_ID, FWhCode,FWhName ,FPhoneticize,FDeptCode )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name) ,DeptId  from  jbhzuserdata.dbo.wh_warehouse 
 
 update erpUserData.dbo.TWareHouse  set FDEL =1 where FWhCode   in('003','005')
 update erpUserData.dbo.TWareHouse  set FNeedCostAccounting =1 where FWhCode  not in('003','005')
--    select *From erpUserData.dbo.TWareHouse
						 
go 


delete erpUserData.dbo.TVendor 
go								    
 select newid() F_ID, code,name ,dbo.FN_GetPhoneticize(name) as Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId into #tmpvd
 from  jbhzuserdata.dbo.crm_client			 where ClassId in ('02' ,'03' ,'04','06')
 	 
 insert into erpUserData.dbo.TVendor(F_ID, FVendorCode,FVendorName ,FPhoneticize, FLinkMan ,FTel,FFax,FTaxId ,FBankAccount ,FBank ,FAddr ,FVendorTypeCode )
 select F_ID, code,name ,  Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId  from #tmpvd

insert into erpUserData.dbo.TVendor(F_ID, FVendorCode,FVendorName ,FPhoneticize,FVendorTypeCode )
 select NEWID(),'Vd000000','内部调整','nbtz','02'


 drop table #tmpvd

-- select  * from	erpUserData.dbo.TVendor 

go

delete erpUserData.dbo.TinOutType   
go  

 insert into erpUserData.dbo.TinOutType(F_ID, FinOutTypeCode,FinOutTypeName ,FPhoneticize ,Fisin, FisSys) 
 select newid(), code,whname ,dbo.FN_GetPhoneticize(whname) ,inout ,[sys] from  jbhzuserdata.dbo.wh_inout
 
-- select * from erpUserData.dbo.TinOutType

go

delete erpUserData.dbo.TGLC 

insert into erpUserData.dbo.TGLC(F_ID, FGlCcode, FGLCname  ,FPhoneticize  ,FNote) 
select newid(),code,name,dbo.FN_GetPhoneticize(name) , note from  jbhzuserdata.dbo.fn_item 

-- select  *from erpUserData.dbo.TGLC

go



-----------------------------------------
----IO-----------------------------------
-----------------------------------------

go

declare @FMonth smalldatetime
set @FMonth ='2014-3-1'
--select * 
 delete	erpUserData.dbo.Twhindl from erpUserData.dbo.Twhindl dl join erpUserData.dbo.Twhin m on m.FWhinCode=dl.FWhinCode where dbo.Fn_MonthEqual(  m.fchktime, @FMonth)=1
 delete erpUserData.dbo.Twhin    where   dbo.Fn_MonthEqual(  fchktime, @FMonth)=1
 
 
insert into erpUserData.dbo.Twhin(F_ID,FWhinCode,FWhCode,FisSys,FVendorCode,FinDate,FinEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt )
--采购入库
select newid(), m.Code,m.WhId,1,m.clientid,m.ArriveDate,m.HandManId ,
1,m.ChkTime,m.ChkManId ,m.billmanid, m.billtime,'I01' ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end   ,1 ,m.TaxRate*100  ,GetFund
from  jbhzuserdata.dbo.ph_arrive m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.FQtyChk =1and dbo.Fn_MonthEqual(  m.ChkTime, @FMonth)=1
union all  --销售退货
select newid(), m.Code,m.WhId,1,m.clientid,m.returndate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,'I03' ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end  ,1 ,m.TaxRate*100,GetFund
from  jbhzuserdata.dbo.sl_return m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all	 --调拨入库单			 没有客商
select newid(), whmove.Code,m.WhId,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end ,m.indate,m.HandManId ,
1,whmove.chktime,whmove.Chkmanid ,m.billmanid, m.billtime,m.InTypeId ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1	 , 0,whmove.WareFund
from  jbhzuserdata.dbo.wh_in m  
join  JbHzUserData.dbo.wh_move whmove on m.Code = whmove.WhInCode
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.InTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where code='I02') and   m.billtime>='2014-1-13'   and  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all	 --晶贝入库单
select newid(), m.Code,m.WhId,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end,m.indate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,m.InTypeId ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end  ,1 ,m.TaxRate*100,WareFund
from  jbhzuserdata.dbo.wh_in m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
 where m.InTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where sys=0) and   m.billtime>='2014-1-13'    and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1


     
 
insert into  erpUserData.dbo.Twhindl 
(F_ID,FwhinCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FMainQty,Fprice,FWhCode,Fnote ,FTaxRate)
--采购入库
select newid(),  m.Code,d.wareid, wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from  jbhzuserdata.dbo.ph_arrive m 
inner join  jbhzuserdata.dbo.ph_arrivedl d on m.Code=d.ArriveId	
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id 
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all -- 销售退货
select newid(),  m.Code,d.wareid, wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from  jbhzuserdata.dbo.sl_return m 
inner join  jbhzuserdata.dbo.sl_returndl d on m.Code=d.returnId	
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id 
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all	-- 调拨入库
select newid(), whmove.Code, d.wareid ,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from  jbhzuserdata.dbo.wh_in m  
join  jbhzuserdata.dbo.wh_indl d on m.code=d.inid 
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
inner join  JbHzUserData.dbo.wh_move whmove on m.Code = whmove.WhInCode
where m.InTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where code='I02') and   m.billtime>='2014-1-13'   and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
  union all	   --晶贝 入库单
  select newid(), m.Code,d.wareid ,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from  jbhzuserdata.dbo.wh_in m  
join  jbhzuserdata.dbo.wh_indl d on m.code=d.inid 
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where m.InTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where sys=0) and   m.billtime>='2014-1-13'    and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
		






----出库
-- select F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt from erpUserData.dbo.TWhOutM

 delete	erpUserData.dbo.TWhOutDL from erpUserData.dbo.TWhOutDL dl join erpUserData.dbo.TWhOutM m on m.FWhOutCode=dl.FWhOutCode where dbo.Fn_MonthEqual(  fchktime, @FMonth)=1
 delete erpUserData.dbo.TWhOutM    where   dbo.Fn_MonthEqual(  fchktime, @FMonth)=1

 insert into erpUserData.dbo.TWhOutM
(F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt)
--采购退货
select newid(), m.code,m.whid,1,m.clientid,m.returnDate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X03', 0, case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1,m.TaxRate*100,	m.GetFund
from  jbhzuserdata.dbo.ph_return m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all	-- 销售出库
select newid(), m.code,m.whid,1,m.clientid,m.invoicedate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X01', 0, case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end ,1,m.TaxRate*100,	m.GetFund
from  jbhzuserdata.dbo.sl_invoice m 
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all  --零售
select newid(), m.code,m.whid,1,'C000000',m.retaildate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   'X01', 0, 1 ,1,m.TaxRate*100,	m.GetFund
from  jbhzuserdata.dbo.sl_retail m			  
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all --调拨出库
select newid(), whmove.Code ,m.whid,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end ,m.outdate, m.billmanid ,
m.ischk,whmove.chkTime,m.chkmanid,m.billmanid,m.billTime,   m.outTypeId, 0, 1 ,1,0 ,	m.WareFund
from  jbhzuserdata.dbo.wh_out m	
inner join  JbHzUserData.dbo.wh_move whmove on m.Code = whmove.WhOutCode
where   m.OutTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where code='X02')  
and m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all --出库单
select newid(), m.code,m.whid,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end,m.outdate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   m.outTypeId, 0, 1 ,1,0 ,	m.WareFund
from  jbhzuserdata.dbo.wh_out m	 where m.OutTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where sys=0) 
and m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1





-- select F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate from erpUserData.dbo.TWhOutDL
 
 
  
  
 insert into erpUserData.dbo.TWhOutDL
(F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate,FinOutTypeCode)
--采购退货
select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100	 ,'X03'
from  jbhzuserdata.dbo.ph_return m
inner join  jbhzuserdata.dbo.ph_returndl d on m.Code=d.ReturnId   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
 union all --销售出库
 select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100 , 'X01'
from  jbhzuserdata.dbo.sl_invoice m
inner join  jbhzuserdata.dbo.sl_invoicedl d on m.Code=d.invoiceid   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
 union all --   零售
select newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100	 ,'X01'
from  jbhzuserdata.dbo.sl_retail m
inner join  jbhzuserdata.dbo.sl_retaildl d on m.Code=d.RetailId   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
where m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all -- 调拨出库
select  newid(),whmove.Code ,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,0 ,m.outtypeid
from  jbhzuserdata.dbo.wh_out m
inner join  jbhzuserdata.dbo.wh_outdl d on m.Code=d.outid   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
inner join  JbHzUserData.dbo.wh_move whmove on m.Code = whmove.WhOutCode
where   m.OutTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where code='X02')  
and m.billtime>='2014-1-13'   and m.ischk=1 and   dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union --出库单
select  newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,0  ,m.outtypeid
from  jbhzuserdata.dbo.wh_out m
inner join  jbhzuserdata.dbo.wh_outdl d on m.Code=d.outid   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where m.OutTypeId in (select Code from  jbhzuserdata.dbo.wh_inout where sys=0) 
and m.billtime>='2014-1-13'   and m.ischk=1  and  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1



							    


insert into erpUserData.dbo.TInventory
(FisMtrl  ,F_ID, FInvCode,FInvName ,FPhoneticize       ,FcolorCode, FGoodCode 
,FBrand,FOrigin ,FMainUnitCode,FSafetyStock ,FMaxStock,FMinStock,FProfitRate,  FNote,FinvTypeCode) 

-- declare @FMonth smalldatetime   set @FMonth ='2014-4-1'
select 1,newid(), id,model ,dbo.FN_GetPhoneticize(model)  ,PartNo ,	 pack           ,  Brand  ,Origin ,Unit ,SafePos ,MaxPos
,MinPos ,PriceRate ,  Note   ,Classid 
from  jbhzuserdata.dbo.wr_ware wr where Not exists( select *from erpUserData.dbo.TInventory where FInvCode=wr.Id)		 
and exists(
 select dl.FinvCode from erpUserData.dbo.Twhindl dl join erpUserData.dbo.Twhin m on m.FWhinCode=dl.FWhinCode 
 where dbo.Fn_MonthEqual(  fchktime, @FMonth)=1 and dl.FinvCode =wr.Id
 union 
 select dl.FinvCode from erpUserData.dbo.TWhOutDL dl join erpUserData.dbo.TWhOutM m on m.FWhOutCode=dl.FWhOutCode 
 where dbo.Fn_MonthEqual(  fchktime, @FMonth)=1 and dl.FinvCode =wr.Id
)

-- select * from erpUserData.dbo.TInventory  