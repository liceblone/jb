alter    PROCEDURE [fn_dayreport_opn_unchk]                       
                 @WhId varchar(20),                      
                 @BeginDate datetime,                      
                 @EndDate datetime                      
                      
AS           
    
        /*       
                      
declare     
         @WhId varchar(20),                      
                 @BeginDate datetime,                      
                 @EndDate datetime        
set @WhId='001'    
set @BeginDate='2008-08-24'    
set @EndDate=getdate()    
   
 07-12-7          
   价税分离  :采购退货 , 同行入库          
          
             采购退货       进货额 减少         转入费用   减少       应收款 增加          
             同行入库(采购) 进货额 增加         转入费用   增加       应付款 增加          
          
                       
          
select (GetFund-OtherFund)*(1-isnull(TaxRate,0)) from ph_return where isnull(ischk,0)=0           
          
*/          
          
if @WhId is null                      
  set @WhId=''                      
set @WhId=@WhId+'%'                      
                      
set @EndDate=@EndDate+1                      
                      
delete from fn_billshld where MasterKey not in (select ClientKey from sl_invoice union all select ClientKey from sl_return union all select ClientKey from ph_arrive union all select ClientKey from ph_return)                      
                       
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(GetFund)  from ph_arrive  where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(GetFund)  from ph_return  where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(WareFund)  from wh_in  where    WhId like @WhId and (InTypeId='I08' or InTypeId='I09') and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund)  from fn_ShldOut where    WhId like @WhId  and ItemId<>'0100' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund)  from fn_ShldIn  where    WhId like @WhId and ItemId='0101' and billtime>@BeginDate and billtime<@EndDate),0) ,                     
              
  --12-7 add ,              
           --     +IsnUll((select sum(  (GetFund-OtherFund)*isnull(TaxRate,0)  ) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)             
            --    -IsNull((select sum(WareFund*isnull(TaxRate,0))  from wh_in  where    WhId like @WhId and InTypeId='I08' and billtime>@BeginDate and billtime<@EndDate),0)  ,                    
              
         OutFund=IsNull((select sum(GetFund-OtherFund-WareFund*TaxRate) from ph_arrive where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(WareFund)  from wh_out  where    WhId like @WhId and OutTypeId='X09' and billtime>@BeginDate and billtime<@EndDate),0)                      
              
         --       -IsnUll((select sum(GetFund-OtherFund) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
         --       +IsNull((select sum(WareFund)  from wh_in  where    WhId like @WhId and (InTypeId='I08' or InTypeId='I09') and billtime>@BeginDate and billtime<@EndDate),0)                      
         -- after update              
                -IsnUll((select sum((GetFund-OtherFund)*(1-isnull(TaxRate,0))) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(WareFund*(1-isnull(TaxRate,0)))  from wh_in  where    WhId like @WhId and InTypeId='I08' and billtime>@BeginDate and billtime<@EndDate),0)                      
                          
                +IsNull((select sum(WareFund)  from wh_in  where    WhId like @WhId and InTypeId='I09' and billtime>@BeginDate and billtime<@EndDate),0)                      
              
                -IsNull((select sum(PayFund)  from fn_shldin  where    WhId like @WhId and ItemId='0101' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund)  from fn_shldout where    WhId like @WhId and ItemId='0101' and billtime>@BeginDate and billtime<@EndDate),0)                      
      where Id=1                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(GetFund)  from sl_retail   where     WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(GetFund-OtherFund) from sl_invoice  where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(WareFund)  from wh_out   where    WhId like @WhId and OutTypeId='X08' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund)  from fn_shldin   where    WhId like @WhId and ItemId='0100' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund)  from fn_shldout  where    WhId like @WhId and ItemId='0100' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(d.RmnQty*d.Price)  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where    m.WhId like @WhId and d.ClsDate>=@BeginDate and d.ClsDate<@EndDate),0)                      
                -IsNUll((select sum(GetFund-OtherFund) from sl_return  where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0),                      
         OutFund=IsNull((select sum(PayFund)  from fn_receiver  where    WhId like @WhId and BankId like '000%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund)  from fn_payment  where    WhId like @WhId and BankId like '000%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund)  from sl_invoice  where     WhId like @WhId and BankId like '000%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(GetFund)  from sl_retail   where     WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                       
                +IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1 and billtime>@BeginDate and billtime<@EndDate and InId like '000%'),0)                      
                -IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1  and billtime>@BeginDate and billtime<@EndDate and OutId like '000%'),0)                      
       where Id=2                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund) from fn_shldin  where    WhId like @WhId and ItemId like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_shldout  where    WhId like @WhId and ItemId like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_invoice s on f.MasterKey=s.ClientKey where    s.WhId like @WhId and f.FnItmCode like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)      
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_return p on f.MasterKey=p.ClientKey where      p.WhId like @WhId and f.FnItmCode like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)               
 
        
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_arrive p on f.MasterKey=p.ClientKey where      p.WhId like @WhId and f.FnItmCode like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)               
  
       
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_return s on f.MasterKey=s.ClientKey where    WhId like @WhId and f.FnItmCode like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)                   
  
   
      +IsNull((select sum(PayFund) from fn_receiver  where    WhId like @WhId and ItemId like '0150%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_payment  where    WhId like @WhId and ItemId like '0150%' and billtime>@BeginDate and billtime<@EndDate),0),                      
         OutFund=IsNull((select sum(PayFund) from fn_receiver  where    WhId like @WhId and BankId like '001%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_payment  where    WhId like @WhId and BankId like '001%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund) from sl_invoice  where    WhId like @WhId and BankId like '001%' and billtime>@BeginDate and billtime<@EndDate),0)                       
                +IsNull((select sum(PayFund) from fn_bnktransfer where IsiChk=1 and billtime>@BeginDate and billtime<@EndDate and InId like '001%'),0)                      
                -IsNull((select sum(PayFund) from fn_bnktransfer where IsiChk=1  and billtime>@BeginDate and billtime<@EndDate and OutId like '001%'),0)                      
       where Id=3                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund) from fn_receiver  where    WhId like @WhId and ItemId='0121' and billtime>@BeginDate and billtime<@EndDate),0),                      
         OutFund=IsNull((select sum(PayFund) from fn_payment  where    WhId like @WhId and ItemId='0131' and billtime>@BeginDate and billtime<@EndDate),0)                      
       where Id=4                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund) from fn_receiver   where    WhId like @WhId and ItemId='0120' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund) from sl_invoice   where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                       
                +IsNull((select sum(PayFund) from fn_clntransfer where    billtime>@BeginDate and billtime<@EndDate),0) ,                      
         OutFund=IsNull((select sum(PayFund) from fn_payment   where    WhId like @WhId and ItemId='0130' and billtime>@BeginDate and billtime<@EndDate),0)                       
                +IsNull((select sum(PayFund) from fn_clntransfer where    billtime>@BeginDate and billtime<@EndDate),0)                       
       where Id=5                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund) from fn_receiver where    WhId like @WhId and ItemId like '0140%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_payment  where    WhId like @WhId and ItemId like '0140%' and billtime>@BeginDate and billtime<@EndDate),0),                      
         OutBrief=IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where    m.WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0),                       
          OutFund=0                      
       where Id=7                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund)  from fn_shldin  where    WhId like @WhId and ItemId like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund)  from fn_shldout where    WhId like @WhId and ItemId like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(f.Fund)   from fn_billshld f inner join sl_invoice s on f.MasterKey=s.ClientKey where isnull( s.ischk,0)=0 and s.WhId like @WhId and f.FnItmCode like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)            
  
          
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_return p on f.MasterKey=p.ClientKey where      p.WhId like @WhId and f.FnItmCode like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)               
  
       
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_arrive p on f.MasterKey=p.ClientKey where    p.WhId like @WhId and f.FnItmCode like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)              
  
        
                -IsNull((select sum(TaxRate*WareFund) from ph_arrive where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_return s on f.MasterKey=s.ClientKey where    WhId like @WhId and f.FnItmCode like '0112%' and billtime>@BeginDate and billtime<@EndDate),0)                 
  
    
         --5-19 after update  ,              
                +IsnUll((select sum(  (GetFund-OtherFund)*isnull(TaxRate,0)  ) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)              
                -IsNull((select sum(WareFund*isnull(TaxRate,0))  from wh_in  where    WhId like @WhId and InTypeId='I08' and billtime>@BeginDate and billtime<@EndDate),0)  ,                    
         --12-7 after update  ,              
          --      -IsnUll((select sum(  (GetFund-OtherFund)*isnull(TaxRate,0)  ) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)              
           --     +IsNull((select sum(WareFund*isnull(TaxRate,0))  from wh_in  where    WhId like @WhId and InTypeId='I08' and billtime>@BeginDate and billtime<@EndDate),0)  ,                    
              
              
                
         OutFund=IsNull((select sum(GetFund)  from sl_invoice where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(GetFund)  from sl_return  where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(PayFund)  from fn_ShldIn  where    WhId like @WhId and ItemId<>'0101' and  billtime>@BeginDate and billtime<@EndDate),0)                                     
                +IsNull((select sum(WareFund)  from wh_out  where    WhId like @WhId and OutTypeId='X09' and billtime>@BeginDate and billtime<@EndDate),0)                      
                +IsNull((select sum(WareFund)  from wh_out  where    WhId like @WhId and OutTypeId='X08' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund)  from fn_ShldOut where    WhId like @WhId and ItemId='0100' and billtime>@BeginDate and billtime<@EndDate),0)                      
              -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where     m.WhId like @WhId and d.ClsDate>=@BeginDate and d.ClsDate<@EndDate),0)                                    
  
   
               
  --12-7 add ,              
    --           +IsnUll((select sum(  (GetFund-OtherFund)*isnull(TaxRate,0)  ) from ph_return where    WhId like @WhId and billtime>@BeginDate and billtime<@EndDate),0)              
--                +IsNull((select sum(WareFund*isnull(TaxRate,0))  from wh_in  where    WhId like @WhId and InTypeId='I08' and billtime>@BeginDate and billtime<@EndDate),0)                      
              
          
       where Id=8                      
                      
update fn_dayreport_unchk set                       
          InFund=IsNull((select sum(PayFund) from fn_receiver  where    WhId like @WhId and ItemId like '0170%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_payment where    WhId like @WhId and ItemId like '0170%' and billtime>@BeginDate and billtime<@EndDate),0),                      
         OutFund=IsNull((select sum(PayFund) from fn_payment  where    WhId like @WhId and ItemId like '0160%' and billtime>@BeginDate and billtime<@EndDate),0)                      
                -IsNull((select sum(PayFund) from fn_receiver  where      WhId like @WhId and ItemId like '0160%' and billtime>@BeginDate and billtime<@EndDate),0)                      
       where Id=9                      
                      
update fn_dayreport_unchk set InFund=IsNull((select sum(InFund) from fn_dayreport_unchk where Id<10),0),OutFund=IsNull((select sum(OutFund) from fn_dayreport_unchk where Id<10),0) where Id=10                      
                      
select * from fn_dayreport_unchk                    
              
              
            
          
        
--select * into fn_dayreport_unchk_unchk     from fn_dayreport_unchk       
      
    
  
