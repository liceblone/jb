    
 alter PROCEDURE [fn_clientdl_inout_export]                                                                                     
                 @ClientId varchar(20),                                                                                    
                 @BeginDate datetime,                                                                                    
                 @EndDate datetime,                                                                                    
                 @InOut varchar(10),                                                                                    
                 @Filter varchar(10)  ,                                                                          
   @UseWhichDate varchar(30)                                                                                   
AS                                                           
                                       
       /*                    
       exec fn_clientdl_inout_export 'HZ003239%','2017-01-27 00:00:00','2017-02-26 00:00:00','����%','ȫ��%','����%'          
       exec fn_clientdl_inout 'HZ003239','2017-01-27 00:00:00','2017-02-26 00:00:00','����','ȫ��','����'          
       exec [fn_clientdl_inout_export] 'HZ003239','2017-01-27 00:00:00','2017-02-26 00:00:00','����','ȫ��','����'          
       exec fn_clientdl_inout 'HZ002389','2017-01-27 00:00:00','2017-02-26 00:00:00','����','ȫ��','����'          
       exec [fn_clientdl_inout_export] 'HZ003719','2017-8-20 00:00:00','2017-8-30 00:00:00','����','ȫ��','����'                                       
            
 declare  @ClientId varchar(20),   @BeginDate datetime, @EndDate datetime, @InOut varchar(10),  @Filter varchar(10)  , @UseWhichDate varchar(30)                                                                          
                                                                      
set @ClientId='HZ003370'                                                                      
set @BeginDate='2016-12-27'                                                                      
set @endDate='2017-2-28'                                                                      
set @inout='����'                                                                      
set @filter='ȫ��'                                                                      
set @UseWhichDate='����'    */          
                                                
                                                           
                      
                      
set @ClientId = REPLACE (@ClientId, '%', '')            
set @InOut  = REPLACE (@InOut, '%', '')                                                                                    
set @Filter  = REPLACE (@Filter, '%', '')                                                                            
set @UseWhichDate  = REPLACE (@UseWhichDate, '%', '')          
if   @BeginDate <  DATEADD(d,-31*3,GETDATE() )           
  set @BeginDate = DATEADD(d,-31*3,GETDATE() )          
         
 CREATE TABLE #a(          
  islock   bit  ,			xorder   int   ,            IsCalc   int   ,					InOut   int   ,          
  Filter   int  ,			BillId   int   ,            dlId   int  ,						Order_Code   varchar (20) ,          
  billtime   datetime  ,	xDate   datetime  ,			BillCode   varchar (20) ,			FntClr   varchar (7)  ,          
  Brief   varchar (264) ,	partno   varchar (300)  ,	Brand   varchar (50) ,				Pack   varchar (30) ,          
  RsSurfix  varchar (30) ,	qty   decimal (19, 0) ,		price varchar(20) ,					amt   decimal (19, 2) ,           
  InQty   decimal (19, 2) ,	OutQty   decimal (19, 2) ,	RmnQty   decimal (19, 2) ,			sOutBill   bit  ,          
  ChkTime   datetime  ,		IsInvoice   int  ,			IsTax   int  ,						BillType   int   ,          
  TaxRate   varchar (6) ,	OrXdate   datetime  ,		AcceptancebillCode varchar (300),	classid   varchar (50)  ,          
  DlNote   varchar (200) ,	MNote   varchar (200)  ,	ClientOrderNo      varchar (50) 
)            
 insert into #a  (  islock,xorder,IsCalc,InOut,Filter,BillId,dlId,Order_Code, billtime,xDate,BillCode,FntClr,Brief,partno,Brand,Pack,RsSurfix,  Qty,   Price,  amt,  InQty, OutQty,RmnQty,IsOutBill,ChkTime,IsInvoice,IsTax,BillType,TaxRate,OrXdate        
 ,AcceptancebillCode,classid,DlNote,MNote)                                         
 select convert(bit,0) as islock,-1 as xorder,1 as IsCalc,-1 as InOut,-1 as Filter,-1 as BillId,null as dlId,null as Order_Code,null as billtime,@BeginDate as xDate,null as BillCode,                                                                         
 
 'clBlack' as FntClr,'��ǰ����' as Brief  ,'' partno          
 ,   '' as Brand ,'' as Pack,'' as RsSurfix , null as qty,null as price, null as amt, null as InQty,null as OutQty,null as RmnQty,null AS IsOutBill  ,null as ChkTime     , '0'as IsInvoice    ,                                                  
0  As IsTax , -1 as BillType ,null as  TaxRate ,null as OrXdate  , null as AcceptancebillCode   ,''  as classid ,'' DlNote, '' MNote  ,'' ClientOrderNo                                                            
                                                                                    
        /*                                                                       
union all                                                                                    
                                                                                    
 select islock, 0,1,0,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���� '+Code+' '+IsNull(Note,'')            
 , '' as Brand ,'' as Pack, GetFund,null,GetFund,IsOutBill,ChkTime,'0'as IsInvoice   ,                                                  
 IsTax ,1 as BillType   ,null as  TaxRate ,InvoiceDate as OrXdate , null as AcceptancebillCode  ,''  as classid                        
  from sl_invoice                                                                           
 where ClientId=@ClientId and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate                                                                                    
                      */                                               
                                                                   
union all                             
 select null as   islock, 0,1,0,m.IsOutBill,19,d.dlId,m.Code,m.billtime,m.InvoiceDate,m.Code ,                                                                          
 'clBlack','���� '              
 , d.PartNo,  d.Brand ,d.Pack, wr.RsSurfix,d.Qty as qty,d.Price as price, d.Qty * d.Price as amt, d.Qty * d.Price ,null,null          
           
 ,d.IsOutBill ,ChkTime ,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice ,                                                  
 m.IsTax  ,1 as BillType  ,null as  TaxRate    ,m.InvoiceDate as OrXdate    , null as AcceptancebillCode  ,wr.classid   , d.bhNote as dlnote , m.Note as  MNote                     
 , ( select ClientOrderNo    from sl_orderdl where  f_id  = d.SLOrderID)  as ClientOrderNo
 from sl_invoicedl d 
 join sl_invoice   m  on d.InvoiceId=m.Code 
 join wr_ware     wr  on d.WareId =wr.id                                                                    
 where  m.ClientId=@ClientId                                                                           
 and m.InvoiceDate>=@BeginDate and m.InvoiceDate<=@EndDate                                                                            
                                                                                  
																						                                                 
                                                         
union all                                                                                    
 select   islock, 0,0,0,IsOutBill,19,null,Code,billtime,null,code,                                           
 'clBlack','����'  , '' PartNo,'' as Brand ,'' as Pack, '' as RsSurfix ,null as qty,null  as price, null  as amt,            
 IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0)   ,null,null,null,ChkTime,'0'as IsInvoice    ,                                                  
 IsTax  ,1 as BillType ,null as  TaxRate       , InvoiceDate as OrXdate , null as AcceptancebillCode ,''  as classid  ,'' DlNote, '' MNote  ,'' ClientOrderNo                         
  from sl_invoice                                                                            
 where ClientId=@ClientId                                                               
 and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate and OtherFund<>0                                                                                    
                                                          
union all                                                                                    
 select     islock, 0,1,-1,IsOutBill,19,null,Code,billtime,InvoiceDate,Code,                                                                          
 'clBlack','�����տ� '           
 , '' PartNo, '' as Brand ,'' as Pack,'' as RsSurfix , null qty , null price, PayFund as amt,    null,PayFund,null,null ,ChkTime,'0'as IsInvoice   ,                                                  
 IsTax   ,1 as BillType ,null as  TaxRate      , InvoiceDate as OrXdate  , null as AcceptancebillCode ,''  as classid    ,'' DlNote, '' MNote ,'' ClientOrderNo                           
 from sl_invoice                                                                           
 where ClientId=@ClientId                                                                           
 and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate and PayFund<>0                                                                             
/*                                                                                 
union all                                                                                    
  select null as   islock, 0,1,-1,-1,19,null,m.Code,d.ClsDate,d.ClsDate,m.Code,                                                                          
 'clBlack','����ȡ�� '+m.Code            
 , '' PartNo, '' as Brand ,'' as Pack,   null,sum(d.RmnQty*d.Price),null,null,null as ChkTime,'0'as IsInvoice  ,                                                  
 m.IsTax ,1 as BillType  ,null as  TaxRate     ,m.InvoiceDate as OrXdate    , null as AcceptancebillCode ,''  as classid                                       
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code                                                         
  where m.ClientId=@ClientId                                                         
 and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate group by d.ClsDate,m.Code, m.IsTax, m.InvoiceDate             
 */                                                                         
                                                                          
union all                                                                                    
                                                                                                             
 select null as   islock, 0,0,-1,-1,19,null,m.Code,d.ClsDate,null,m.Code,                                                 
 'clBlack','����ȡ�� '             
 ,d.PartNo,  d.Brand ,d.Pack ,wr.RsSurfix ,null qty , null price, d.Price*d.RmnQty as amt,  null,d.Price*d.RmnQty  ,null,null,ChkTime,case when isnull(FpID,'')<>'' then 1 else 0 end as IsInvoice   ,                                                  
 m.IsTax  ,1 as BillType ,null as  TaxRate  ,m.InvoiceDate as OrXdate , null as AcceptancebillCode   ,wr.ClassId  ,'' DlNote, '' MNote    ,'' ClientOrderNo                           
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code             
  join wr_ware wr on d.WareId =wr.Id                                   
 where ClientId=@ClientId and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate                                                                                    
               /*                                                                     
union all                                           
 select null as   islock, 0,1,1,IsOutBill,20,null,Code,billtime,ReturnDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'s�˻�'            
 , '' as Brand ,'' as Pack, null,GetFund,null,IsOutBill ,ChkTime,'0'as IsInvoice  ,                              
 IsTax  ,1 as BillType ,null as  TaxRate , ReturnDate   as OrXdate  , null as AcceptancebillCode  ,''  as classid                                
 from sl_return                                                                          
  where ClientId=@ClientId    and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                                                                              
                         */                                       
                                                              
union all     --+d.Brand+space(8-len(d.Brand))+d.pack+space(6-len(d.pack))                                               
 select null as   islock,0,1,1,m.IsOutBill,20,d.dlId,m.Code,m.billtime,m.ReturnDate,m.code,                                                                          
 'clBlack','s�˻� '            
 , d.PartNo, d.Brand ,d.Pack,wr.RsSurfix , d.Qty ,   d.Price , d.Qty * d.Price AS amt,  null, d.Qty * d.Price,null,d.IsOutBill ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                                 
 m.IsTax ,1 as BillType ,null as  TaxRate   , m.ReturnDate   as OrXdate   , null as AcceptancebillCode  ,''  as classid     ,d.DlNote, m.note as MNote    ,'' ClientOrderNo                                    
 from sl_returndl d,sl_return m  ,wr_ware wr                                                                        
 where d.ReturnId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                           
 and m.ReturnDate>=@BeginDate and m.ReturnDate<=@EndDate                                                                             
                                                                                
 union all                                                                                    
 select null as   islock,0,0,1,IsOutBill,20,null,Code,billtime,null,null,                                                                          
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))            
 ,'' PartNo, '' as Brand ,'' as Pack,'' as RsSurfix,null qty, null price, null as amt,  null,null,null,null ,ChkTime,'0'as IsInvoice    ,                                                  
 IsTax    ,1 as BillType ,null as  TaxRate   , ReturnDate   as OrXdate  , null as AcceptancebillCode    ,''  as classid  ,'' DlNote, '' MNote  ,'' ClientOrderNo                      
 from sl_return                                                 
  where ClientId=@ClientId                                 
 and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate and OtherFund<>0                                                                                    
                     /*                            
union all                                                                                  
 select null as islock,0,1,1,IsOutBill,9 ,null,Code,billtime,ArriveDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���� '+Code            
 ,  '' as Brand ,'' as Pack,null, GetFund,null,IsOutBill ,ChkTime,null as IsInvoice    ,                                                  
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax  ,1 as BillType ,                                                                    
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                                                   
 ,  ArriveDate   as OrXdate    , null as AcceptancebillCode        ,''  as classid                  
 from ph_arrive          where ClientId=@ClientId and ArriveDate>=@BeginDate and ArriveDate<=@EndDate                     
                        */                                                    
                                                                               
                                                                    
union all                                           
  select null as   islock,0,1,1,m.IsOutBill,9,d.dlId,m.Code,m.billtime,m.ArriveDate ,m.Code,                                                                          
 'clBlack','���� '           
 , d.PartNo, d.Brand ,d.Pack,wr.RsSurfix ,d.Qty, d.Price, d.Qty*d.Price as amt, null,  d.Price*d.Qty     ,null,d.IsOutBill ,ChkTime,null as IsInvoice    ,         
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType ,                                                      
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                                                       
 ,  m.ArriveDate   as OrXdate   , null as AcceptancebillCode       ,wr.classid    ,d.DlNote, m.Note as  MNote  ,'' ClientOrderNo                 
 from ph_arrivedl d,ph_arrive m  ,wr_ware wr                                                                         
 where d.ArriveId=m.Code and d.WareId = wr.Id  and m.ClientId=@ClientId                                                                           
 and m.ArriveDate>=@BeginDate and m.ArriveDate<=@EndDate                                                        
                                                                              
union all                                                                                    
 select null as   islock,0,0,1,IsOutBill,9,null,Code,billtime,null,null,                                                                          
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))            
 , '' PartNo, '' as Brand ,'' as Pack,'' as RsSurfix, null Qty,null Price, null as amt,  null,null,null,null ,ChkTime ,null as IsInvoice    ,                                                  
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax ,1 as BillType  ,                                                      
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                                                       
 ,  ArriveDate   as OrXdate     , null as AcceptancebillCode      ,''  as classid ,'' DlNote, '' MNote  ,'' ClientOrderNo                                           
 from ph_arrive                                                                       
 where ClientId=@ClientId                                                                           
 and ArriveDate>  =@BeginDate and ArriveDate<=@EndDate and OtherFund<>0                                                                                    
             /*          
union all                                                                                    
 select null as   islock,0,1,0,IsOutBill,13,null,Code,billtime,ReturnDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'p�˻�'            
 ,   '' as Brand ,'' as Pack,                                                                         
 GetFund,null,null,IsOutBill ,ChkTime,null as IsInvoice  , IsTax ,1 as BillType             
 ,null as  TaxRate        ,   ReturnDate   as OrXdate  , null as AcceptancebillCode     ,''  as classid                     
 from ph_return where ClientId=@ClientId                                                            
  and ReturnDate>=@BeginDate and ReturnDate<=@EndDate */                                                                            
                                                                        
union all                                                                                    
 select null as   islock,0,1,0,m.IsOutBill,13,d.dlId,m.Code,m.billtime,m.ReturnDate,m.Code,                                                                          
 'clBlack','p�˻�'             
 ,  d.PartNo, d.Brand ,d.Pack,wr.RsSurfix , d.Qty, d.Price, d.Qty*d.Price as amt, d.Qty *d.Price ,null,null,d.IsOutBill ,ChkTime,null as IsInvoice    ,                                                  
 m.IsTax  ,1 as BillType ,null as  TaxRate   ,   m.ReturnDate   as OrXdate , null as AcceptancebillCode  ,wr.ClassId  ,d.DlNote, m.note as MNote    ,'' ClientOrderNo                   
 from ph_returndl d,ph_return m ,wr_ware wr                                                                         
 where d.ReturnId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                           
 and m.ReturnDate>=@BeginDate and m.ReturnDate<=@EndDate                  
                   
                                                                          
union all                                                
 select null as   islock,0,0,0,IsOutBill,13,null,Code,billtime,null,null,                                                                          
 'clBlack','����'+space(20)+cast(IsNull((select sum(Fund) from fn_billshld where MasterKey=ClientKey),0) as varchar(20))            
 ,'' PartNo,   '' as Brand ,'' as Pack,'' as RsSurfix, null Qty, null Price, null  as amt,  null,null,null,null ,ChkTime,null as IsInvoice     ,                                                  
 IsTax    ,1 as BillType ,null as  TaxRate      ,   ReturnDate   as OrXdate , null as AcceptancebillCode   ,''  as classid   ,'' DlNote, '' MNote  ,'' ClientOrderNo                                   
 from ph_return  where ClientId=@ClientId                                                                           
 and ReturnDate>  =@BeginDate and ReturnDate<=@EndDate and OtherFund<>0                  
                                    /*                                         
union all                                                                                    
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'����'            
 ,  '' as Brand ,'' as Pack,      null,WareFund,null,IsOutBill,ChkTime,null as IsInvoice  ,                                                  
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax    ,1 as BillType ,              
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                                                       
   ,    InDate   as OrXdate  , null as AcceptancebillCode     ,''  as classid                     
  from wh_in                                                                          
  where  ClientId=@ClientId                                           
 and InTypeId='I08' and InDate>=@BeginDate and InDate<=@EndDate   */                                                                           
union all                                                                                    
  select null as   islock,0,1,1,m.IsOutBill,21,d.dlId,m.Code,m.billtime,m.InDate,m.Code,                                                                            
 'clBlack','����'              
 , d.PartNo,   d.Brand ,d.Pack, wr.RsSurfix ,d.Qty, d.Price, d.Qty*d.Price as amt,  null,  d.Qty*d.Price   ,null,d.IsOutBill ,ChkTime,null as IsInvoice     ,                                                  
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax      ,1 as BillType ,                                                      
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                                                       
   ,    m.InDate   as OrXdate  , null as AcceptancebillCode    ,wr.ClassId  ,'' DlNote, '' MNote    ,'' ClientOrderNo                 
 from wh_indl d,wh_in m ,wr_ware wr                                                                         
 where d.InId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                                                                           
 and m.InTypeId='I08' and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                                                    
         /*                                                                           
union all                                                                           
 select null as   islock,0,1,0,IsOutBill,22,null,Code,OutDate,billtime,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'���',  '' as Brand ,'' as Pack,                                                                          
 WareFund,null,null,IsOutBill ,ChkTime,null as IsInvoice     ,                                                  
 0 AS IsTax ,1 as BillType ,null as  TaxRate    ,    OutDate   as OrXdate   , null as AcceptancebillCode  ,''  as classid                        
 from wh_out                                                                           
 where ClientId=@ClientId                                                                           
 and OutTypeId='X08' and OutDate>=@BeginDate and OutDate<=@EndDate   */                                                                             
                                                                                 
union all                                                                                    
 select null as   islock,0,1,0,m.IsOutBill,22,d.dlId,m.Code,m.billtime,m.OutDate ,m.Code,                                                                          
 'clBlack','���'               
 , d.PartNo, d.Brand ,d.Pack, wr.RsSurfix , d.Qty, d.Price, d.Qty*d.Price as amt,d.Qty*d.Price , null,null,d.IsOutBill ,ChkTime,null as IsInvoice     ,                                                  
 0 AS IsTax ,1 as BillType  ,null as  TaxRate  ,    m.OutDate   as OrXdate  , null as AcceptancebillCode ,wr.ClassId  ,'' DlNote, '' MNote    ,'' ClientOrderNo                    
 from wh_outdl d,wh_out m   ,wr_ware wr                                                                       
 where d.OutId=m.Code and d.WareId =wr.id and m.ClientId=@ClientId                                          
  and m.OutTypeId='X08' and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                                                                  
           /*                                                                          
union all                                                                                    
 select null as   islock,0,1,1,IsOutBill,21,null,Code,billtime,InDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'��ص������'            
 , '' PartNo,   '' as Brand ,'' as Pack,  null,WareFund,null,null ,ChkTime,null as IsInvoice     ,                                                  
case when Isnull(TaxRate,0)>0 then 1 else 0 end AS IsTax       ,1 as BillType,                                                     
case when isnull(TaxRate,0)>0 then convert(varchar(5),TaxRate*100)+'%' else null end  as TaxRate                                                       
,    inDate   as OrXdate   , null as AcceptancebillCode     ,''  as classid                     
 from wh_in                                                                           
 where  ClientId=@ClientId and InTypeId='I09'                                                                           
 and InDate>=@BeginDate and InDate<=@EndDate   */                                     
union all                                                          
 select null as   islock,0,1,1,m.IsOutBill,21,d.dlid,m.Code,m.billtime,m.InDate , m.Code,                                                 
 'clBlack','��ص������'             
 , d.PartNo, d.Brand ,d.Pack,wr.RsSurfix ,d.Qty, d.Price, d.Qty*d.Price as amt, null,d.Qty*d.Price ,null,d.IsOutBill,ChkTime,null as IsInvoice     ,                                                  
case when Isnull(m.TaxRate,0)>0 then 1 else 0 end AS IsTax         , 1 as BillType ,                                                      
case when isnull(m.TaxRate,0)>0 then convert(varchar(5),m.TaxRate*100)+'%' else null end  as TaxRate                                                       
,    m.inDate   as OrXdate   , null as AcceptancebillCode  , wr.ClassId   ,'' DlNote, '' MNote      ,'' ClientOrderNo                
 from wh_indl d,wh_in m  ,wr_ware wr                                                                        
 where d.InId=m.Code and d.WareId =wr.Id  and m.ClientId=@ClientId                             
 and m.InTypeId='I09' and m.InDate>=@BeginDate and m.InDate<=@EndDate                                                                                    
                         /*                                                           
union all                                                                                    
 select null as   islock,0,1,0,IsOutBill,22,null,Code,billtime,OutDate,Code,                                                
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'��ص������'            
 ,  '' PartNo,    '' as Brand ,'' as Pack,   WareFund,null,null,null ,ChkTime,null as IsInvoice     ,                                                  
 0 AS IsTax  ,1 as BillType ,null as  TaxRate ,    OutDate   as OrXdate  , null as AcceptancebillCode  ,''  as classid                        
 from wh_out                                                                           
 where ClientId=@ClientId and OutTypeId='X09' and OutDate>=@BeginDate and OutDate<=@EndDate    */                                                                         
                                                                             
                                                               
union all                                     
  select null as   islock,0,1,0,m.IsOutBill,22,d.dlid,m.Code,m.billtime, m.OutDate , m.Code,                                                                
 'clBlack',   case when m.OutTypeId='X09' then '��ص������' else '��Ʒ����' end          
 ,  d.PartNo,  d.Brand ,d.Pack, wr.RsSurfix ,d.Qty, case when m.OutTypeId='X09' then d.Price else null end,   case when m.OutTypeId='X09' then d.Qty*d.Price else null end as amt, case when m.OutTypeId='X09' then d.Qty*d.Price else null end  ,null,null,d.
IsOutBill ,ChkTime  ,null as IsInvoice     ,                                                  
0 AS IsTax   ,1 as BillType   ,null as  TaxRate   ,    m.OutDate   as OrXdate   , null as AcceptancebillCode  ,wr.classid ,'' DlNote, '' MNote     ,'' ClientOrderNo                     
from wh_outdl d,wh_out m   ,wr_ware wr                                                                       
 where d.OutId=m.Code and d.WareId=wr.Id  and m.ClientId=@ClientId                                                                           
 and m.OutTypeId   in  ( 'X09','X04') and m.OutDate>=@BeginDate and m.OutDate<=@EndDate                    
                                                                         
union all                                                                                    
 select null as   islock,0,1,-1,-1,case when isnull(isAcceptancebill,0)=0 then  20 else 48 end as billid   ,null,Code,billtime,ReceiverDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end)                      
 ,case when isAcceptancebill=1 then '���жң�' else '' end +'�տ� '+(select Name from fn_item where Code=ItemId)+' '+IsNull(Note,'')                      
 , ''  PartNo,  '' as Brand ,'' as Pack,'' as RsSurfix,null Qty, null Price, PayFund as amt,   null,PayFund,null,null ,ChkTime,null as IsInvoice     ,                                                  
0 as IsTax   ,0 as BillType  ,null as  TaxRate      ,     ReceiverDate   as OrXdate ,  AcceptancebillCode ,''  as classid   ,'' DlNote, '' MNote    ,'' ClientOrderNo                     
 from fn_receiver where ClientId=@ClientId                                                                           
 and ReceiverDate>=@BeginDate and ReceiverDate<=@EndDate                                                                                    
union all                              
                      
--select isAcceptancebill * From fn_receiver                                                  
                                                                  
 select null as   islock,0,1,-1,-1,case when isnull( py.isAcceptancebill,0)=0 then  21 else 49 end as billid   ,null,py.Code,py.billtime,py.PaymentDate,py.Code,                         
 (case py.IsChk when 1 then 'clBlack' else 'clRed' end)                      
 ,case when Rec.isAcceptancebill=1 then '���жң�' else '' end+case py.IoName when '' then '���� '+IsNull((select Name from fn_item where Code=py.ItemId),0) else py.IoName end+' '+IsNull(py.Note,'')             
 ,   ''  PartNo,   '' as Brand ,'' as Pack,'' as RsSurfix, null Qty, null Price, py.PayFund as amt,  py.PayFund,null,null,  null ,py.ChkTime,null as IsInvoice   ,                                                  
0 as IsTax   ,0 as BillType  ,null as  TaxRate  ,     py.PaymentDate   as OrXdate  , Rec.AcceptancebillCode  ,''  as classid ,'' DlNote, '' MNote ,'' ClientOrderNo                          
 from fn_payment py                         
 left join fn_receiver Rec on Rec.Code = py.ReceiverCode               
 where py.ClientId = @ClientId                                                                           
 and py.PaymentDate>=@BeginDate and py.PaymentDate<=@EndDate                                                                              
                                                                      
union all                            
select null as   islock,0,1,-1,-1, 23  as billid                             
 ,null,Code,billtime,InDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'Ӧ�� '+(select Name from fn_item where Code=ItemId)            
 ,  '' PartNo,  '' as Brand ,'' as Pack,'' as RsSurfix,null Qty, null Price, PayFund as amt,  PayFund,null,null,null ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                               
IsTax  ,0 as BillType ,null as  TaxRate  ,    InDate   as OrXdate , null as AcceptancebillCode    ,''  as classid  ,'' DlNote, '' MNote   ,'' ClientOrderNo                    
from fn_shldin                                                                   
 where ClientId=@ClientId and InDate>=@BeginDate and InDate<=@EndDate                                                                                    
union all                                                                                    
 select null as   islock,0,1,-1,-1,  24  as billid                             
 ,null,Code,billtime,OutDate,Code,                               
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'Ӧ�� '+(select Name from fn_item where Code=ItemId)            
 ,   '' PartNo,   '' as Brand ,'' as Pack,'' as RsSurfix, null Qty, null Price, PayFund as amt,  null,PayFund,null,null ,ChkTime,case when isnull(FpID,'')<>'' then '1' else '0' end as IsInvoice    ,                                                  
 IsTax ,0 as BillType ,null as  TaxRate ,    OutDate   as OrXdate  , null as AcceptancebillCode    ,''  as classid ,'' DlNote, '' MNote  ,'' ClientOrderNo                      
 from fn_shldout            
 where ClientId=@ClientId and OutDate>=@BeginDate and OutDate<=@EndDate                                                                                    
union all                                                                                    
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'�ͻ�ת��(��)�� '+OutName            
 ,  '' PartNo,      '' as Brand ,'' as Pack,'' as RsSurfix,null Qty, null Price, PayFund as amt,  PayFund,null,null,null,ChkTime,null as IsInvoice    ,                                                  
0 as  IsTax    ,0 as BillType ,null as  TaxRate ,TrnsfrDate as OrXdate  , null as AcceptancebillCode   ,''  as classid  ,'' DlNote, '' MNote  ,'' ClientOrderNo                      
  from fn_clntransfer                                                                           
 where InId=@ClientId and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                                                                
                                                                           
union all                                                                           
 select null as   islock,0,1,-1,-1,27,null,Code,billtime,TrnsfrDate,Code,                                                                          
 (case IsChk when 1 then 'clBlack' else 'clRed' end),'�ͻ�ת��(��)�� '+InName            
 , '' PartNo,  '' as Brand ,'' as Pack,'' as RsSurfix,null Qty, null Price, PayFund as amt,  null,PayFund,null,null ,ChkTime,null as IsInvoice    ,                                                  
0 as  IsTax ,0 as BillType ,null as TaxRate ,TrnsfrDate as OrXdate , null as AcceptancebillCode   ,''  as classid  ,'' DlNote, '' MNote ,'' ClientOrderNo                       
 from fn_clntransfer                                                                           
 where OutId=@ClientId and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                  
                                                                           
union all                                                                                    
select null as   islock,1,1,9,-1,-1,null,null,null,null,null,'clBlack','��    ��', '' as PartNo, '' as Brand ,'' as Pack,'' as RsSurfix,null Qty, null Price, null as amt,                                                              
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
      ,null  ,null as ChkTime      ,null as IsInvoice     ,                                                  
      null as IsTax  ,-1 as BillType  ,null as  TaxRate ,null as OrXdate  , null as AcceptancebillCode  ,''  as classid   ,'' DlNote, '' MNote ,'' ClientOrderNo                          
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
                             
update #a set InQty=(select sum(InQty) from #a) ,OutQty=(select sum(OutQty) from #a)         
              ,amt =(select sum(amt) from #a)   where xorder=1                                
                                                                                    
                                                                          
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
                                
select top 0 * ,convert(bit,IsInvoice ) as NewIsInvoice    into #RltSet  from #a           
                                
                                
if @UseWhichDate='�Ƶ�ʱ��'                                                          
begin                                                                        
                                                         
 insert into #RltSet                                
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder =-1                                                        
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice                                                              
 from #a where ( billtime>=@begindate or billtime is null)  and xorder =0 --and billtime<=@endDate                                                           
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                        
 order by xorder,billtime,Order_Code  , iscalc desc                              
                                                          
  select a.*,  cls.name as class From #RltSet    a  left join  wr_class cls on  a.classid = cls.Code          
     order by xorder,Billtime,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId            
end                                                                                   
if @UseWhichDate='���ʱ��'                                                                            
begin                                                          
 insert into #RltSet                                                                             
 select * ,convert(bit,IsInvoice ) as NewIsInvoice      from #a where xorder =-1                                                        
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice               
 from #a where (CHktime>=@begindate or CHktime is null)  and xorder =0 --and billtime<=@endDate                                                           
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                        
 order by xorder,CHktime,Order_Code  , iscalc desc                                                         
                                                   
 select a.*,  cls.name as class From #RltSet    a  left join  wr_class cls on  a.classid = cls.Code           
   order by xorder,CHktime,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId                     
end                                                
if @UseWhichDate='����'                                                                            
begin                                                                                                     
 insert into #RltSet                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice      from #a where xorder =-1                                                        
 union all                                                   
 select * ,convert(bit,IsInvoice ) as NewIsInvoice                                                             
 from #a where ( xDate>=@begindate or xDate is null)  and xorder =0 --and billtime<=@endDate                                                           
 union all                                                         
 select * ,convert(bit,IsInvoice ) as NewIsInvoice     from #a where xorder = 1                                                        
 order by xorder,OrXdate,Order_Code  , iscalc desc                                                         
                          
 select a.*,  cls.name as class From #RltSet   a left join wr_class cls on  a.classid = cls.Code          
     order by xorder,OrXdate,Order_Code  , iscalc desc ,classid ,Brand,Pack ,dlId                                                        
end                                                                            
                                                                   
                                                                    
--select * ,convert(bit,IsInvoice ) as NewIsInvoice,IsTax  from #a order by xorder,Billtime,Order_Code  , iscalc desc                                                                                  
--select *From #RltSet          --    order by xorder,Billtime,Order_Code  , iscalc desc                                                                                  
                                
drop table #RltSet                                
drop table #a                                                                                  
                                                                        