select  * from TRainbowDataFormat

alter table TRainbowDataFormat add FFieldName varchar(50)

update		TRainbowDataFormat set [Decimal] =4  where FROWiD in (9,10)

select  'F'+rtrim(replace(replace(replace(replace(replace(replace([Item Name],' ','_'),'(',''),')',''),'/',''),'+',''),'-','') )
,* from TRainbowDataFormat

update TRainbowDataFormat set FFieldName=	'F'+rtrim(replace(replace(replace(replace(replace(replace([Item Name],' ','_'),'(',''),')',''),'/',''),'+',''),'-','') )
where FFileType='JA'


		  select * from TRainbowDataFormat	 where FFileType='JZ'	order by FRowID
		  select * from TRainbowDataFormat	    where  FRowID in ( 9 )
		   
		   update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency'   where FFileType='JZ' and  FRowID in ( 6,7 )
		   update TRainbowDataFormat set FFormatFunction=null   where FFileType='JZ' and  FRowID in ( 2 )
		
		
		 update TRainbowDataFormat set FFormatFunction='dbo.fn_FormatTransmissionDate'	 , [Decimal]=0   where FFileType='JB' and  FRowID in ( 9 )
		 update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency'	 , [Decimal]=4   where FFileType='JD' and  FRowID in ( 9 )
		 update TRainbowDataFormat set FFormatFunction=null   where FFileType='JZ' and  FRowID in ( 9 )
						  
		  update TRainbowDataFormat set FFormatFunction='dbo.fn_FormatTransmissionDate'	   where  FRowID in (2,6,7)
		  update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency'	 , [Decimal]=0   where  FRowID in ( 9 )

		  update TRainbowDataFormat set FFormatFunction=null   where FFileType='JB' and  FRowID in ( 12 )
		  
		

insert into TRainbowDataFormat
([Key],		[Item Name],
[Type],		[Start],
[Digits],	[Decimal],
[NOT_NULL],	[Default],
[Foreign Key],[Remarks],	[FFileType],[FRowID],	[FFieldName])
select [Key],
[Item Name],  [Type],
[Start],	  [Digits],
[Decimal],	  [NOT_NULL],
[Default],	  [Foreign Key],
[Remarks],	  [FFileType],
[FRowID],	  [FFileName] from JbFormat ;

		  select * from TRainbowDataFormat

insert into TRainbowDataFormat
(
[Item Name],  [Type],[Start],	  [Digits],  [NOT_NULL],	  
[Remarks],	  [FFileType],[FRowID],	  [FFieldName]  
)
select  
[Item Name],  [Type],  [Start],	  [Digits],
[NOT_NULL],		   [Remarks],	  [FFileType],
[FRowID],	  [FFileName] from JAFormat ;
 



select *from JbFormat ;


select *   from TRainbowDataFormat






--join (select top 1 FinvCode,FPurchPrice from  TPurchaseOrdDL purOrd WHERE purOrd.FinvCode=INV.FINVCODE ORDER BY DESC)


--------------------------------------
create function Fn_Formatint( @value  int)
returns varchar(30)
begin
 	--declare  @value decimal(19,6)  ,@Digits int, @FDecimal int 
 	declare @rlt varchar(300)	
 
	set @rlt=  convert(varchar(30),@value)
	return @rlt
end

alter function Fn_FormatCurrency( @value decimal(19,6) ,@Digits int, @FDecimal int)
returns varchar(30)
begin
 	--declare  @value decimal(19,6)  ,@Digits int, @FDecimal int 
 	declare @rlt varchar(300)	,@intValue varchar(30),@DigitalValue varchar(30)
 	
	--set @value   =123.899898	 set @Digits =13       	set @FDecimal =4
	
	set @intValue=    convert(varchar(30),convert(int,@value))
	set @DigitalValue=convert(varchar(30),@value-convert(int,@value))
	set @rlt= replace(space( @Digits-@FDecimal-len(  @intValue ))+@intValue	 ,' ','0')   +substring(@DigitalValue  ,3,@FDecimal	)
	--print @rlt
	--print substring(@DigitalValue  ,3,4)
	
	return @rlt
end
 
select dbo.Fn_FormatCurrency(23432.234324,14,2), len(dbo.Fn_FormatCurrency(23432.234324,14,2))

	

select * from TRainbowDataFormat where FFileType='JD'   and FRowID=7

update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency',Decimal=0 where FFileType='JD'   and FRowID=7


update TRainbowDataFormat set FFormatFunction='dbo.Fn_FormatCurrency'where FFileType='JD'
and decimal>0

select *  from TRainbowDataFormat where FFieldName='FTransmission_Date'	
select *  from TRainbowDataFormat where FFieldName in ('FUpdate_Date','FUpdated_Date')	

update TRainbowDataFormat  set FFormatFunction='dbo.fn_FormatTransmissionDate'where FFieldName='FInventory_Confirmation_Date'	
update TRainbowDataFormat  set FFormatFunction='dbo.fn_FormatUpdateDatetime'where  FFieldName in ('FUpdate_Date','FUpdated_Date')

select *  from TRainbowDataFormat where FFileType='JD'	 

 select *from TJD
 
 update TJD set FInventory_Confirmation_Date=getdate()
 

print space(30,'d')

select  convert(varchar(2),FFile_ID) +space(2-len(convert(varchar(2),FFile_ID))) 
+ dbo.fn_FormatTransmissionDate(FTransmission_Date) +space(8-len(dbo.fn_FormatTransmissionDate(FTransmission_Date))) 
+ convert(varchar(10),FSCM_Customer_Code) +space(10-len(convert(varchar(10),FSCM_Customer_Code))) 
+ convert(varchar(40),FPart_No_JSF_PN) +space(40-len(convert(varchar(40),FPart_No_JSF_PN))) 
+ convert(varchar(2),FInventory_Status) +space(2-len(convert(varchar(2),FInventory_Status))) 
+ convert(varchar(1),F_Category) +space(1-len(convert(varchar(1),F_Category))) 
+ dbo.Fn_FormatCurrency(FInventory_Quantity,11,0) +space(11-len(dbo.Fn_FormatCurrency(FInventory_Quantity,11,0))) 
+ convert(varchar(3),FCurrency_Code) +space(3-len(convert(varchar(3),FCurrency_Code))) 
+ dbo.Fn_FormatCurrency(FInventory_Price,13,4) +space(13-len(dbo.Fn_FormatCurrency(FInventory_Price,13,4))) 
+ dbo.Fn_FormatCurrency(FInventory_Amount,16,4) +space(16-len(dbo.Fn_FormatCurrency(FInventory_Amount,16,4))) 
+ dbo.fn_FormatTransmissionDate(isnull(FInventory_Confirmation_Date,'')) +space(8-len(dbo.fn_FormatTransmissionDate(isnull(FInventory_Confirmation_Date,'')))) 
+ dbo.fn_FormatUpdateDatetime(FUpdated_Date) +space(14-len(dbo.fn_FormatUpdateDatetime(FUpdated_Date))) 
+convert(varchar(40),isnull(FDisti_Internal_Key,'')) +space(40-len(convert(varchar(40),isnull(FDisti_Internal_Key,'')))) 
+ convert(varchar(32),isnull(FFiller,'')) +space(32-len(convert(varchar(32),isnull(FFiller,'')))) 
+'a'
from TJD

sp_help  TJD

alter Proc Pr_CreateTxtValue(@FileType varchar(20))
as

declare @DateType varchar(30),@Length varchar(30),@Decimal varchar(30),	@FFormatFunction varchar(30)  ,@FileName varchar(200)  ,@NOT_NULL varchar(30)
declare @sql varchar(6000) ,@updateSql varchar(300)
set @sql ='' 
DECLARE Format_Cursor CURSOR FOR
   select [Type],[Digits],[Decimal],FFormatFunction ,FFieldName , NOT_NULL from TRainbowDataFormat where FFileType=@FileType order by FRowID
OPEN Format_Cursor
fetch next from Format_Cursor into @DateType ,@Length ,@Decimal,@FFormatFunction ,@FileName	,@NOT_NULL
while @@fetch_status=0
begin	
       set @updateSql=''
    --print @NOT_NULL
    if @NOT_NULL is  null
	   set @FileName='isnull('+@FileName+','''''+')'
	   
    if isnull( @FFormatFunction,'')<>'' 
       if @Decimal is not null
	  	set @FileName=@FFormatFunction+'('+@FileName+','+ @Length+','+@Decimal+')'
	   else
		set @FileName=@FFormatFunction+'('+@FileName+')'
	else
	  set  @FileName='convert(varchar('+@length+'),'+@FileName+')'
	    
	set @updateSql ='+ '+ @FileName+' +space('+@Length+'-len('+@FileName+')) '  --+')'
	set @sql=@sql+@updateSql
	print @updateSql
	
fetch next from Format_Cursor into @DateType ,@Length ,@Decimal,@FFormatFunction ,@FileName	,@NOT_NULL
end
close Format_Cursor
deallocate Format_Cursor

print @sql 
print @FileType
set @sql='update T'+@FileType+' set  FTxtValue='''''+@sql	   
select  @sql
execute(@sql)


go

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