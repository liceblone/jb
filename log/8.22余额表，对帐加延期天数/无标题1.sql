alter    PROCEDURE [fn_client_inout]                 
                 @ClientId varchar(50),                
                 @BeginDate datetime,                
                 @EndDate datetime,                
                 @DateType varchar(20)                
--with encryption                
AS                
-- 被 Fn_clientGatheringChk 引用 收款确认  
/*  
declare   
     @ClientId varchar(50),                
                 @BeginDate datetime,                
                 @EndDate datetime,                
                 @DateType varchar(20)         
  
set @ClientId =''  
set @BeginDate ='2007-11-15'  
set @EndDate ='2007-12-15'  
set @DateType='日期'  
*/  
   
set @EndDate=@EndDate+1                
select 0 as xorder,1 as IsCalc,19 as BillId,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end) as FntClr,billtime, InvoiceDate as xDate,ChkTime,Code as BillCode,'发货 货款:'+cast(WareFund as varchar(20))+',其它:'+cast(OtherFund as varchar(20)) as Brief, 
 
      GetFund as  InQty,null as OutQty,PayFund as RmnQty, IsTax ,1 as BillType ,GatheringChk,GatheringChkMan,GatheringChkNote ,gatheringdata  into #a                 
  from sl_invoice where ClientId=@ClientId --and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate                
union all                
select 0,1,19,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,InvoiceDate,FnChkTime,Code,'本单收款',  
      null,PayFund,null , IsTax,1 as BillType      ,GatheringChk,GatheringChkMan,GatheringChkNote  ,gatheringdata             
  from sl_invoice where ClientId=@ClientId and PayFund<>0 --and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate                
union all                
select 0,1,0,m.IsChk,(case m.IsChk when 1 then 'clBlack' else 'clRed' end),billtime,d.ClsDate,d.ClsDate,m.Code,'发货取消',  
      null,d.RmnQty*d.Price,null  , IsTax         ,1 as BillType      ,m.GatheringChk,m.GatheringChkMan,m.GatheringChkNote ,m.gatheringdata    
  from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and m.ClientId=@ClientId and d.ClsDate>=@BeginDate and d.ClsDate<=@EndDate                
union all                
select 0,1,20,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,ReturnDate,ChkTime,Code,'退货 货款:'+cast(WareFund as varchar(20))+',其它:'+cast(OtherFund as varchar(20)),  
      null,GetFund,null , IsTax          ,1 as BillType     ,GatheringChk,GatheringChkMan,GatheringChkNote ,null    
  from sl_return where ClientId=@ClientId --and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                
union all                
select 0,1,9,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,ArriveDate,ChkTime,Code,'到货 货款:'+cast(WareFund as varchar(20))+',其它:'+cast(OtherFund as varchar(20)),  
       null,GetFund,null  ,0 as IsTax         ,1 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from ph_arrive where ClientId=@ClientId --and ArriveDate>=@BeginDate and ArriveDate<=@EndDate                
union all                
select 0,1,13,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,ReturnDate,ChkTime,Code,'退货 货款:'+cast(WareFund as varchar(20))+',其它:'+cast(OtherFund as varchar(20)),  
       GetFund,null,null  , IsTax         ,1 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from ph_return where ClientId=@ClientId --and ReturnDate>=@BeginDate and ReturnDate<=@EndDate                
union all                
select 0,1,21,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,InDate,ChkTime,Code,case InTypeId when 'I08' then '同行借调入库,' else '异地调配入库,' end,  
       null,WareFund,null  ,ISTax         ,1 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from wh_in where ClientId=@ClientId and (InTypeId='I08' or InTypeId='I09') --and InDate>=@BeginDate and InDate<=@EndDate                
union all                
select 0,1,22,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,OutDate,ChkTime,Code,case OutTypeId when 'X08' then '同行借调出库' else '异地调配出库' end,  
       WareFund,null,null  ,0 as ISTax         ,1 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from wh_out where ClientId=@ClientId and (OutTypeId='X08'or OutTypeId='X09') --and OutDate>=@BeginDate and OutDate<=@EndDate                
union all                
select 0,1,20,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,ReceiverDate,ChkTime,Code,'收款 '+IsNull((select Name from fn_item where Code=ItemId),0)+' '+IsNull(Note,''),  
        null,PayFund,null ,0 as ISTax           ,0 as BillType       ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from fn_receiver where ClientId=@ClientId --and ReceiverDate>=@BeginDate and ReceiverDate<=@EndDate                
union all                
              
              
select 0,1,21,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,PaymentDate,ChkTime,Code,case IoName when '' then '付款 '+IsNull((select Name from fn_item where Code=ItemId),0) else IoName end+' '+IsNull(Note,''),  
       PayFund,null,null ,0 as ISTax            ,0 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote,null     
  from fn_payment where ClientId=@ClientId --and PaymentDate>=@BeginDate and PaymentDate<=@EndDate                
union all                
select 0,1,23,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,InDate,ChkTime,Code,'应收 '+IsNull((select Name from fn_item where Code=ItemId),0),  
       PayFund,null,null , ISTax      ,0 as BillType       ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from fn_shldin where ClientId=@ClientId --and InDate>=@BeginDate and InDate<=@EndDate                
union all                
select 0,1,24,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,OutDate,ChkTime,Code,'应付 '+IsNull((select Name from fn_item where Code=ItemId),0),  
       null,PayFund,null, ISTax   ,0 as BillType      ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from fn_shldout where ClientId=@ClientId --and OutDate>=@BeginDate and OutDate<=@EndDate                
union all                
select 0,1,27,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,TrnsfrDate,ChkTime,Code,'客户转帐(入)单 '+OutName,  
       PayFund,null,null  ,0 as ISTax       ,0 as BillType       ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from fn_clntransfer where InId=@ClientId --and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                
union all                
select 0,1,27,IsChk,(case IsChk when 1 then 'clBlack' else 'clRed' end),billtime,TrnsfrDate,ChkTime,Code,'客户转帐(出)单 '+InName,  
        null,PayFund,null   ,0 as ISTax      ,0 as BillType           ,IsChk as  GatheringChk,null GatheringChkMan,null GatheringChkNote ,null  
  from fn_clntransfer where OutId=@ClientId --and TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                
union all                
select -1,1,-1,1,'clBlack',null,@BeginDate,null,'此前结余',null,null,null,null ,0   ,-1 as BillType ,null GatheringChk,null GatheringChkMan,null GatheringChkNote  ,null             
/*                
union all                
select 1,1,-1,'clBlack',@EndDate,null,'余   额' ,null,null,null,                
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
order by xorder,xDate,BillCode                
*/                
declare @RmnQty money                
                
if rtrim(ltrim(@DateType))='审核时间' begin           
     
  delete from #a where ChkTime<@BeginDate or ChkTime>@EndDate or IsChk=0              
  select @RmnQty=     
             
       IsNull((select sum(GetFund) from sl_invoice where ClientId=@ClientId and IsChk=1 and ChkTime<@EndDate),0)                
      -IsNull((select sum(PayFund) from sl_invoice where ClientId=@ClientId and FnIsChk=1  and FnChkTime<@EndDate),0)                
      -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and ClientId=@ClientId and d.ClsDate<@EndDate),0)                
      -IsNull((select sum(GetFund) from sl_return where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      -IsNull((select sum(GetFund) from ph_arrive where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      +IsNull((select sum(GetFund) from ph_return where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      -IsNull((select sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      +IsNull((select sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_receiver where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_payment where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_shldin where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_shldout where ClientId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                  
      +IsNull((select sum(PayFund) from fn_clntransfer where InId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_clntransfer where OutId=@ClientId and IsChk=1  and ChkTime<@EndDate),0)                
      +IsNull((select sum(Balance) from crm_client where Code=@ClientId),0)                
/*        */    
end             
            
if rtrim(ltrim(@DateType))='日期'               
begin               
  delete from #a where xDate<@BeginDate or xDate>=@EndDate     
  select @RmnQty=                
       IsNull((select sum(GetFund) from sl_invoice where ClientId=@ClientId and InvoiceDate<@EndDate),0)                
      -IsNull((select sum(PayFund) from sl_invoice where ClientId=@ClientId and InvoiceDate<@EndDate),0)                
      -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and ClientId=@ClientId and d.ClsDate<@EndDate),0)                
      -IsNull((select sum(GetFund) from sl_return where ClientId=@ClientId and ReturnDate<@EndDate),0)                
      -IsNull((select sum(GetFund) from ph_arrive where ClientId=@ClientId and ArriveDate<@EndDate),0)                
      +IsNull((select sum(GetFund) from ph_return where ClientId=@ClientId and ReturnDate<@EndDate),0)                
      -IsNull((select sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and ClientId=@ClientId and InDate<@EndDate),0)                
      +IsNull((select sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and ClientId=@ClientId and OutDate<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_receiver where ClientId=@ClientId and ReceiverDate<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_payment where ClientId=@ClientId and PaymentDate<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_shldin where ClientId=@ClientId and InDate<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_shldout where ClientId=@ClientId and OutDate<@EndDate),0)                  
      +IsNull((select sum(PayFund) from fn_clntransfer where InId=@ClientId and TrnsfrDate<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_clntransfer where OutId=@ClientId and TrnsfrDate<@EndDate),0)                
      +IsNull((select sum(Balance) from crm_client where Code=@ClientId),0)                
                
end     
if rtrim(ltrim(@DateType))='制单时间'               
begin           
    
  delete from #a where Billtime<@BeginDate or Billtime>=@EndDate        
  select @RmnQty=                
       IsNull((select sum(GetFund) from sl_invoice where ClientId=@ClientId and Billtime<@EndDate),0)                
      -IsNull((select sum(PayFund) from sl_invoice where ClientId=@ClientId and Billtime<@EndDate),0)             
      -IsNull((select sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and ClientId=@ClientId and d.ClsDate<@EndDate),0)                
      -IsNull((select sum(GetFund) from sl_return where ClientId=@ClientId and Billtime<@EndDate),0)                
      -IsNull((select sum(GetFund) from ph_arrive where ClientId=@ClientId and Billtime<@EndDate),0)                
      +IsNull((select sum(GetFund) from ph_return where ClientId=@ClientId and Billtime<@EndDate),0)                
      -IsNull((select sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and ClientId=@ClientId and Billtime<@EndDate),0)                
      +IsNull((select sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and ClientId=@ClientId and Billtime<@EndDate),0)               
      -IsNull((select sum(PayFund) from fn_receiver where ClientId=@ClientId  and Billtime<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_payment where ClientId=@ClientId  and Billtime<@EndDate),0)                
      +IsNull((select sum(PayFund) from fn_shldin where ClientId=@ClientId  and Billtime<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_shldout where ClientId=@ClientId  and Billtime<@EndDate),0)                  
      +IsNull((select sum(PayFund) from fn_clntransfer where InId=@ClientId  and Billtime<@EndDate),0)                
      -IsNull((select sum(PayFund) from fn_clntransfer where OutId=@ClientId and Billtime<@EndDate),0)                
      +IsNull((select sum(Balance) from crm_client where Code=@ClientId),0)                    
            
end              
                
  select xorder,IsCalc,BillId,FntClr,Billtime,xDate,ChkTime,BillCode,Brief,InQty,OutQty,RmnQty ,IsTax ,BillType ,GatheringChk,GatheringChkMan,GatheringChkNote,GatheringData,DATEDIFF ( d , gatheringdata , getdate() )  as GatheringDelay into #b from #a                 
  union all                
  select 1,1,-1,'clBlack',null,@EndDate-1,null,'余   额' ,null,null,null,@RmnQty   ,0   ,-1          ,null GatheringChk,null GatheringChkMan,null GatheringChkNote ,null as GatheringData  ,null as GatheringDelay
                
   
alter table #b alter column IsTax bit        
update #b set InQty=(select sum(InQty) from #b),OutQty=(select sum(OutQty) from #b) where xorder=1                
                
if @DateType='审核时间'                 
select * from #b order by xorder,ChkTime,BillCode                
if @DateType='日期'                    
   select * from #b order by xorder,xDate,BillCode                
else            
   select * from #b order by xorder,Billtime,BillCode                
               
drop table #b                
drop table #a              
            
          
        
    
     
    
    
    
  
