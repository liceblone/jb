alter proc Pr_BarCodeOutSave  
@abourtstr varchar(300) output,  
@FBarCodeList varchar(1000),  
@FOutBillCode varchar(50),  
@dlid varchar(50)  ,
@OutWhId varchar(30)
as  
  
--dbo.Fn_SplitStrBySeprator(@FBarCodeList,',')    
-- select *from TBarcode where  FBillCode = 'PA00029531'      
  
  
declare @foutBillTypeID varchar(50)  
select @foutBillTypeID = sysid.F_ID from sys_id sysid where  LEFT( @FOutBillCode,2)= sysid.pre  
  
-- update foutbillcode , foutbilltypeID, foutdlid  
update TBarcode set foutbillCode=@FOutBillCode , FOutDLID=@dlid, foutBillTypeID = @foutBillTypeID, foutischk =1  
, FOutPackageBarCode = cd.f1  
from TBarcode bar  
join dbo.Fn_SplitStrBySeprator(@FBarCodeList,',')  as cd on cd.f1 =bar.FPackageBarcode  
where bar.whid =@OutWhId
  
print @foutBillTypeID  
return 1


go