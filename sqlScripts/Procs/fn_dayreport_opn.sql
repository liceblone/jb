alter PROCEDURE [fn_dayreport_opn]                   
                 @WhId varchar(20),                  
                 @BeginDate datetime,                  
                 @EndDate datetime                  
                  
AS                  
                  
if @WhId is null                  
  set @WhId=''                  
set @WhId=@WhId+'%'                  
                  
set @EndDate=@EndDate+1                  
                  
delete from fn_billshld where MasterKey not in (select ClientKey from sl_invoice union all select ClientKey from sl_return union all select ClientKey from ph_arrive union all select ClientKey from ph_return)                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(GetFund)  from ph_arrive  where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(GetFund)  from ph_return  where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
--                +IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m. IsChk=1 and m.WhId like @WhId and d.ClsDate>=@BeginDate and d.ClsDate<@EndDate),0)                                  
                +IsNull((select sum(WareFund)  from wh_in  where IsChk=1 and WhId like @WhId and (InTypeId='I08' or InTypeId='I09') and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund)  from fn_ShldOut where IsChk=1 and WhId like @WhId  and ItemId<>'0100' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund)  from fn_ShldIn  where IsChk=1 and WhId like @WhId and ItemId='0101' and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
          
         OutFund=IsNull((select sum(GetFund-OtherFund-WareFund*TaxRate) from ph_arrive where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(WareFund)  from wh_out  where IsChk=1 and WhId like @WhId and OutTypeId='X09' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
          
         --       -IsnUll((select sum(GetFund-OtherFund) from ph_return where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
         --       +IsNull((select sum(WareFund)  from wh_in  where IsChk=1 and WhId like @WhId and (InTypeId='I08' or InTypeId='I09') and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
         -- after update          
                -IsnUll((select sum((GetFund-OtherFund)*(1-isnull(TaxRate,0))) from ph_return where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(WareFund*(1-isnull(TaxRate,0)))  from wh_in  where IsChk=1 and WhId like @WhId and InTypeId='I08' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(WareFund)  from wh_in  where IsChk=1 and WhId like @WhId and InTypeId='I09' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
          
                -IsNull((select sum(PayFund)  from fn_shldin  where IsChk=1 and WhId like @WhId and ItemId='0101' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund)  from fn_shldout where IsChk=1 and WhId like @WhId and ItemId='0101' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
       where Id=1                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(GetFund)  from sl_retail   where FnIsChk=1 and WhId like @WhId and FnChkTime>@BeginDate and FnChkTime<@EndDate),0)                  
                +IsNull((select sum(GetFund-OtherFund) from sl_invoice  where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(WareFund)  from wh_out   where IsChk=1 and WhId like @WhId and OutTypeId='X08' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund)  from fn_shldin   where IsChk=1 and WhId like @WhId and ItemId='0100' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund)  from fn_shldout  where IsChk=1 and WhId like @WhId and ItemId='0100' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(d.RmnQty*d.Price)  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and m.WhId like @WhId and d.ClsDate>=@BeginDate and d.ClsDate<@EndDate),0)                  
                -IsNUll((select sum(GetFund-OtherFund) from sl_return  where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
         OutFund=IsNull((select sum(PayFund)  from fn_receiver  where IsChk=1 and WhId like @WhId and BankId like '000%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund)  from fn_payment  where IsChk=1 and WhId like @WhId and BankId like '000%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund)  from sl_invoice  where FnIsChk=1 and WhId like @WhId and BankId like '000%' and FnChkTime>@BeginDate and FnChkTime<@EndDate),0)                  
                +IsNull((select sum(GetFund)  from sl_retail   where FnIsChk=1 and WhId like @WhId and FnChkTime>@BeginDate and FnChkTime<@EndDate),0)                   
                +IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1 and iChkTime>@BeginDate and iChkTime<@EndDate and InId like '000%'),0)                  
                -IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1  and iChkTime>@BeginDate and iChkTime<@EndDate and OutId like '000%'),0)                  
       where Id=2                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(PayFund) from fn_shldin  where IsChk=1 and WhId like @WhId and ItemId like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_shldout  where IsChk=1 and WhId like @WhId and ItemId like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_invoice s on f.MasterKey=s.ClientKey where s.IsChk=1 and s.WhId like @WhId and f.FnItmCode like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_return p on f.MasterKey=p.ClientKey where p.IsChk=1 and p.WhId like @WhId and f.FnItmCode like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_arrive p on f.MasterKey=p.ClientKey where p.IsChk=1 and p.WhId like @WhId and f.FnItmCode like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_return s on f.MasterKey=s.ClientKey where IsChk=1 and WhId like @WhId and f.FnItmCode like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund) from fn_receiver  where IsChk=1 and WhId like @WhId and ItemId like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_payment  where IsChk=1 and WhId like @WhId and ItemId like '0150%' and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
         OutFund=IsNull((select sum(PayFund) from fn_receiver  where IsChk=1 and WhId like @WhId and BankId like '001%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_payment  where IsChk=1 and WhId like @WhId and BankId like '001%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund) from sl_invoice  where FnIsChk=1 and WhId like @WhId and BankId like '001%' and FnChkTime>@BeginDate and FnChkTime<@EndDate),0)                   
                +IsNull((select sum(PayFund) from fn_bnktransfer where IsiChk=1 and iChkTime>@BeginDate and iChkTime<@EndDate and InId like '001%'),0)                  
                -IsNull((select sum(PayFund) from fn_bnktransfer where IsiChk=1  and iChkTime>@BeginDate and iChkTime<@EndDate and OutId like '001%'),0)                  
       where Id=3                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(PayFund) from fn_receiver  where IsChk=1 and WhId like @WhId and ItemId='0121' and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
         OutFund=IsNull((select sum(PayFund) from fn_payment  where IsChk=1 and WhId like @WhId and ItemId='0131' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
       where Id=4                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(PayFund) from fn_receiver   where IsChk=1 and WhId like @WhId and ItemId='0120' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund) from sl_invoice   where FnIsChk=1 and WhId like @WhId and FnChkTime>@BeginDate and FnChkTime<@EndDate),0)                   
                +IsNull((select sum(PayFund) from fn_clntransfer where IsChk=1 and ChkTime>@BeginDate and ChkTime<@EndDate),0) ,                  
         OutFund=IsNull((select sum(PayFund) from fn_payment   where IsChk=1 and WhId like @WhId and ItemId='0130' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                   
                +IsNull((select sum(PayFund) from fn_clntransfer where IsChk=1 and ChkTime>@BeginDate and ChkTime<@EndDate),0)                   
       where Id=5                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(PayFund) from fn_receiver where IsChk=1 and WhId like @WhId and ItemId like '0140%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_payment  where IsChk=1 and WhId like @WhId and ItemId like '0140%' and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
         OutBrief=IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and m.WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0),                   
          OutFund=0                  
       where Id=7                  
                  
update fn_dayreport set                   
--(select sum(PayFund) from #xxx where ItemId like '0112%'),                  
          InFund=IsNull((select sum(PayFund)  from fn_shldin  where IsChk=1 and WhId like @WhId and ItemId like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund)  from fn_shldout where IsChk=1 and WhId like @WhId and ItemId like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(f.Fund)   from fn_billshld f inner join sl_invoice s on f.MasterKey=s.ClientKey where s.IsChk=1 and s.WhId like @WhId and f.FnItmCode like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_return p on f.MasterKey=p.ClientKey where p.IsChk=1 and p.WhId like @WhId and f.FnItmCode like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join ph_arrive p on f.MasterKey=p.ClientKey where p.IsChk=1 and p.WhId like @WhId and f.FnItmCode like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(TaxRate*WareFund) from ph_arrive where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(f.Fund)  from fn_billshld f inner join sl_return s on f.MasterKey=s.ClientKey where s.IsChk=1 and WhId like @WhId and f.FnItmCode like '0112%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                 
         -- after update  ,          
    +IsnUll((select sum(  (GetFund-OtherFund)*isnull(TaxRate,0)  ) from ph_return where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)          
                -IsNull((select sum(WareFund*isnull(TaxRate,0))  from wh_in  where IsChk=1 and WhId like @WhId and InTypeId='I08' and ChkTime>@BeginDate and ChkTime<@EndDate),0)  ,                
          
          
            
         OutFund=IsNull((select sum(GetFund)  from sl_invoice where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(GetFund)  from sl_return  where IsChk=1 and WhId like @WhId and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(PayFund)  from fn_ShldIn  where IsChk=1 and WhId like @WhId and ItemId<>'0101' and  ChkTime>@BeginDate and ChkTime<@EndDate),0)                                 
                +IsNull((select sum(WareFund)  from wh_out  where IsChk=1 and WhId like @WhId and OutTypeId='X09' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                +IsNull((select sum(WareFund)  from wh_out  where IsChk=1 and WhId like @WhId and OutTypeId='X08' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund)  from fn_ShldOut where IsChk=1 and WhId like @WhId and ItemId='0100' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
              -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m. IsChk=1 and m.WhId like @WhId and d.ClsDate>=@BeginDate and d.ClsDate<@EndDate),0)                                   
 -- +isnull((select sum(TaxRate*WareFund)  From sl_returnDL D join sl_return   M  on D.ReturnID=M.code where m. IsChk=1 and m.WhId like @WhId and ChkTime>=@BeginDate and ChkTime<@EndDate),0)                                  
                
--                -IsNull((select sum(PayFund) from sl_invoice where InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate),0)                             
--                -(select OutFund from fn_dayreport where Id=7)                  
       where Id=8                  
                  
update fn_dayreport set                   
          InFund=IsNull((select sum(PayFund) from fn_receiver  where IsChk=1 and WhId like @WhId and ItemId like '0170%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_payment where IsChk=1 and WhId like @WhId and ItemId like '0170%' and ChkTime>@BeginDate and ChkTime<@EndDate),0),                  
         OutFund=IsNull((select sum(PayFund) from fn_payment  where IsChk=1 and WhId like @WhId and ItemId like '0160%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
                -IsNull((select sum(PayFund) from fn_receiver  where IsChk=1 and WhId like @WhId and ItemId like '0160%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                  
       where Id=9                  
                  
                  
 update fn_dayreport  set                                 
         OutFund=      
                IsNull((select sum(PayFund)  from fn_receiver  where IsChk=1 and   WhId like @WhId and BankId like '00201%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                                
                -IsNull((select sum(PayFund)  from fn_payment  where  IsChk=1 and  WhId like @WhId and BankId like '00201%' and ChkTime>@BeginDate and ChkTime<@EndDate),0)                                
                +IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1 and iChkTime>@BeginDate and iChkTime<@EndDate and InId like '00201%'),0)                                
                -IsNull((select sum(PayFund)  from fn_bnktransfer  where IsiChk=1  and iChkTime>@BeginDate and iChkTime<@EndDate and OutId like '00201%'),0)                                
       where Id=11         
               
		               
			select    rgl.WareId ,rgl.Qty,  rgl.price  into #rgl   
			from wh_regulate  rgl      where xDate >@BeginDate and xDate <@EndDate and  WhId like ISNULL(@whid,'%')       and rgl.Qty is not null     
		union all
			select  dl.WareId, dl.Qty , dl.Price  from wh_in m join wh_indl dl on m.Code =dl.InId    
			where m.InTypeId ='I99' and m.ChkTime >@BeginDate and  m.ChkTime <@EndDate and  m.WhId like ISNULL(@whid,'%') 
		union all 
			select dl.WareId,-dl.Qty , dl.Price   from wh_out m join wh_outdl dl on m.Code =dl.OutId   
			where m.OutTypeId ='X99' and m.ChkTime >@BeginDate and  m.ChkTime <@EndDate and  m.WhId like ISNULL(@whid,'%')



       --   елс╝ел©В    
       update fn_dayreport set InFund =  ( select SUM(qty*price) from #rgl  )    
                               ,OutFund =( select SUM(qty*price) from #rgl  )    
       where ID = 14     
               
update fn_dayreport set InFund=IsNull((select sum(InFund) from fn_dayreport where Id<>10),0)      
                       ,OutFund=IsNull((select sum(OutFund) from fn_dayreport where Id<>10),0) where Id=10                  
--update fn_dayreport set InFund=IsNull((select sum(InFund) from fn_dayreport where Id not in (10,5)),0),OutFund=IsNull((select sum(OutFund) from fn_dayreport where Id not in (10,5)),0) where Id=10                  
                  
--drop table #xxx    select  *  from fn_receiver  where  IsChk=1 and BankId like '00201%'             
                  
select *   from fn_dayreport        order by rowNo 