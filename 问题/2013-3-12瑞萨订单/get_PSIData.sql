declare @FromDate  smalldatetime , @ToDate smalldatetime	

set @FromDate=getdate()
set @ToDate=getdate()
exec	  Pr_GetPSIData	  @FromDate, @ToDate

select FTxtValue from TJB
union
select FTxtValue from TJD
union
select FTxtValue from TJJ		 
union
select FTxtValue from TJZ

select FTxtValue,* from TJB
select FTxtValue ,*from TJD
select FTxtValue,* from TJJ
select FTxtValue ,* from TJZ
			
   delete from TJB
   delete from TJD
delete from TJJ
delete TJZ
go		    

  
alter proc Pr_GetPSIData  
@FromDate  smalldatetime ,  
@ToDate smalldatetime  
as  
  
set @FromDate  =dbo.Fn_GetDateWithoutTime( @FromDate)   
set @ToDate  = dbo.Fn_GetDateWithoutTime ( @ToDate )
-- declare @FromDate  smalldatetime   set @FromDate=getdate()  
---jd  
delete TJD    where FTransmission_Date=@FromDate  
  
insert into TJD  
(F_ID,FFile_ID,FTransmission_Date,FSCM_Customer_Code,FPart_No_JSF_PN,FInventory_Status,F_Category,FInventory_Quantity,FCurrency_Code,  
FInventory_Price,FInventory_Amount,FInventory_Confirmation_Date,FUpdated_Date,FDisti_Internal_Key,FFiller,FToDate,FFromDate)  
select  newid(),'JD', @FromDate,shipto.FEndSeqnCode ,inv.FInvName ,'RE','+',  stg.FStorage,  'USD'  
,isnull(  TPrice.Fprice ,0) ,ISNULL(  TPrice.Fprice* stg.FStorage,0) ,  @FromDate,@FromDate, '' ,'',  @ToDate,@FromDate   
from TInventory   inv  
join  TMtrLStorage stg on inv.FInvCode=stg.FinvCode  
join TShipTo shipTo on inv.FShipTo=shipTo.FShipto  
join (   
		select M.FWhCode, DL.FInvCode,   Max(DL.FPrice) FPrice 
		 From TWhin M join TWhinDL dl on M.FWhinCOde= DL.FWhinCode
		group by M.FWhCode, DL.FInvCode
		) as TPrice on stg.FWhCode =TPrice.FWhCode and inv.FInvCode=TPrice.FinvCode  

update TJD set FTxtValue=null  where FTransmission_Date=@FromDate  
exec Pr_CreateTxtValue 'JD' ,@FromDate  
--select *from TJD  
  
----jj       
delete TJJ   where FTransmission_Date=@FromDate  
  
insert into TJJ (  
F_ID,FFile_ID,FSCM_Customer_Code,FPart_No_JSF_PN,FCO_No,FSequence_No_of_CO_ship,FGoods_Receipt_Date,  
F_Category,FGoods_Receipt_Quantity,FNot__used_1,FNot__used_2,FNot__used_3,FUpdate_Date,FDisti_Internal_Key,  
FFiller,FToDate,FFromDate,FTxtValue,FIsSent,FTransmission_Date)  
select   
newid(), 'JJ'  , replace(shipTo.FEndSeqnCode,'HW','CC') ,inv.FinvName, m.FCONO,  ROW_NUMBER() over(order by dl.FCreateTime),M.FInDate  
,'+',DL.FMainQty, 'JPY','0000000000000','0000000000000000', @FromDate ,''  
,'' , @ToDate , @FromDate ,null,0, @FromDate  
from TWhin M   
join TwhinDL DL on M.FWhinCode=DL.FWhinCode  
join Tinventory inv on DL.FInvCode=inv.FInvCode  
join TShipTo     shipTo on shipTo.FShipTo =inv. FShipTo  
where M.FInDate>'2013-8-10'	   and isnull(m.FCONO,'')<>''
and M.Findate>= @FromDate and M.Findate<= @ToDate+1
  
update TJJ set FTxtValue=null   where FTransmission_Date=@FromDate  
exec Pr_CreateTxtValue 'JJ'  ,@FromDate  
--select *from TJJ   where FTransmission_Date=@FromDate  
  
----  jb  
delete TJB    where FTransmission_Date=@FromDate  
insert into TJB  
(F_ID,FFile_ID,FSO_No,FSequence_No_of_SO_ship,FSCM_Customer_Code,FPart_No_JSF_PN,FBooking_Date,FRequest_Delivery_Date,FShip_date  
,F_Category,FShip_Quantity,FSO_Document_Category,FSCM_Process_Code,FUpdate_Date,FDisti_Internal_Key  
,FFiller,FFromDate,FToDate,FTxtValue,FIsSent,FTransmission_Date)  
select   
newid(), 'JB' ,M.FWhOutCode ,right(DL.FWhOutCode,4) , replace(shipTo.FEndSeqnCode,'HW','CC') ,inv.FinvName,  M.FOutDate,M.FOutDate,M.FOutDate  
,'+',DL.FOutQty, 'A','01',getdate(),''  
,'' , @FromDate , @ToDate ,null,0, @FromDate  
from TWhOutM M   
join TwhOutDL DL on M.FWhOutCode=DL.FWhOutCode  
join Tinventory inv on DL.FInvCode=inv.FInvCode  
join TShipTo     shipTo on shipTo.FShipTo =inv. FShipTo  
where M.FoutDate>'2013-8-10'     and M.FoutDate>= @FromDate and M.FoutDate<= @ToDate+1
  
update TJB set FTxtValue=null   where FTransmission_Date=@FromDate  
exec Pr_CreateTxtValue 'JB',@FromDate  
--select *from TJB   where FTransmission_Date=@FromDate  
  
  
  
-------jz  
  
  
delete TJZ where FTransmission_Date=@FromDate  
  
insert into TJZ  
(F_ID,FFile_ID,FDetailed_File_ID,FRecord_Count,F_Category_Quantity,FTotal_Quantity  
,F_Category_Amount,FTotal_Amount,FData_Input_Date,FFiller ,FFromDate,FToDate,FTxtValue,FIsSent,FTransmission_Date)  
select newid(),'JZ','JA' , 0 ,'+' , 0  
,'+' , 0, @FromDate ,''  , @FromDate  ,  @ToDate ,null, null,  @FromDate  
union all  
select newid(),'JZ','JC' , 0 ,'+' , 0  
,'+' , 0, @FromDate ,''  , @FromDate , @ToDate ,null, null,@FromDate   
union all  
select newid(),'JZ','JB' , isnull((select count(*) from TJB ),0) ,'+' , isnull((select sum(convert(decimal(19,6),FShip_Quantity)) from TJB ),0)  
,'+' , isnull((select sum(convert(decimal(19,6),FShip_Quantity)) from TJB ),0), @FromDate ,''  , @FromDate , @ToDate ,null, null, @FromDate    
union all  
select newid(),'JZ','JD' , isnull((select count(*) from TJD ),0) ,'+' , isnull((select sum(convert(decimal(19,6),Finventory_Quantity)) from TJD ),0)  
,'+' , isnull((select sum(convert(decimal(19,6),Finventory_Amount)) from TJD ),0), @FromDate ,''  , @FromDate , @ToDate ,null, null, @FromDate    
union all  
select newid(),'JZ','JJ' , isnull((select count(*) from TJJ ),0) ,'+' , isnull((select sum(convert(decimal(19,6),FGoods_Receipt_Quantity)) from TJJ ),0)  
,'+' , isnull((select sum(convert(decimal(19,6),FGoods_Receipt_Quantity)) from TJJ ),0), @FromDate ,'' , @FromDate , @ToDate ,null, null, @FromDate   
  
  
 update TJZ set FTxtValue=null    where FTransmission_Date=@FromDate  
exec Pr_CreateTxtValue 'JZ',@FromDate  
--select *from TJZ     where FTransmission_Date=@FromDate  
  
  
  