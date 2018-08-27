alter PROCEDURE [fn_clientdl_inout]                                                                                           
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
                                                                            
set @ClientId='hz003719'                                                                            
set @BeginDate='2017-8-5'                                                                            
set @endDate='2017-9-05'                                                                            
set @inout='往来'                                                                            
set @filter='全部'                                                                            
set @UseWhichDate='日期'                                      --        select * from wr_ware                  
       */                                                        
            
                                                                                 
 select convert(bit,0) as islock,-1 as xorder,1 as IsCalc,-1 as InOut,-1 as Filter,-1 as BillId,null as dlId,null as Order_Code,null as billtime,@BeginDate as xDate,null as BillCode,         
 'clBlack' as FntClr,'此前结余' as Brief                  
 ,   '' as Brand ,'' as Pack, null as InQty,null as OutQty,null as RmnQty,null AS IsOutBill ,null as OutBillDate ,null as ChkTime     , '0'as IsInvoice    ,                                                        
0  As IsTax , -1 as BillType ,null as  TaxRate ,null as OrXdate  , null as AcceptancebillCode   ,''  as classid  ,'' as DLNote                                                                  
    into #a                                                                                          
                                                                                      
union all                                                                                          
 select islock, 0,1,0,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'发货 '+Code+' '+IsNull(Note,'')                  
 , '' as Brand ,'' as Pack, GetFund,null,GetFund,IsOutBill, null as OutBillDate ,ChkTime,'0'as IsInvoice   ,                                                        
 IsTax ,1 as BillType   ,null as  TaxRate ,InvoiceDate as OrXdate , null as AcceptancebillCode  ,''  as classid   ,'' as DLNote                             
  from sl_invoice                                                                         
 where ClientId=@ClientId and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate                                                                               
                                                                  
union all                                   
      --isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                                               
 select null as   islock, 0,0,0,m.IsOutBill,19,d.dlId,m.Code,m.billtime,null,null,                                                                                
 'clBlack',isnull(d.PartNo,'')+isnull(space(20-datalength(rtrim(d.PartNo))),'')+ ' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as   decimal(15,5)) as varchar(40))                  
 ,   d.Brand ,d.Pack, null,null,null,d.IsOutBill , d.OutBillDate ,ChkTime ,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice ,                                                        
 m.IsTax  ,1 as BillType  ,null as  TaxRate    ,m.InvoiceDate as OrXdate    , null as AcceptancebillCode  ,wr.classid  ,d.bhnote as DLNote                            
 from sl_invoicedl d,sl_invoice m , wr_ware wr                                                                              
 where d.InvoiceId=m.Code and d.WareId =wr.id and m.ClientId=@ClientId                                                                                 
 and m.InvoiceDate>=@BeginDate and m.InvoiceDate<=@EndDate                                                                                  
                                                                                     
                                                               
union all                                                                                          
 select   islock, 0,0,0,IsOutBill,19,null,Code,billtime,null,null,                                                                                
 'clBlack','其它'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))                  
 , '' as Brand ,'' as Pack,  null,null,null,null,null as OutBillDate,ChkTime,'0'as IsInvoice    ,                                                        
 IsTax  ,1 as BillType ,null as  TaxRate       , InvoiceDate as OrXdate , null as AcceptancebillCode ,''  as classid , '' as DLNote                              
  from sl_invoice                                                                                  
 where ClientId=@ClientId                                                                                 
 and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate and OtherFund<>0                                                                                          
                                                                                
union all                                                                                          
 select     islock, 0,1,-1,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                                                                
 'clBlack','本单收款 '+Code                  
 , '' as Brand ,'' as Pack,    null,PayFund,null,null,null as OutBillDate,ChkTime,'0'as IsInvoice   ,                                                        
 IsTax   ,1 as BillType ,null as  TaxRate      , InvoiceDate as OrXdate  , null as AcceptancebillCode ,''  as classid  , ''  as DLNote                                
 from sl_invoice                                                                                 
 where ClientId=@ClientId                                                                                 
 and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate and PayFund<>0                                                                 
                                                                      
union all                                                                                          
                                        
  select null as   islock, 0,1,-1,-1,19,null,m.Code,d.ClsDate,d.ClsDate,m.Code,                                              
 'clBlack','发货取消 '+m.Code                  
 , '' as Brand ,'' as Pack,   null,sum(d.RmnQty*d.Price),null,null,null as OutBillDate,null as ChkTime,'0'as IsInvoice  ,                                                        
 m.IsTax ,1 as BillType  ,null as  TaxRate     ,m.InvoiceDate as OrXdate    , null as AcceptancebillCode ,''  as classid ,d.bhnote as DLNote                                           
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code                                                               
  where m.ClientId=@ClientId     and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate   
  group by d.ClsDate,m.Code, m.IsTax, m.InvoiceDate ,d.bhnote                                                                                 
                                                                                
union all                                                                                          
                                                                    
--d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                                                                    
 select null as   islock, 0,0,-1,-1,19,null,m.Code,d.ClsDate,null,m.Code,                                                       
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.RmnQty as int) as varchar(20))+space(8-len(cast(cast (d.RmnQty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40)      )                  
 ,  d.Brand ,d.Pack, null,null,null,null,null as OutBillDate,ChkTime,case when isnull(FpID,'')<>'' then 1 else 0 end as IsInvoice   ,                                                        
 m.IsTax  ,1 as BillType ,null as  TaxRate  ,m.InvoiceDate as OrXdate , null as AcceptancebillCode   ,wr.ClassId  ,d.dlnote as DLNote                                 
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code                   
  join wr_ware wr on d.WareId =wr.Id                                         
 where ClientId=@ClientId and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate                                                                                          
                                                                                          
union all                                                 
                                                                                      
 select null as   islock, 0,1,1,IsOutBill,20,null,Code,billtime,ReturnDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'s退货'                  
 , '' as Brand ,'' as Pack, null,GetFund,null,IsOutBill ,null OutBillDate,ChkTime,'0'as IsInvoice  ,                                                        
 IsTax  ,1 as BillType ,null as  TaxRate , ReturnDate   as OrXdate  , null as AcceptancebillCode  ,''  as classid , '' as DLNote                                     
 from sl_return                                                                                
  where ClientId=@ClientId                                                                                 
 and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                                                                                    
                                                                      
                                                                    
union all     --+d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                                                     
 select null as   islock,0,0,1,m.IsOutBill,20,d.dlId,m.Code,m.billtime,null,null,                                  
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40))                  
 , d.Brand ,d.Pack, null,null,null,d.IsOutBill ,d.OutBillDate,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                                        
 m.IsTax ,1 as BillType ,null as  TaxRate   , m.ReturnDate   as OrXdate   , null as AcceptancebillCode  ,''  as classid  ,d.dlnote as DLNote                                             
 from sl_returndl d,sl_return m  ,wr_ware wr                                                                              
 where d.ReturnId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                                 
 and m.ReturnDate>=@BeginDate and m.ReturnDate<=@EndDate                                                                                   
                                                                                     
                                                                          
union all                                   
 select null as   islock,0,0,1,IsOutBill,20,null,Code,billtime,null,null,                                                                                
 'clBlack','其它'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))                  
 ,'' as Brand ,'' as Pack, null,null,null,null ,null as OutBillDate,ChkTime,'0'as IsInvoice    ,                                                        
 IsTax    ,1 as BillType ,null as  TaxRate   , ReturnDate   as OrXdate  , null as AcceptancebillCode    ,''  as classid , '' as DLNote                           
 from sl_return                                                       
  where ClientId=@ClientId                                       
 and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate and OtherFund<>0                                                                                          
                                                      
union all                                                                                          
 select null as islock,0,1,1,IsOutBill,9 ,null,Code,billtime,ArriveDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'到货 '+Code                  
 ,  '' as Brand ,'' as Pack,null, GetFund,null,IsOutBill ,null as OutBillDate,ChkTime,null as IsInvoice    ,                                                        
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax  ,1 as BillType ,                                                                          
case when isnull(TaxRate,0)>0 then convert(varchar(10),TaxRate*100)+'%' else null end  as TaxRate                                                         
 ,  ArriveDate   as OrXdate    , null as AcceptancebillCode        ,''  as classid    , ''as DLNote                  
 from ph_arrive                                                                                 
 where ClientId=@ClientId and ArriveDate>=@BeginDate and ArriveDate<=@EndDate                                           
                                                                                  
union all                                                 
              --  isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                                                                    
 select null as   islock,0,0,1,m.IsOutBill,9,d.dlId,m.Code,m.billtime,null,null,                                                          
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40))                  
 ,  d.Brand ,d.Pack, null,null,null,d.IsOutBill ,d.OutBillDate,ChkTime,null as IsInvoice    ,                                                        
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType ,                                                            
case when isnull(m.TaxRate,0)>0 then convert(varchar(10),m.TaxRate*100)+'%' else null end  as TaxRate                                                             
 ,  m.ArriveDate   as OrXdate   , null as AcceptancebillCode       ,wr.classid    ,d.dlnote as DLNote                      
 from ph_arrivedl d,ph_arrive m  ,wr_ware wr                                                                               
 where d.ArriveId=m.Code and d.WareId = wr.Id  and m.ClientId=@ClientId                                                                                 
 and m.ArriveDate>=@BeginDate and m.ArriveDate<=@EndDate                                                              
                                                                                    
union all                                                                                          
 select null as   islock,0,0,1,IsOutBill,9,null,Code,billtime,null,null,                                                                                
 'clBlack','其它'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))                  
 , '' as Brand ,'' as Pack, null,null,null,null ,null as OutBillDate,ChkTime ,null as IsInvoice    ,                                                        
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType  ,                                                            
case when isnull(TaxRate,0)>0 then convert(varchar(10),TaxRate*100)+'%' else null end  as TaxRate                                                             
 ,  ArriveDate   as OrXdate     , null as AcceptancebillCode      ,''  as classid  , ''  as DLNote                                               
 from ph_arrive                                                                             
 where ClientId=@ClientId                                                                                 
 and ArriveDate>  =@BeginDate and ArriveDate<=@EndDate and OtherFund<>0                                                                                          
                             
union all                                                                                          
 select null as   islock,0,1,0,IsOutBill,13,null,Code,billtime,ReturnDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'p退货'                  
 ,   '' as Brand ,'' as Pack,                                                                               
 GetFund,null,null,IsOutBill,null as OutBillDate ,ChkTime,null as IsInvoice  , IsTax ,1 as BillType                   
 ,null as  TaxRate        ,   ReturnDate   as OrXdate  , null as AcceptancebillCode     ,''  as classid  , '' as DLNote                         
 from ph_return where ClientId=@ClientId                                                                  
  and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                                                                                        
                                                                              
union all                                                                                          
   --d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                                                                    
 select null as   islock,0,0,0,m.IsOutBill,13,d.dlId,m.Code,m.billtime,null,null,                                                                                
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40))                  
 ,   d.Brand ,d.Pack, null,null,null,d.IsOutBill ,d.OutBillDate,ChkTime,null as IsInvoice    ,                                                        
 m.IsTax  ,1 as BillType ,null as  TaxRate   ,   m.ReturnDate   as OrXdate , null as AcceptancebillCode  ,wr.ClassId  ,d.dlnote as DLNote                          
 from ph_returndl d,ph_return m ,wr_ware wr                                                                               
 where d.ReturnId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                           
 and m.ReturnDate>=@BeginDate and m.ReturnDate<=@EndDate                                                                                          
                                                                                
union all                                                      
 select null as   islock,0,0,0,IsOutBill,13,null,Code,billtime,null,null,                                                                                
 'clBlack','其它'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))                  
 ,    '' as Brand ,'' as Pack,  null,null,null,null ,null as OutBillDate,ChkTime,null as IsInvoice     ,                             
 IsTax    ,1 as BillType ,null as  TaxRate      ,   ReturnDate   as OrXdate , null as AcceptancebillCode   ,''  as classid , '' as DLNote                                          
 from ph_return  where ClientId=@ClientId                                                                                 
 and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate and OtherFund<>0                                                                                          
union all                                                                                          
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'借入'                  
 ,  '' as Brand ,'' as Pack,      null,WareFund,null,IsOutBill,null as OutBillDate,ChkTime,null as IsInvoice  ,                                                        
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax    ,1 as BillType ,                    
case when isnull(TaxRate,0)>0 then convert(varchar(10),TaxRate*100)+'%' else null end  as TaxRate                                                             
   ,    InDate   as OrXdate  , null as AcceptancebillCode     ,''  as classid  , '' as DLNote                         
  from wh_in                                                                                
  where  ClientId=@ClientId                                                 
 and InTypeId='I08' and InDate>=@BeginDate and InDate<=@EndDate                                                                                    
union all                                                                                          
  --isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                                              
 select null as   islock,0,0,1,m.IsOutBill,21,d.dlId,m.Code,m.billtime,null,null,                                                                                
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40))                  
 ,    d.Brand ,d.Pack,  null,null,null,d.IsOutBill,d.OutBillDate ,ChkTime,null as IsInvoice     ,                                                        
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax      ,1 as BillType ,                                               
case when isnull(m.TaxRate,0)>0 then convert(varchar(10),m.TaxRate*100)+'%' else null end  as TaxRate                                                             
   ,    m.InDate   as OrXdate  , null as AcceptancebillCode    ,wr.ClassId   ,d.dlnote as DLNote                       
 from wh_indl d,wh_in m ,wr_ware wr                                                                               
 where d.InId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                                 
 and m.InTypeId='I08' and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                                                          
                                                                               
union all                                                                                 
 select null as   islock,0,1,0,IsOutBill,22,null,Code,OutDate,billtime,Code,                                                                           (case IsChk when 1 then 'clBlack' else 'clRed' end),'借出',  '' as Brand ,'' as Pack,                    
 WareFund,null,null,IsOutBill,null as OutBillDate ,ChkTime,null as IsInvoice     ,                                                        
 0 AS IsTax ,1 as BillType ,null as  TaxRate    ,    OutDate   as OrXdate   , null as AcceptancebillCode  ,''  as classid , '' as DLNote                             
 from wh_out                                                                                 
 where ClientId=@ClientId                                                                                 
 and OutTypeId='X08' and OutDate>=@BeginDate and OutDate<=@EndDate                                                                                      
                                               
union all                                                                                          
  --isnull(d.Brand,'')+space(8-len(isnull(d.Brand,'')))+isnull(d.pack,'')+space(6-len(isnull(d.pack,'')))                                                                    
 select null as   islock,0,0,0,m.IsOutBill,22,d.dlId,m.Code,m.billtime,null,null,                           
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal(15,5)) as varchar(40))                  
 ,  d.Brand ,d.Pack,null, null,null,d.IsOutBill, d.OutBillDate ,ChkTime,null as IsInvoice    ,                                                        
 0 AS IsTax ,1 as BillType  ,null as  TaxRate  ,    m.OutDate   as OrXdate  , null as AcceptancebillCode ,wr.ClassId  ,d.dlnote as DLNote                           
 from wh_outdl d,wh_out m   ,wr_ware wr                                                                             
 where d.OutId=m.Code and d.WareId =wr.id and m.ClientId=@ClientId                                                
  and m.OutTypeId='X08' and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                                                                        
                                                                                           
union all                                                                                          
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'异地调配入库'                  
 ,    '' as Brand ,'' as Pack,  null,WareFund,null,null ,null as OutBillDate,ChkTime,null as IsInvoice     ,                                                        
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax       ,1 as BillType,                                                           
case when isnull(TaxRate,0)>0 then convert(varchar(10),TaxRate*100)+'%' else null end  as TaxRate     
,    inDate   as OrXdate   , null as AcceptancebillCode     ,''  as classid  ,'' as DLNote                         
 from wh_in                                                                                 
 where  ClientId=@ClientId and InTypeId='I09'                                                                                 
 and InDate>=@BeginDate and InDate<=@EndDate                                                                                         
union all                                                                
 select null as   islock,0,0,1,m.IsOutBill,21,d.dlid,m.Code,m.billtime,null,null,                                                       
 'clBlack',d.PartNo+isnull(space(20-datalength(rtrim(d.PartNo))),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+cast(cast(d.Price as decimal  (15,5)) as varchar(40))                  
 ,  d.Brand ,d.Pack, null,null,null,d.IsOutBill, d.OutBillDate ,ChkTime,null as IsInvoice     ,                                                        
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax         , 1 as BillType ,                                                            
case when isnull(m.TaxRate,0)>0 then convert(varchar(10),m.TaxRate*100)+'%' else null end  as TaxRate                                                             
,    m.inDate   as OrXdate   , null as AcceptancebillCode  , wr.ClassId     ,d.dlnote as DLNote                       
 from wh_indl d,wh_in m  ,wr_ware wr                                                                              
 where d.InId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                                
 and m.InTypeId='I09' and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                                                          
                                                                                          
union all                                                                                          
 select null as   islock,0,1,0,IsOutBill,22,null,Code,billtime,OutDate,Code,                                                      
 (case IsChk when 1 then 'clBlack' else 'clRed' end), case when OutTypeId='X09' then '异地调配出库' else '赠品出库' end                 
 ,      '' as Brand ,'' as Pack, case when OutTypeId='X09' then  WareFund else null end,null,null,null,null as OutBillDate ,ChkTime,null as IsInvoice     ,                                                        
 0 AS IsTax  ,1 as BillType ,null as  TaxRate ,    OutDate   as OrXdate  , null as AcceptancebillCode  ,''  as classid , '' as DLNote                             
 from wh_out                                          
 where ClientId=@ClientId and OutTypeId in  ( 'X09','X04') and OutDate>=@BeginDate and OutDate<=@EndDate                                                                                      
                                                                                   
                                                                     
union all                                           
  --d.Brand+space(8-len(IsNull(d.Brand,'xxx')))+d.pack+space(6-len(d.pack))                                                
 select null as   islock,0,0,0,m.IsOutBill,22,d.dlid,m.Code,m.billtime,null,null,                                                                      
 'clBlack',d.PartNo+isnull(space(20-datalength(d.PartNo)),'')+' '+cast(cast (d.Qty as int) as varchar(20))+space(8-len(cast(cast (d.Qty as int) as varchar(20))))+  case when OutTypeId='X09' then cast(cast(d.Price as decimal(15,5)) as varchar(40)) else ''
 end                  
 ,    d.Brand ,d.Pack, null,null,null,d.IsOutBill ,d.OutBillDate,  ChkTime  ,null as IsInvoice     ,                                                        
0 AS IsTax   ,1 as BillType   ,null as  TaxRate   ,    m.OutDate   as OrXdate   , null as AcceptancebillCode  ,wr.classid ,d.dlnote as DLNote                             
from wh_outdl d,wh_out m   ,wr_ware wr                                                                             
 where d.OutId=m.Code and d.WareId=wr.Id  and m.ClientId=@ClientId                                                                                 
 and m.OutTypeId in  ( 'X09','X04') and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                          
                                                                               
union all                                                                               
 select null as   islock,0,1,-1,-1,case when isnull(isAcceptancebill,0)=0 then  20 else 48 end as billid   ,null,Code,billtime,ReceiverDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end)                            
 ,case when isAcceptancebill=1 then '（承兑）' else '' end +'收款 '+(select Name from fn_item where Code=ItemId)+' '+IsNull(Note,'')                            
 ,   '' as Brand ,'' as Pack,   null,PayFund,null,null, null as OutBillDate,ChkTime,null as IsInvoice     ,                                                        
0 as IsTax   ,0 as BillType  ,null as  TaxRate      ,     ReceiverDate   as OrXdate ,  AcceptancebillCode ,''  as classid  , '' as DLNote                             
 from fn_receiver where ClientId=@ClientId                                                                                 
 and ReceiverDate>=@BeginDate and ReceiverDate<=@EndDate                                                                                          
union all                                    
                            
--select isAcceptancebill * From fn_receiver                                                                                  
                                                                        
 select null as   islock,0,1,-1,-1,case when isnull( py.isAcceptancebill,0)=0 then  21 else 49 end as billid   ,null,py.Code,py.billtime,py.PaymentDate,py.Code,                               
 (case py.IsChk when 1 then 'clBlack' else 'clRed' end)                            
 ,case when Rec.isAcceptancebill=1 then '（承兑）' else '' end+case py.IoName when '' then '付款 '+IsNull((select Name from fn_item where Code=py.ItemId),0) else py.IoName end+' '+IsNull(py.Note,'')                            
 ,      '' as Brand ,'' as Pack,   py.PayFund,null,null,  null ,null as OutBillDate,py.ChkTime,null as IsInvoice   ,                                                        
0 as IsTax   ,0 as BillType  ,null as  TaxRate  ,     py.PaymentDate   as OrXdate  , Rec.AcceptancebillCode  ,''  as classid  ,'' as DLNote                             
 from fn_payment py                               
 left join fn_receiver Rec on Rec.Code = py.ReceiverCode                               
 where py.ClientId = @ClientId                                                                                 
 and py.PaymentDate>=@BeginDate and py.PaymentDate<=@EndDate                                                                                    
                                                                            
union all                                  
select null as   islock,0,1,0,-1, 23  as billid                                     
 ,null,Code,billtime,InDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'应收 '+(select Name from fn_item where Code=ItemId)                  
 ,    '' as Brand ,'' as Pack,  PayFund,null,null,null ,null as OutBillDate ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                                     
IsTax  ,0 as BillType ,null as  TaxRate  ,    InDate   as OrXdate , null as AcceptancebillCode    ,''  as classid  , ''as DLNote                          
from fn_shldin                                                                         
 where ClientId=@ClientId and InDate>=@BeginDate and InDate<=@EndDate                                                                                          
union all                                                                                          
 select null as   islock,0,1,1,-1,  24  as billid                                   
 ,null,Code,billtime,OutDate,Code,                                     
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'应付 '+(select Name from fn_item where Code=ItemId)                  
 ,      '' as Brand ,'' as Pack,   null,PayFund,null,null ,null as OutBillDate ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                                        
 IsTax ,0 as BillType ,null as  TaxRate ,    OutDate   as OrXdate  , null as AcceptancebillCode    ,''  as classid  ,'' as DLNote                          
 from fn_shldout                                                                                 
 where ClientId=@ClientId and OutDate>=@BeginDate and OutDate<=@EndDate                                                                                          
union all                                                                                          
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'客户转帐(入)单 '+OutName                  
 ,        '' as Brand ,'' as Pack,  PayFund,null,null,null, null as OutBillDate ,ChkTime,null as IsInvoice    ,                                                        
0 as  IsTax    ,0 as BillType ,null as  TaxRate ,TrnsfrDate as OrXdate  , null as AcceptancebillCode   ,''  as classid ,'' as DLNote                            
  from fn_clntransfer                                                      
 where InId=@ClientId and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                                                                      
                                                                                 
union all                                                                                 
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'客户转帐(出)单 '+InName                  
 ,   '' as Brand ,'' as Pack,  null,PayFund,null,null ,null as OutBillDate,ChkTime,null as IsInvoice    ,                                                        
0 as  IsTax ,0 as BillType ,null as TaxRate ,TrnsfrDate as OrXdate , null as AcceptancebillCode   ,''  as classid  ,'' as DLNote                           
 from fn_clntransfer                                                                                 
 where OutId=@ClientId and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                                                                                         
                                
union all                                                                                          
select null as   islock,1,1,9,-1,-1,null,null,null,null,null,'clBlack','合    计', '' as Brand ,'' as Pack,                                                                    
       null,null,                                                                                          
       IsNull((select sum(GetFund) from sl_invoice where ClientId=@ClientId and InvoiceDate<=@EndDate),0)                                                                                          
      -IsNull((select sum(PayFund) from sl_invoice where ClientId=@ClientId and InvoiceDate<=@EndDate),0)                                              
      -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and ClientId=@ClientId and d.ClsDate<=@EndDate),0)                                                                               
 
      -IsNull((select sum(GetFund) from sl_return where ClientId=@ClientId and ReturnDate<=@EndDate),0)                                                                                          
      -IsNull((select sum(GetFund) from ph_arrive where ClientId=@ClientId and ArriveDate<=@EndDate),0)                                                                                          
      +IsNull((select sum(GetFund) from ph_return where ClientId=@ClientId and ReturnDate<=@EndDate),0)                                                                                          
      -IsNull((select sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and ClientId=@ClientId and InDate<=@EndDate),0)                                                                            
  +IsNull((select sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and ClientId=@ClientId and OutDate<=@EndDate),0)                                                                                          
      -IsNull((select sum(PayFund) from fn_receiver where ClientId=@ClientId and ReceiverDate<=@EndDate),0)                                                                     
      +IsNull((select sum(PayFund) from fn_payment where ClientId=@ClientId and PaymentDate<=@EndDate),0)                                                                                          
      +IsNull((select sum(PayFund) from fn_shldin where ClientId=@ClientId and InDate<=@EndDate),0)                                                                                          
      -IsNull((select sum(PayFund) from fn_shldout where ClientId=@ClientId and OutDate<=@EndDate),0)                                              
      +IsNull((select sum(PayFund) from fn_clntransfer where InId=@ClientId and TrnsfrDate<=@EndDate),0)                                                                                    
      -IsNull((select sum(PayFund) from fn_clntransfer where OutId=@ClientId and TrnsfrDate<=@EndDate),0)                                                                                          
      +IsNull((select sum(Balance) from crm_client where Code=@ClientId),0)                                                                                          
      ,null ,null as OutBillDate ,null as ChkTime      ,null as IsInvoice     ,                                                        
      null as IsTax  ,-1 as BillType  ,null as  TaxRate ,null as OrXdate  , null as AcceptancebillCode  ,''  as classid  ,'' as DLNote                               
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
                                                                                                            
                            
if @InOut='往'                                                                             
  delete from #a where InOut=1 or InOut=-1                                                                                          
else if @InOut='来'                                                                                          
  delete from #a where InOut=0 or InOut=-1                                                                                          
                                                                                          
if @Filter='未打钩'                             
  delete from #a where (Filter=1 or Filter=-1) and xorder=0                                                                                  
else if @Filter='已打钩'                                                                   
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
set @inout='往来'                                                                            
set @filter='全部'                                                                            
set @UseWhichDate='审核时间'                                                                              
*/                                                              
                                      
select top 0 * ,convert(bit,IsInvoice ) as NewIsInvoice   into #RltSet  from #a                                       
                                      
if @UseWhichDate='制单时间'                                                                
begin                                                                              
                                                               
 insert into #RltSet                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice    from #a where xorder =-1                     
 union all                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice                                                                   
 from #a where ( billtime>=@begindate or billtime is null)  and xorder =0 --and billtime<=@endDate                                                                 
 union all                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                              
 order by xorder,billtime,Order_Code  , iscalc desc                                    
                                                                
 select *From #RltSet      order by xorder,Billtime,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId                 
end                                                                                         
if @UseWhichDate='审核时间'                                                                                  
begin                                                                
 insert into #RltSet                                                                                   
 select * ,convert(bit,IsInvoice ) as NewIsInvoice      from #a where xorder =-1                                                        
 union all                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice                                                                   
 from #a where (CHktime>=@begindate or CHktime is null)  and xorder =0 --and billtime<=@endDate                                                                 
 union all                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                              
 order by xorder,CHktime,Order_Code  , iscalc desc                                                               
                                                         
 select *From #RltSet      order by xorder,CHktime,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId                           
end                                                      
if @UseWhichDate='日期'                                                                                  
begin                                                                                                           
 insert into #RltSet                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice      from #a where xorder =-1                                                              
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice                         
 from #a where ( xDate>=@begindate or xDate is null)  and xorder =0 --and billtime<=@endDate                                                                 
 union all                                                               
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                              
 order by xorder,OrXdate,Order_Code  , iscalc desc                                                               
                                
 select *From #RltSet      order by xorder,OrXdate,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId                                                              
end                                                                                  
                                                       
                                                                          
--select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax  from #a order by xorder,Billtime,Order_Code  , iscalc desc                                                                                        
--select *From #RltSet          --    order by xorder,Billtime,Order_Code  , iscalc desc                                                                                        
                                      
drop table #RltSet                                      
drop table #a 