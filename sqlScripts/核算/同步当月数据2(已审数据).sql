 
		  
use erpUserData
go		  
			   
		  /*
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
from  jbhzuserdata.dbo.crm_client		--	 where ClassId in('01'	 ,'03')

update  #tmpClt set name = name+code   where name in (
  select  name						 
  from  jbhzuserdata.dbo.crm_client		--	 where  ClassId in('01'	 ,'03')  
   group by name having count(*)>1 
)

 insert into erpUserData.dbo.TClient(F_ID, FCltCode,FCltName ,FPhoneticize,FLinkMan ,FTel,FFax,FTaxId ,FBankAccount ,FBank ,FAddr ,FCltTypeCode )
 select F_ID, code,name ,  Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr  ,isnull(ClassId,'') from #tmpClt
 
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
 
insert into erpUserData.dbo.TVendor(F_ID, FVendorCode,FVendorName ,FPhoneticize,FVendorTypeCode )
 select NEWID(),'Vd000000','内部调整','nbtz','02'


 

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

*/

exec Pr_SyncInfrastructureData


declare @FBeginMonth smalldatetime, @FEndMonth smalldatetime
set @FBeginMonth ='2015-3-1'
set @FEndMonth='2015-4-1'
exec Pr_SyncBusinessData @FBeginMonth ,@FEndMonth
-----------------------------------------
----IO-----------------------------------
-----------------------------------------

go
/*
declare @FBeginMonth smalldatetime, @FEndMonth smalldatetime
set @FBeginMonth ='2015-2-1'
set @FEndMonth='2015-3-1'



--PR_ImportPayReceiveAble '2014-11-1'

--select * 
 delete	erpUserData.dbo.Twhindl from erpUserData.dbo.Twhindl dl join erpUserData.dbo.Twhin m on m.FWhinCode=dl.FWhinCode where m.FChkTime>=@FBeginMonth and m.FChkTime<@FEndMonth --  dbo.Fn_MonthEqual(  m.fchktime, @FMonth)=1
 delete erpUserData.dbo.Twhin     where  fchktime>=@FBeginMonth and fchktime<@FEndMonth--  dbo.Fn_MonthEqual(  fchktime, @FMonth)=1
 
 
insert into erpUserData.dbo.Twhin(F_ID,FWhinCode,FWhCode,FisSys,FVendorCode,FinDate,FinEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt )
select newid(), m.Code,m.WhId,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end,m.indate,m.HandManId ,
1,m.chktime,Chkmanid ,m.billmanid, m.billtime,m.InTypeId ,0,case when isnull(clt.FcltCode,'')<>''   then  1 else 0 end  ,1 ,m.TaxRate*100,WareFund
from  jbhzuserdata.dbo.wh_in m  
left join erpUserData.dbo.Tclient clt on clt.FcltCode=m.clientid
 where m.IsChk=1 and  m.chktime>=@FBeginMonth and m.chktime<@FEndMonth   --  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all
select distinct NEWID(),convert(varchar(20),ID),WhId, 1,'Vd000000', xDate,BillmanId,1,xDate,BillmanId,BillmanId,xDate ,'I99',0 ,0 ,1,0,0 
from jbhzuserdata.dbo.wh_regulate where   Qty>0  and  xDate>=@FBeginMonth and xDate<@FEndMonth  -- dbo.Fn_MonthEqual( xDate, @FMonth)=1

     
 
insert into  erpUserData.dbo.Twhindl 
(F_ID,FwhinCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FMainQty,Fprice,FWhCode,Fnote ,FTaxRate)
--晶贝 入库单
  select newid(), m.Code,d.wareid ,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,m.TaxRate*100
from  jbhzuserdata.dbo.wh_in m  
join  jbhzuserdata.dbo.wh_indl d on m.code=d.inid 
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where     m.IsChk=1 and    m.chktime>=@FBeginMonth and m.chktime<@FEndMonth  --  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all
select distinct NEWID(),convert(varchar(20),d.ID),
 d.wareid,wr.Model,wr.PartNo,'',wr.Pack,d.Qty, wr.Price,d.WhId,d.Note, 0
 from jbhzuserdata.dbo.wh_regulate d 
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id   where  d.Qty>0  and   xDate>=@FBeginMonth and xDate<@FEndMonth -- dbo.Fn_MonthEqual( d.xDate, @FMonth)=1
		





----出库
-- select F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt from erpUserData.dbo.TWhOutM

 delete	erpUserData.dbo.TWhOutDL from erpUserData.dbo.TWhOutDL dl join erpUserData.dbo.TWhOutM m on m.FWhOutCode=dl.FWhOutCode where  m.fchktime>=@FBeginMonth and m.fchktime<@FEndMonth --dbo.Fn_MonthEqual(  fchktime, @FMonth)=1
 delete erpUserData.dbo.TWhOutM    where   fchktime>=@FBeginMonth and fchktime<@FEndMonth-- dbo.Fn_MonthEqual(  fchktime, @FMonth)=1

 insert into erpUserData.dbo.TWhOutM
(F_ID,FWhoutCode,FWhCode,FisSys,FCltvdCode,FoutDate,FoutEmp, 
FisChk,FChkTime,FChkEmp ,FCreateEmp,FCreateTime,FinOutTypeCode,FSumQty, FisClt,FFnisChk ,FTaxRate,Famt)
 --出库单
select newid(), m.code,m.whid,1,case when isnull(m.clientid,'')='' then 'Vd000000' else m.ClientId end,m.outdate, m.billmanid ,
m.ischk,m.chkTime,m.chkmanid,m.billmanid,m.billTime,   m.outTypeId, 0, 1 ,1,0 ,	m.WareFund
from  jbhzuserdata.dbo.wh_out m	 where   m.ischk=1  and  m.chktime>=@FBeginMonth and m.chktime<@FEndMonth --  dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all
select distinct NEWID(),convert(varchar(20),ID),WhId, 1,'Vd000000', xDate,BillmanId,1,xDate,BillmanId,BillmanId,xDate ,'X99',0 ,0 ,1,0,0 
from jbhzuserdata.dbo.wh_regulate where  Qty<0  and   xDate>=@FBeginMonth and xDate<@FEndMonth -- dbo.Fn_MonthEqual( xDate, @FMonth)=1




-- select F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate from erpUserData.dbo.TWhOutDL
 
 
  
  
 insert into erpUserData.dbo.TWhOutDL
(F_ID,FwhoutCode,FinvCode,FinvName,FGoodCode,FProductName,FColorCode,FoutQty,Fprice,FWhCode,Fnote ,FTaxRate,FinOutTypeCode)
--出库单
select  newid(),m.Code,wr.id,wr.model,wr.partno,'', wr.pack, d.qty, d.price, m.whid,d.dlNote  ,0  ,m.outtypeid
from  jbhzuserdata.dbo.wh_out m
inner join  jbhzuserdata.dbo.wh_outdl d on m.Code=d.outid   
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id  
 where  m.ischk=1  and   m.chktime>=@FBeginMonth and m.chktime<@FEndMonth -- dbo.Fn_MonthEqual(  m.chktime, @FMonth)=1
union all
select distinct NEWID(),convert(varchar(20),d.ID),
 d.wareid,wr.Model,wr.PartNo,'',wr.Pack,-d.Qty, wr.Price,d.WhId,d.Note, 0 ,'X99'
 from jbhzuserdata.dbo.wh_regulate d 
inner join  jbhzuserdata.dbo.wr_ware wr on d.wareid=wr.id 
  where   d.Qty<0  and   d.xDate>=@FBeginMonth and d.xDate<@FEndMonth -- dbo.Fn_MonthEqual( d.xDate, @FMonth)=1
		



							    


insert into erpUserData.dbo.TInventory
(FisMtrl  ,F_ID, FInvCode,FInvName ,FPhoneticize       ,FcolorCode, FGoodCode 
,FBrand,FOrigin ,FMainUnitCode,FSafetyStock ,FMaxStock,FMinStock,FProfitRate,  FNote,FinvTypeCode) 

-- declare @FMonth smalldatetime   set @FMonth ='2014-4-1'
select 1,newid(), id,model ,dbo.FN_GetPhoneticize(model)  ,PartNo ,	 pack           ,  Brand  ,Origin ,Unit ,SafePos ,MaxPos
,MinPos ,PriceRate ,  Note   ,Classid 
from  jbhzuserdata.dbo.wr_ware wr where Not exists( select *from erpUserData.dbo.TInventory where FInvCode=wr.Id)		 
and exists(
 select dl.FinvCode from erpUserData.dbo.Twhindl dl join erpUserData.dbo.Twhin m on m.FWhinCode=dl.FWhinCode 
 where  dl.FinvCode =wr.Id and   m.fchktime>=@FBeginMonth and m.fchktime<@FEndMonth  --dbo.Fn_MonthEqual(  fchktime, @FMonth)=1 and
 union 
 select dl.FinvCode from erpUserData.dbo.TWhOutDL dl join erpUserData.dbo.TWhOutM m on m.FWhOutCode=dl.FWhOutCode 
 where dl.FinvCode =wr.Id  and  m.fchktime>=@FBeginMonth and m.fchktime<@FEndMonth  --dbo.Fn_MonthEqual(  fchktime, @FMonth)=1 and 
)

-- select * from erpUserData.dbo.TInventory  


  

delete from ERPUserData.dbo.TMtrLStorageHisCorrection  where FMonth>=@FBeginMonth and FMonth<@FEndMonth ---dbo.[Fn_MonthEqual]( FMonth ,@Fmonth)=1
and  finvcode in (select wareid from   JbHzUserData.dbo.TCostChangeLog  cost where DATEADD(m,-1,Fcreatetime)>=@FBeginMonth and DATEADD(m,-1,Fcreatetime)<@FEndMonth) --dbo.[Fn_MonthEqual]( DATEADD(m,-1,Fcreatetime),  @Fmonth)=1)

--select *from ERPUserData.dbo.TMtrLStorageHisCorrection  where dbo.[Fn_MonthEqual]( FMonth ,@Fmonth)=1

insert into  ERPUserData.dbo.TMtrLStorageHisCorrection (FMonth, FAvgPrice,FInvCode,FStorage, FChkTime, FWhCode,FisChk,FStoragePkgQty, FNote)
select DATEADD(m,-1,Fcreatetime), cost, wareid, null, DATEADD(m,-1,Fcreatetime), wh.Code,1, null, '销售系统价格更新'
 from JbHzUserData.dbo.TCostChangeLog  cost
 , JbHzUserData.dbo.wh_warehouse wh 
  where DATEADD(m,-1,Fcreatetime)>=@FBeginMonth and DATEADD(m,-1,Fcreatetime)<@FEndMonth   -- dbo.[Fn_MonthEqual]( DATEADD(m,-1,Fcreatetime),  @Fmonth)=1
  
  
  
  
  
   
*/