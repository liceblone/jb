						  
		/* 
		 select tableEname,CodeField,NameField 
		 ,'delete erpUserData.dbo.'+TableEname  +'   go '+char(13)+' insert into erpUserData.dbo.'+tableEname+'(F_ID, '+CodeField+','   +NameField+' ,FPhoneticize ) select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from [122.234.137.80,7709].jbhzuserdata.dbo.'
		  from Tallusertable	  where FisBasicTable =1	   
		  
		  
			select name+',' from TAllFields  fld join Tallusertable tbl on fld.ownerPk= tbl.pk where tbl.TableEname='TMtrLStorage'
 
		  */
		  
			  
		  
delete erpUserData.dbo.TDept
go  
insert into erpUserData.dbo.TDept(F_ID, FDeptCode,FDeptName ,FPhoneticize ) 
select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from [122.234.137.80,7709].jbhzuserdata.dbo.hr_dept
-- select * from  erpUserData.dbo.TDept  
go
		   
		 
		   
delete erpUserData.dbo.TEmployee   
go   
insert into erpUserData.dbo.TEmployee(F_ID, FEmpCode,FEmpName ,FPhoneticize,FSex,FDeptCode ) 
select newid(), code,name ,dbo.FN_GetPhoneticize(name) ,'',DeptId from [122.234.137.80,7709].jbhzuserdata.dbo.hr_employee
--select *from erpUserData.dbo.TEmployee 

go

delete erpUserData.dbo.TCltType   
go   
insert into erpUserData.dbo.TCltType(F_ID, FCltTypeCode,FCltTypeName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from [122.234.137.80,7709].jbhzuserdata.dbo.crm_clientclass 
-- select *from erpUserData.dbo.TCltType   


go
delete erpUserData.dbo.TClient  
go   

select newid() F_ID, code,name ,dbo.FN_GetPhoneticize(name) as Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId into #tmpClt
from [122.234.137.80,7709].jbhzuserdata.dbo.crm_client			 where ClassId='01'	 

update  #tmpClt set name = name+code   where name in (
  select  name						 
  from [122.234.137.80,7709].jbhzuserdata.dbo.crm_client			 where ClassId='01'	  
   group by name having count(*)>1 
)

 insert into erpUserData.dbo.TClient(F_ID, FCltCode,FCltName ,FPhoneticize,FLinkMan ,FTel,FFax,FTaxId ,FBankAccount ,FBank ,FAddr ,FCltTypeCode )
 select F_ID, code,name ,  Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr  ,ClassId from #tmpClt
 
drop table #tmpClt

go



delete erpUserData.dbo.TCity   
go   
insert into erpUserData.dbo.TCity(F_ID, FCityCode,FCityName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from [122.234.137.80,7709].jbhzuserdata.dbo.co_region 
-- select * from erpUserData.dbo.TClient  

go


delete erpUserData.dbo.TInvType 
go
      
select newid() as F_ID , code,name ,dbo.FN_GetPhoneticize(name) Phoneticize ,PriceRate ,1 as FisMtrl into #tmo 
from [122.234.137.80,7709].jbhzuserdata.dbo.wr_class 
								 	 
update #tmo set Name =Name+code where name in (select name from #tmo group by name having count(*)>1)
	
insert into erpUserData.dbo.TInvType(F_ID, FInvTypeCode,FInvTypeName ,FPhoneticize ,FProfixRate, FisMtrl)
select  F_ID , code,name , Phoneticize ,PriceRate , FisMtrl from #tmo
		
drop table #tmo

--	select * from erpUserData.dbo.TInvType 


go
delete erpUserData.dbo.TInventory  
go   
							    


insert into erpUserData.dbo.TInventory
(FisMtrl  ,F_ID, FInvCode,FInvName ,FPhoneticize       ,FcolorCode, FGoodCode 
,FBrand,FOrigin ,FMainUnitCode,FSafetyStock ,FMaxStock,FMinStock,FProfitRate,  FNote,FinvTypeCode) 
select 1,newid(), id,model ,dbo.FN_GetPhoneticize(model)  ,PartNo ,	 pack           ,  Brand  ,Origin ,Unit ,SafePos ,MaxPos
,MinPos ,PriceRate ,  Note   ,Classid 
from [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware		  where IsUse=1

-- select * from erpUserData.dbo.TInventory  

go

delete erpUserData.dbo.TVendorType   
go   
insert into erpUserData.dbo.TVendorType(F_ID, FVendorTypeCode,FVendorTypeName ,FPhoneticize )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name)  from [122.234.137.80,7709].jbhzuserdata.dbo.crm_clientclass 

-- select * from erpUserData.dbo.TVendorType 

/*
delete erpUserData.dbo.TUnit   go 
  insert into erpUserData.dbo.TUnit(F_ID, FUnitCode,FUnitName ,FPhoneticize )
   select distinct newid(), code,unit ,dbo.FN_GetPhoneticize(unit) 
   from [122.234.137.80,7709].jbhzuserdata.dbo.wr_ware
*/

go
  
delete erpUserData.dbo.TWareHouse  
 go   
insert into erpUserData.dbo.TWareHouse(F_ID, FWhCode,FWhName ,FPhoneticize,FDeptCode )
 select newid(), code,name ,dbo.FN_GetPhoneticize(name) ,DeptId  from [122.234.137.80,7709].jbhzuserdata.dbo.wh_warehouse 
 
--    select *From erpUserData.dbo.TWareHouse
						 
go 


delete erpUserData.dbo.TVendor 
go								    
 select newid() F_ID, code,name ,dbo.FN_GetPhoneticize(name) as Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId into #tmpvd
 from [122.234.137.80,7709].jbhzuserdata.dbo.crm_client			 where ClassId in ('02' ,'03' ,'04','06')
 	 
 insert into erpUserData.dbo.TVendor(F_ID, FVendorCode,FVendorName ,FPhoneticize, FLinkMan ,FTel,FFax,FTaxId ,FBankAccount ,FBank ,FAddr ,FVendorTypeCode )
 select F_ID, code,name ,  Phoneticize,LinkMan ,Tel ,Fax ,  TaxId ,Bankid ,Bank  ,Addr ,ClassId  from #tmpvd

 drop table #tmpvd

-- select  * from	erpUserData.dbo.TVendor 

go

delete erpUserData.dbo.TinOutType   
go  

 insert into erpUserData.dbo.TinOutType(F_ID, FinOutTypeCode,FinOutTypeName ,FPhoneticize ,Fisin, FisSys) 
 select newid(), code,whname ,dbo.FN_GetPhoneticize(whname) ,inout ,[sys] from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inout
 
-- select * from erpUserData.dbo.TinOutType

go

delete erpUserData.dbo.TGLC 

insert into erpUserData.dbo.TGLC(F_ID, FGlCcode, FGLCname  ,FPhoneticize  ,FNote) 
select newid(),code,name,dbo.FN_GetPhoneticize(name) , note from [122.234.137.80,7709].jbhzuserdata.dbo.fn_item 

-- select  *from erpUserData.dbo.TGLC

go


delete  erpUserData.dbo.TMtrLStorage
go
 -- FAvgPrice,FLstPrice,

insert into  erpUserData.dbo.TMtrLStorage	 (f_id, FinvCode,FUltimoBalce,FUltimoPrice,    FWhCode ,FNote  ) 
select newid(),dl.wareid,dl.qty , 0 , m.whid, m.note   
from [122.234.137.80,7709].jbhzuserdata.dbo.wh_inventroy  m 
join [122.234.137.80,7709].jbhzuserdata.dbo.wh_inventroydl dl on m.code =dl.invid   where billTime>='2014-1-1'
 
 update erpUserData.dbo.TMtrLStorage set FUltimoPrice =	case when isnull(wr.price,0)=0 then wr.cost else wr.price end
 from 	erpUserData.dbo.TMtrLStorage  stg join	[122.234.137.80,7709].jbhzuserdata.dbo.wr_ware20140116 wr on stg.FinvCode = wr.id
 
 
 ---  select * from erpUserData.dbo.TMtrLStorage	 where isnull(FUltimoPrice   ,0)=0

go
																															  
					
