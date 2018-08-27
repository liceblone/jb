  select* from TJJ
  
    select name+',',* from syscolumns where id=object_id('TJJ')
    
delete TJD

insert into TJD
(F_ID,FFile_ID,FTransmission_Date,FSCM_Customer_Code,FPart_No_JSF_PN,FInventory_Status,F_Category,FInventory_Quantity,FCurrency_Code,
FInventory_Price,FInventory_Amount,FInventory_Confirmation_Date,FUpdated_Date,FDisti_Internal_Key,FFiller,FToDate,FFromDate)
select  newid(),'JD', GETDATE(),shipto.FEndSeqnCode ,inv.FInvName ,'RE','+',  stg.FStorage,  'USD'
,isnull(stg.FAvgPrice,0) ,ISNULL( stg.FAvgPrice* stg.FStorage,0) ,  getdate() ,GETDATE(), '' ,'',  GETDATE(),GETDATE()  
from TInventory   inv
join  TMtrLStorage stg on inv.FInvCode=stg.FinvCode
join TShipTo shipTo on inv.FShipTo=shipTo.FShipto


update TJD set FTxtValue=null
exec Pr_CreateTxtValue 'JD'
select *from TJD

    
go
----------JJ

delete TJJ

insert into TJJ	(
F_ID,FFile_ID,FSCM_Customer_Code,FPart_No_JSF_PN,FCO_No,FSequence_No_of_CO_ship,FGoods_Receipt_Date,
F_Category,FGoods_Receipt_Quantity,FNot__used_1,FNot__used_2,FNot__used_3,FUpdate_Date,FDisti_Internal_Key,
FFiller,FToDate,FFromDate,FTxtValue,FIsSent,FTransmission_Date)
select 
newid(), 'JJ'  , replace(shipTo.FEndSeqnCode,'HW','CC')	,inv.FinvName,	m.FCONO, right(DL.FWhinCode,4),M.FInDate
,'+',DL.FMainQty, 'JPY','0000000000000','0000000000000000',getdate(),''
,'' ,getdate(),getdate(),null,0,getdate()
from TWhin M 
join TwhinDL DL on M.FWhinCode=DL.FWhinCode
join Tinventory inv on DL.FInvCode=inv.FInvCode
join TShipTo     shipTo on shipTo.FShipTo =inv. FShipTo
where M.FInDate>'2013-8-10'

  update TJJ set FTxtValue=null
exec Pr_CreateTxtValue 'JJ'
select *from TJJ


go
----------------JB

select name+',',* from syscolumns where id=object_id('TJB')

delete TJB

insert into TJB
(F_ID,FFile_ID,FSO_No,FSequence_No_of_SO_ship,FSCM_Customer_Code,FPart_No_JSF_PN,FBooking_Date,FRequest_Delivery_Date,FShip_date
,F_Category,FShip_Quantity,FSO_Document_Category,FSCM_Process_Code,FUpdate_Date,FDisti_Internal_Key
,FFiller,FFromDate,FToDate,FTxtValue,FIsSent,FTransmission_Date)
select 
newid(), 'JB' ,M.FWhOutCode ,right(DL.FWhOutCode,4) , replace(shipTo.FEndSeqnCode,'HW','CC')	,inv.FinvName,	 M.FOutDate,M.FOutDate,M.FOutDate
,'+',DL.FOutQty, 'A','01',getdate(),''
,'' ,getdate(),getdate(),null,0,getdate()
from TWhOutM M 
join TwhOutDL DL on M.FWhOutCode=DL.FWhOutCode
join Tinventory inv on DL.FInvCode=inv.FInvCode
join TShipTo     shipTo on shipTo.FShipTo =inv. FShipTo
where M.FoutDate>'2013-8-10'

update TJB set FTxtValue=null
exec Pr_CreateTxtValue 'JB'
select *from TJB

go

-------jz

select name+',',* from syscolumns where id=object_id('TJZ')

select F_ID,FFile_ID,FDetailed_File_ID,FRecord_Count,F_Category_Quantity,FTotal_Quantity,F_Category_Amount,FTotal_Amount,FData_Input_Date,FFiller from TJZ

delete TJZ

insert into TJZ
(F_ID,FFile_ID,FDetailed_File_ID,FRecord_Count,F_Category_Quantity,FTotal_Quantity
,F_Category_Amount,FTotal_Amount,FData_Input_Date,FFiller ,FFromDate,FToDate,FTxtValue,FIsSent,FTransmission_Date)

select newid(),'JZ','JA' , 0 ,'+' ,	0
,'+' ,	0,getdate(),''  ,getdate(),getdate(),null, null,getdate()  
union all
select newid(),'JZ','JC' , 0 ,'+' ,	0
,'+' ,	0,getdate(),''  ,getdate(),getdate(),null, null,getdate()  
union all
select newid(),'JZ','JB' , isnull((select count(*) from TJB ),0) ,'+' ,	isnull((select sum(convert(decimal(19,6),FShip_Quantity)) from TJB ),0)
,'+' ,	isnull((select sum(convert(decimal(19,6),FShip_Quantity)) from TJB ),0),getdate(),''  ,getdate(),getdate(),null, null,getdate()  
union all
select newid(),'JZ','JD' , isnull((select count(*) from TJD ),0) ,'+' ,	isnull((select sum(convert(decimal(19,6),Finventory_Quantity)) from TJD ),0)
,'+' ,	isnull((select sum(convert(decimal(19,6),Finventory_Amount)) from TJD ),0),getdate(),''  ,getdate(),getdate(),null, null,getdate()  
union all
select newid(),'JZ','JJ' , isnull((select count(*) from TJJ ),0) ,'+' ,	isnull((select sum(convert(decimal(19,6),FGoods_Receipt_Quantity)) from TJJ ),0)
,'+' ,	isnull((select sum(convert(decimal(19,6),FGoods_Receipt_Quantity)) from TJJ ),0),getdate(),'' ,getdate(),getdate(),null, null,getdate()  



 update TJZ set FTxtValue=null
exec Pr_CreateTxtValue 'JZ'
select *from TJZ

select * from TJZ
select * from TJJ

select FGoods_Receipt_Quantity from TJJ

select Finventory_Quantity, Finventory_Price ,Finventory_Amount from TJD
 select Finventory_Quantity from TJD

go

select FTxtValue from TJB
union all
select FTxtValue from TJD
union all
select FTxtValue from TJJ
union all
select FTxtValue from TJZ


	  drop table JzFormat
	  
select * from			JzFormat
select * from TRainbowDataFormat where FFileType='JZ' or FFileType='JJ' ;
  update TRainbowDataFormat set FFormatFunction='dbo.fn_FormatTransmissionDate' where FFileType='JZ' and FRowID=8;
  update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency' where FFileType='JZ' and FRowID in (5,7);
  update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency' , [Decimal]=0 where FFileType='JZ' and FRowID in (3);
  
  
  
insert into TRainbowDataFormat
([Key],		[Item Name],
[Type],		[Start],
[Digits],	[Decimal],
[NOT_NULL],	[Default],
[Foreign Key],[Remarks],	[FFileType],[FRowID],	[FFieldName])
select [Key],
[Item Name],  [Type],
[Start],	  [Digits],
[Decimal],	  [NOT_null],
[Default],	  [Foreign Key],
[Remarks],	  'JZ',
[FRowID],	  [FFieldName]   from JzFormat ;