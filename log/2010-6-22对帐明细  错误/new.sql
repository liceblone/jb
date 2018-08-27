alter   PROCEDURE [fn_clientdl_inout]                                                   
                 @ClientId varchar(20),                                                  
                 @BeginDate datetime,                                                  
                 @EndDate datetime,                                                  
                 @InOut varchar(10),                                                  
                 @Filter varchar(10)  ,                                        
   @UseWhichDate varchar(30)                                                 
AS                                                  
      /*                         
declare                  @ClientId varchar(20),                                                  
                 @BeginDate datetime,                                                  
                 @EndDate datetime,                                                  
                 @InOut varchar(10),                                                  
                 @Filter varchar(10)  ,                                        
   @UseWhichDate varchar(30)                                        
                                    
set @ClientId='hz000127'                                    
set @BeginDate='2007-1-3'                                    
set @endDate='2007-2-1'                                    
set @inout='����'                                    
set @filter='ȫ��'                                    
set @UseWhichDate='����'                        
 */                

declare @isUseXDate    bit
declare @isUseBillTime bit
declare @isUseChkTime  bit
set @isUseXDate=0
set @isUseBillTime =0
set @isUseChkTime  =0

if @UseWhichDate='�Ƶ�ʱ��'  
set @isUseBillTime =1

if @UseWhichDate='���ʱ��'                                          
set @isUseChkTime  =1   
                                           
if @UseWhichDate='����'    
set @isUseXDate=1
                                         
 select convert(bit,0) as islock,-1 as xorder,1 as IsCalc,-1 as InOut,-1 as Filter,-1 as BillId,null as dlId,null as Order_Code,null as billtime,@BeginDate as xDate,null as BillCode,                                        
 'clBlack' as FntClr,'��ǰ����' as Brief,   '' as Brand ,'' as Pack,                                    
 null as InQty,null as OutQty,null as RmnQty,null AS IsOutBill  ,null as ChkTime     , '0'as IsInvoice    ,                
0  As IsTax , -1 as BillType ,null as  TaxRate ,null as OrXdate                                 
 into #a                                                  
                                              
union all                                                  
                                                  
 select islock, 0,1,0,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���� '+Code+' '+IsNull(Note,''), '' as Brand ,'' as Pack,                                        
 GetFund,null,GetFund,IsOutBill,ChkTime,'0'as IsInvoice   ,                
 IsTax ,1 as BillType   ,null as  TaxRate ,InvoiceDate as OrXdate                                 
  from sl_invoice                                         
 where ClientId=@ClientId 
and ( 
        ( (InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime   >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( (ChkTime    >=@BeginDate and ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )
                                  
                                 
union all                                                  
 select null as   islock, 0,0,0,m.IsOutBill,19,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',isnull(d.PartNo,'')+isnull(space(20-datalength(rtrim(d.PartNo))),'')+ ' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as   decimal(15,5)) as varchar(40)),   d.Brand ,d.Pack, 
 null,null,null,d.IsOutBill ,ChkTime ,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice     ,                
 m.IsTax  ,1 as BillType  ,null as  TaxRate    ,m.InvoiceDate as OrXdate                               
 from sl_invoicedl d,sl_invoice m                                         
 where d.InvoiceId=m.Code and m.ClientId=@ClientId                                         
and ( 
        ( (m.InvoiceDate>=@BeginDate and m.InvoiceDate<=@EndDate)and @isUseXDate=1 )
     or ( (m.billtime   >=@BeginDate and m.billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( (ChkTime    >=@BeginDate and ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                               
                                        
                       
union all                                                  
 select   islock, 0,0,0,IsOutBill,19,null,Code,billtime,null,null,                                        
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20)), '' as Brand ,'' as Pack,                                       
 null,null,null,null,ChkTime,'0'as IsInvoice    ,                
 IsTax  ,1 as BillType ,null as  TaxRate       , InvoiceDate as OrXdate                   
                          
  from sl_invoice                                          
 where ClientId=@ClientId     and OtherFund<>0                                                  
and ( 
        ( (InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime   >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( (ChkTime    >=@BeginDate and ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                        
union all                                                  
 select     islock, 0,1,-1,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                        
 'clBlack','�����տ� '+Code, '' as Brand ,'' as Pack,                                     
 null,PayFund,null,null ,ChkTime,'0'as IsInvoice   ,                
 IsTax   ,1 as BillType ,null as  TaxRate      , InvoiceDate as OrXdate                      
 from sl_invoice                                         
 where ClientId=@ClientId      and PayFund<>0                                           
and ( 
        ( (InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime   >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                              
union all                                                  
                                              
                            
--select 0,0,0,null,Code,InvoiceDate,null,Code,'clBlack','����ȡ�� '+Code,null,ClsFund,null,null from sl_invoice where ClientId=@ClientId and Code in (select InvoiceId from sl_invoicedl where ClsDate>=@BeginDate and ClsDate<=@EndDate)                         
  
                
                   
 select null as   islock, 0,1,-1,-1,19,null,m.Code,d.ClsDate,d.ClsDate,m.Code,                                        
 'clBlack','����ȡ�� '+m.Code,    '' as Brand ,'' as Pack,                                      
 null,sum(d.RmnQty*d.Price),null,null,null as ChkTime,'0'as IsInvoice  ,                
 m.IsTax ,1 as BillType  ,null as  TaxRate     ,m.InvoiceDate as OrXdate                                 
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code                                        
  where m.ClientId=@ClientId                         
and ( 
        ( (d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate)and @isUseXDate=1 )
     or ( (d.ClsDate   >=@BeginDate and d.ClsDate<=@EndDate)   and @isUseBillTime=1 )
     or ( (m.ChkTime    >=@BeginDate and m.ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )
group by d.ClsDate,m.Code, m.IsTax, m.InvoiceDate                                                                                        
union all                                                  
                            
--d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                            
 select null as   islock, 0,0,-1,-1,19,null,m.Code,d.ClsDate,null,m.Code,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.RmnQty as int) as varchar(20))+space(8-len(cast(cast (d.RmnQty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)      ),  d.Brand ,d.Pack,    
 null,null,null,null,ChkTime,case when isnull(FpID,'')<>'' then 1 else 0 end as IsInvoice   ,                
 m.IsTax  ,1 as BillType ,null as  TaxRate  ,m.InvoiceDate as OrXdate                                  
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code   
 where ClientId=@ClientId --and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate                                                  
and ( 
        ( (m.InvoiceDate>=@BeginDate and m.InvoiceDate<=@EndDate)and @isUseXDate=1 )
     or ( (d.ClsDate   >=@BeginDate and d.ClsDate<=@EndDate)   and @isUseBillTime=1 )
     or ( (m.ChkTime    >=@BeginDate and m.ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                  
union all         
                                              
 select null as   islock, 0,1,1,IsOutBill,20,null,Code,billtime,ReturnDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'s�˻�',   '' as Brand ,'' as Pack,                                       
 null,GetFund,null,IsOutBill ,ChkTime,'0'as IsInvoice  ,                
 IsTax  ,1 as BillType ,null as  TaxRate , ReturnDate   as OrXdate                              
 from sl_return                                        
  where ClientId=@ClientId                                         
-- and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                                            
and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                              
                            
union all     --+d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))             
 select null as   islock,0,0,1,m.IsOutBill,20,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)), d.Brand ,d.Pack,                
 null,null,null,d.IsOutBill ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                
 m.IsTax ,1 as BillType ,null as  TaxRate   , m.ReturnDate   as OrXdate                                
 from sl_returndl d,sl_return m                                         
 where d.ReturnId=m.Code and m.ClientId=@ClientId                                         
 and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                              
                                                      
                                  
union all                                                  
 select null as   islock,0,0,1,IsOutBill,20,null,Code,billtime,null,null,                                        
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20)),'' as Brand ,'' as Pack,                                          
 null,null,null,null ,ChkTime,'0'as IsInvoice    ,                
 IsTax    ,1 as BillType ,null as  TaxRate   , ReturnDate   as OrXdate                                     
 from sl_return                                         
  where ClientId=@ClientId        and OtherFund<>0                                  
 --and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate                                                  
and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                              
                                                          
union all                                                  
 select null as   islock,0,1,1,IsOutBill,9 ,null,Code,billtime,ArriveDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���� '+Code,  '' as Brand ,'' as Pack,                                        
 null,GetFund,null,IsOutBill ,ChkTime,null as IsInvoice    ,                
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax  ,1 as BillType ,                                  
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                 
 ,  ArriveDate   as OrXdate                                      
 from ph_arrive                                         
 where ClientId=@ClientId --and ArriveDate>=@BeginDate and ArriveDate<=@EndDate                                           
and ( 
        ( (ArriveDate>=@BeginDate and ArriveDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                               
--select case when Isnull(TaxRate,0)>0 then '1' else '0' end AS IsTax,*From ph_arrive                                
                                            
                                  
union all         
              --  isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                            
 select null as   islock,0,0,1,m.IsOutBill,9,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)),  d.Brand ,d.Pack,               
 null,null,null,d.IsOutBill ,ChkTime,null as IsInvoice    ,                
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType ,                    
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                     
 ,  m.ArriveDate   as OrXdate                  
 from ph_arrivedl d,ph_arrive m                                         
 where d.ArriveId=m.Code and m.ClientId=@ClientId                                         
 --and m.ArriveDate>=@BeginDate and m.ArriveDate<=@EndDate                      
 and ( 
        ( (ArriveDate>=@BeginDate and ArriveDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                              
union all                                                  
 select null as   islock,0,0,1,IsOutBill,9,null,Code,billtime,null,null,                                        
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20)), '' as Brand ,'' as Pack,                                         
 null,null,null,null ,ChkTime ,null as IsInvoice    ,                
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType  ,                    
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                     
 ,  ArriveDate   as OrXdate                  
 from ph_arrive                                         
 where ClientId=@ClientId     and OtherFund<>0                                                       
 --and ArriveDate>  =@BeginDate and ArriveDate<=@EndDate                                
and ( 
        ( (ArriveDate>=@BeginDate and ArriveDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                     
union all                                                  
 select null as   islock,0,1,0,IsOutBill,13,null,Code,billtime,ReturnDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'p�˻�',   '' as Brand ,'' as Pack,                                       
 GetFund,null,null,IsOutBill ,ChkTime,null as IsInvoice    ,                
 IsTax ,1 as BillType ,null as  TaxRate        ,   ReturnDate   as OrXdate                               
 from ph_return where ClientId=@ClientId                          
 -- and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                                                
and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                             
union all                                                  
   --d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                            
 select null as   islock,0,0,0,m.IsOutBill,13,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)),   d.Brand ,d.Pack,               
 null,null,null,d.IsOutBill ,ChkTime,null as IsInvoice    ,                
 m.IsTax  ,1 as BillType ,null as  TaxRate   ,   m.ReturnDate   as OrXdate                                   
 from ph_returndl d,ph_return m                                         
 where d.ReturnId=m.Code and m.ClientId=@ClientId                                         
-- and m.ReturnDate>=@BeginDate and m.ReturnDate<=@EndDate                                                  
and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                         
union all              
 select null as   islock,0,0,0,IsOutBill,13,null,Code,billtime,null,null,                                        
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20)),    '' as Brand ,'' as Pack,                                    
 null,null,null,null ,ChkTime,null as IsInvoice     ,                
 IsTax    ,1 as BillType ,null as  TaxRate      ,   ReturnDate   as OrXdate                                
 from ph_return  where ClientId=@ClientId   and OtherFund<>0                                       
-- and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate                                                  
and ( 
        ( (ReturnDate>=@BeginDate and ReturnDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                           
                                              
union all                                                  
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'����',  '' as Brand ,'' as Pack,                                      
 null,WareFund,null,IsOutBill,ChkTime,null as IsInvoice  ,                
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax    ,1 as BillType ,                    
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                     
   ,    InDate   as OrXdate                 
  from wh_in                                        
  where  ClientId=@ClientId                                         
 and InTypeId='I08' --and InDate>=@BeginDate and InDate<=@EndDate                                            
and ( 
        ( (InDate>=@BeginDate and InDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                             
                                                   
union all                                                  
  --isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                            
 select null as   islock,0,0,1,m.IsOutBill,21,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)),    d.Brand ,d.Pack,                    
                    
 null,null,null,d.IsOutBill ,ChkTime,null as IsInvoice     ,                
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax      ,1 as BillType ,                    
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                     
   ,    m.InDate   as OrXdate                 
 from wh_indl d,wh_in m                                         
 where d.InId=m.Code and m.ClientId=@ClientId                                         
 and m.InTypeId='I08' --and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                  
and ( 
        ( (m.InDate>=@BeginDate and m.InDate<=@EndDate)and @isUseXDate=1 )
     or ( (m.billtime  >=@BeginDate and m.billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                   
                                              
union all                                         
 select null as   islock,0,1,0,IsOutBill,22,null,Code,OutDate,billtime,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���',  '' as Brand ,'' as Pack,                                        
 WareFund,null,null,IsOutBill ,ChkTime,null as IsInvoice     ,                
 0 AS IsTax ,1 as BillType ,null as  TaxRate    ,    OutDate   as OrXdate                                      
 from wh_out                                         
 where ClientId=@ClientId                                         
 and OutTypeId='X08' --and OutDate>=@BeginDate and OutDate<=@EndDate                                              
and ( 
        ( (OutDate>=@BeginDate and OutDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                   
                                                        
                                
union all                                                  
  --isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                            
 select null as   islock,0,0,0,m.IsOutBill,22,d.dlId,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)),     d.Brand ,d.Pack,                    
 null,null,null,d.IsOutBill ,ChkTime,null as IsInvoice     ,                
 0 AS IsTax ,1 as BillType  ,null as  TaxRate  ,    m.OutDate   as OrXdate                                                       
 from wh_outdl d,wh_out m                                         
 where d.OutId=m.Code and m.ClientId=@ClientId                    
  and m.OutTypeId='X08'-- and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                                                  
and ( 
        ( (m.OutDate>=@BeginDate and m.OutDate<=@EndDate)and @isUseXDate=1 )
     or ( ( m.billtime  >=@BeginDate and m.billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                      
union all                                                  
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'��ص������',    '' as Brand ,'' as Pack,                                      
 null,WareFund,null,null ,ChkTime,null as IsInvoice     ,                
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax       ,1 as BillType,                    
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                     
,    inDate   as OrXdate                                      
 from wh_in                                         
 where  ClientId=@ClientId and InTypeId='I09'                                         
-- and InDate>=@BeginDate and InDate<=@EndDate                                                  
and ( 
        ( (InDate>=@BeginDate and InDate<=@EndDate)and @isUseXDate=1 )
     or ( (billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )   
union all                                                  
        
                
 select null as   islock,0,0,1,m.IsOutBill,21,d.dlid,m.Code,m.billtime,null,null,                                        
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal  (15,5)) as varchar(40)),  d.Brand ,d.Pack,              
                     
 null,null,null,d.IsOutBill,ChkTime,null as IsInvoice     ,                
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax         , 1 as BillType ,                    
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                     
,    m.inDate   as OrXdate                   
 from wh_indl d,wh_in m                                         
 where d.InId=m.Code and m.ClientId=@ClientId                                         
 and m.InTypeId='I09' --and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                  
and ( 
        ( (m.InDate>=@BeginDate and m.InDate<=@EndDate)and @isUseXDate=1 )
     or ( (m.billtime  >=@BeginDate and m.billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )   
                                                  
union all                                                  
 select null as   islock,0,1,0,IsOutBill,22,null,Code,billtime,OutDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'��ص������',      '' as Brand ,'' as Pack,                                    
 WareFund,null,null,null ,ChkTime,null as IsInvoice     ,                
 0 AS IsTax  ,1 as BillType ,null as  TaxRate ,    OutDate   as OrXdate                       
 from wh_out                                         
 where ClientId=@ClientId and OutTypeId='X09' --and OutDate>=@BeginDate and OutDate<=@EndDate                                              
and ( 
        ( (OutDate>=@BeginDate and OutDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                               
                             
union all                                                  
  --d.Brand+space(8-len(IsNull(d.Brand,'xxx')))+d.pack+space(6-len(d.pack))        
 select null as   islock,0,0,0,m.IsOutBill,22,d.dlid,m.Code,m.billtime,null,null,                              
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)),    d.Brand ,d.Pack,                                   
null,null,null,d.IsOutBill ,ChkTime  ,null as IsInvoice     ,                
0 AS IsTax   ,1 as BillType   ,null as  TaxRate   ,    m.OutDate   as OrXdate                            
                         from wh_outdl d,wh_out m                                         
 where d.OutId=m.Code and m.ClientId=@ClientId                                         
 and m.OutTypeId='X09' and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                                                  
                                      
union all                                                  
 select null as   islock,0,1,-1,-1,20,null,Code,billtime,ReceiverDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'�տ� '+(select Name from fn_item where Code=ItemId)+' '+IsNull(Note,''),   '' as Brand ,'' as Pack,                                    
 null,PayFund,null,null ,ChkTime,null as IsInvoice     ,                
0 as IsTax   ,0 as BillType  ,null as  TaxRate      ,     ReceiverDate   as OrXdate                               
 from fn_receiver where ClientId=@ClientId                                         
-- and ReceiverDate>=@BeginDate and ReceiverDate<=@EndDate 
and ( 
        ( (ReceiverDate>=@BeginDate and ReceiverDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                     
union all                                                  
                                
 select null as   islock,0,1,-1,-1,21,null,Code,billtime,PaymentDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),case IoName when '' then '���� '+IsNull((select Name from fn_item where Code=ItemId),0) else IoName end+' '+IsNull(Note,''),      '' as Brand ,'' as Pack,                                    
 PayFund,null,null,  null ,ChkTime,null as IsInvoice   ,                
0 as IsTax   ,0 as BillType  ,null as  TaxRate  ,     PaymentDate   as OrXdate                 
 from fn_payment where ClientId=@ClientId                                         
-- and PaymentDate>=@BeginDate and PaymentDate<=@EndDate                                            
 and ( 
        ( (PaymentDate>=@BeginDate and PaymentDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                                  
union all                                                  
                                                   
 select null as   islock,0,1,-1,-1,23,null,Code,billtime,InDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'Ӧ�� '+(select Name from fn_item where Code=ItemId),    '' as Brand ,'' as Pack,                                     
 PayFund,null,null,null ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,             
IsTax  ,0 as BillType ,null as  TaxRate  ,    InDate   as OrXdate                 
 from fn_shldin                                 
 where ClientId=@ClientId --and InDate>=@BeginDate and InDate<=@EndDate  
 and ( 
        ( (InDate>=@BeginDate and InDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )  
                                                
union all                                                  
 select null as   islock,0,1,-1,-1,24,null,Code,billtime,OutDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'Ӧ�� '+(select Name from fn_item where Code=ItemId),      '' as Brand ,'' as Pack,                                   
 null,PayFund,null,null ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                
 IsTax ,0 as BillType ,null as  TaxRate ,    OutDate   as OrXdate                 
 from fn_shldout                                         
 where ClientId=@ClientId and OutDate>=@BeginDate and OutDate<=@EndDate    
 and ( 
        ( (OutDate>=@BeginDate and OutDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                               
union all                                                  
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'�ͻ�ת��(��)�� '+OutName,        '' as Brand ,'' as Pack,                                 
 PayFund,null,null,null,ChkTime,null as IsInvoice    ,                
0 as  IsTax    ,0 as BillType ,null as  TaxRate ,TrnsfrDate as OrXdate                
  from fn_clntransfer                                         
 where InId=@ClientId --and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                                        
 and ( 
        ( (TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                           
union all                                         
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                        
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'�ͻ�ת��(��)�� '+InName,   '' as Brand ,'' as Pack,                                      
 null,PayFund,null,null ,ChkTime,null as IsInvoice    ,                
0 as  IsTax ,0 as BillType ,null as TaxRate ,TrnsfrDate as OrXdate                
 from fn_clntransfer                                         
 where OutId=@ClientId --and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                                                 
 and ( 
        ( (TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate)and @isUseXDate=1 )
     or ( ( billtime  >=@BeginDate and billtime<=@EndDate)   and @isUseBillTime=1 )
     or ( ( ChkTime    >=@BeginDate and  ChkTime<=@EndDate)    and @isUseChkTime=1 )
     )                                          
union all                                                  
select null as   islock,1,1,9,-1,-1,null,null,null,null,null,'clBlack','��    ��', '' as Brand ,'' as Pack,                            
       null,null,                                                  

       IsNull((select sum(GetFund) from sl_invoice where ClientId=@ClientId and ((InvoiceDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)
      -IsNull((select sum(PayFund) from sl_invoice where ClientId=@ClientId and ((InvoiceDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)   
      -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and ClientId=@ClientId   and ((d.ClsDate<=@EndDate and @isUseXDate=1) or (m.billtime<=@EndDate and  @isUseBillTime=1)  or (m.ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      -IsNull((select sum(GetFund) from sl_return where ClientId=@ClientId and  ((ReturnDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      -IsNull((select sum(GetFund) from ph_arrive where ClientId=@ClientId and  ((ArriveDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      +IsNull((select sum(GetFund) from ph_return where ClientId=@ClientId and  ((ReturnDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      -IsNull((select sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and ClientId=@ClientId and  ((InDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      +IsNull((select sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and ClientId=@ClientId and  ((OutDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      -IsNull((select sum(PayFund) from fn_receiver where ClientId=@ClientId and   ((ReceiverDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                             
      +IsNull((select sum(PayFund) from fn_payment where ClientId=@ClientId and   ((PaymentDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      +IsNull((select sum(PayFund) from fn_shldin where ClientId=@ClientId and   ((InDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      -IsNull((select sum(PayFund) from fn_shldout where ClientId=@ClientId and    ((OutDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                    
      +IsNull((select sum(PayFund) from fn_clntransfer where InId=@ClientId and    ((TrnsfrDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                            
      -IsNull((select sum(PayFund) from fn_clntransfer where OutId=@ClientId and     ((TrnsfrDate<=@EndDate and @isUseXDate=1) or (billtime<=@EndDate and  @isUseBillTime=1)  or (ChkTime<=@EndDate   and @isUseChkTime=1) )
               ),0)                                                  
      +IsNull((select sum(Balance) from crm_client where Code=@ClientId),0)                                                  
      ,null  ,null as ChkTime      ,null as IsInvoice     ,                
      null as IsTax  ,-1 as BillType  ,null as  TaxRate ,null as OrXdate                
order by xorder,Billtime,Order_Code                                            
                                                  
                                                  
/*                                                  
select *,identity(int,1,1) as id into #1 from #a                                                  
declare @ decimal,@id int,@E decimal                                                  
SELECT @=MAX(RmnQty) FROM #1                                                  
SET @E=0                                                  
update #1 set @=RmnQty=@-@E,@ID=ID+1 ,@E=IsNull(InQty,0)-IsNull(OutQty,0)                                                  
                                                  
SELECT * FROM #1 order by id                                                  
drop table #                                                  
*/                                  
                        
                        
                      
                                        
if @InOut='��'                                     
  delete from #a where InOut=1 or InOut=-1                                                  
else if @InOut='��'                                                  
  delete from #a where InOut=0 or InOut=-1                                                  
                                                  
if @Filter='δ��'                                                  
  delete from #a where (Filter=1 or Filter=-1) and xorder=0                                                  
else if @Filter='�Ѵ�'                           
  delete from #a where (Filter=0 or Filter=-1 or Filter is null) and xorder=0                                                  
                                      
update #a set InQty=(select sum(InQty) from #a),OutQty=(select sum(OutQty) from #a) where xorder=1                                                  
                                                  
                                        
                                                        
                                        
alter table #a alter column IsTax bit                        
                           
/*                      
declare                  @ClientId varchar(20),                                                  
                 @BeginDate datetime,                                                  
                 @EndDate datetime,                                                  
                 @InOut varchar(10),                                                  
                 @Filter varchar(10)  ,                                        
   @UseWhichDate varchar(30)                                        
                                    
set @ClientId='hz000127'                                    
set @BeginDate='2007-1-3'                                    
set @endDate='2007-2-1'                                    
set @inout='����'                                    
set @filter='ȫ��'                                    
set @UseWhichDate='���ʱ��'                                      
*/                      
if @UseWhichDate='�Ƶ�ʱ��'                        
begin                                      
                       
                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder =-1                      
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax                           
 from #a where ( billtime>=@begindate or billtime is null)  and xorder =0 --and billtime<=@endDate                         
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder = 1                      
 order by xorder,billtime,Order_Code  , iscalc desc                       
                        
                        
end                                                 
if @UseWhichDate='���ʱ��'                                          
begin                        
                  
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder =-1                      
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax                           
 from #a where (CHktime>=@begindate or CHktime is null)  and xorder =0 --and billtime<=@endDate                         
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder = 1                      
 order by xorder,CHktime,Order_Code  , iscalc desc                       
                        
end                                                 
if @UseWhichDate='����'                                          
begin                        
                          
                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder =-1                      
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax                           
 from #a where ( xDate>=@begindate or xDate is null)  and xorder =0 --and billtime<=@endDate                         
 union all                       
 select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax     from #a where xorder = 1                      
 order by xorder,OrXdate,Order_Code  , iscalc desc                       
                           
end                                           
/*  */                                      
                                 
                                  
--select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax  from #a order by xorder,Billtime,Order_Code  , iscalc desc                                                
                                    
drop table #a                                                
                                      
                      
                    
                  
                    
                    
                  
                
              
            
     
        
      
    
  
