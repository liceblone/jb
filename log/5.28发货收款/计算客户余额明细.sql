--每月状态汇总加  未审数据  
  
alter PROCEDURE [dbo].[sl_invoice_rec_bal]       
@ClientId varchar(20)='',      
@RegionId  varchar(20)='',    
@FatherID varchar(20)='',    
@GatheringEmp varchar(20)='',    
@EndDate datetime     
AS      
--计算出客户@ClientId截止至@EndDate时的未审余额并输出到@Balance,未算进货项      
     
      
--sl_invoice_rec_bal 'HZ000513','','','','2009/06/09'  
  
/*
declare @ClientId varchar(20)  ,      
@RegionId  varchar(20)  ,    
@FatherID varchar(20) ,    
@GatheringEmp varchar(20) 
declare @EndDate smalldatetime    
  
set @EndDate=getdate()    
set   @ClientId=isnull(@ClientId,'HZ000513')    
 */      
    
    
--     
    
select code  --,RegionId,FatherID,GatheringEmp     
  into #c     
from  crm_client     
where code         like isnull(@ClientId,'')+'%'    
and   isnull(RegionId ,'')    like isnull(@RegionId,'')+'%'    
and   isnull(FatherID ,'')    like isnull(@FatherID,'')+'%'    
and   isnull(RegionId ,'')    like isnull(@RegionId,'')+'%'    
and   isnull(GatheringEmp,'') like isnull(@GatheringEmp,'')+'%'    
    
    
    
 
    
create table #f    
(    
clientid varchar(20),    
Balance  decimal(19,5),    
fDate    smalldatetime,    
ischk    bit,    
Chktime  smalldatetime,    
Billtime smalldatetime    
)    

declare @DetailDate smalldatetime    
 
select @DetailDate=dateadd(m,1,fmonth) from TMonthEndClose where fmonth=(select Max(fmonth)from TMonthEndClose where isClosed=1 )
  PRINT @DetailDate  
    
insert into  #f    
select clientid,balance,          null,       1,   convert(smalldatetime,chkyear+'/'+chkmonth+'/01')as ChkTime ,convert(smalldatetime,chkyear+'/'+chkmonth+'/01')as billtime    
       From [TCltMonthBalance] where chkyear=year(dateadd(m,-1,@DetailDate) ) and chkmonth=month(dateadd(m,-1,@DetailDate))   and ClientId in (select Code from #c) 

union all     
select ClientId,GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime  from [sl_invoice]     
       where ClientId in (select Code from #c) and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                
union all                 
select ClientId,-PayFund,InvoiceDate,FnIsChk,FnChkTime ,billtime from [sl_invoice]     
       where ClientId in (select Code from #c)  and  (( FnChkTime>@DetailDate  and FnChkTime< @EndDate )or isnull(FnIsChk,0)=0)                                           
union all                                      
select m.ClientId,-d.RmnQty*d.Price,d.ClsDate,1,d.ClsDate ,billtime from [sl_invoicedl] d     
                                                              inner join [sl_invoice] m on d.InvoiceId=m.Code    
       where m.IsChk=1 and d.ClsDate is not null and ClientId in (select Code from #c)                                      
union all                                      
select ClientId,-GetFund,ReturnDate,IsChk,ChkTime,billtime from [sl_return]     
       where ClientId in (select Code from #c)    and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                    
union all                                      
select ClientId,-GetFund,ArriveDate,IsChk,ChkTime ,billtime from [ph_arrive]    
        where ClientId in (select Code from #c) and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                       
union all                                      
select ClientId,GetFund,ReturnDate,IsChk,ChkTime,billtime  from [ph_return]     
        where ClientId in (select Code from #c)    and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                               
union all                                      
select ClientId,PayFund,PaymentDate,IsChk,ChkTime ,billtime from [fn_payment]     
       where ClientId in (select Code from #c) and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)   --and ItemId not in ('0160000','0170000')                                      
union all                                      
select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from [fn_receiver]     
       where ClientId in (select Code from #c)and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)  -- and ItemId not in ('0160000','0170000')  2006-12-29恢复股东借款                                    
union all                                      
select ClientId,PayFund,InDate,IsChk,ChkTime,billtime  from [fn_shldin]    
        where ClientId in (select Code from #c)  and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                       
union all                                      
select ClientId,-PayFund,OutDate,IsChk,ChkTime,billtime  from [fn_shldout]     
       where ClientId in (select Code from #c) and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                        
union all                                      
select InId,PayFund,TrnsfrDate,IsChk,ChkTime,billtime from [fn_clntransfer]     
         where InId in (select Code from #c)    and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                     
union all                                      
select OutId,-PayFund,TrnsfrDate,IsChk,ChkTime,billtime  from [fn_clntransfer]     
         where OutId in (select Code from #c)      and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                   
union all                                      
select ClientId,WareFund,OutDate,IsChk,ChkTime,billtime  from [wh_out]    
         where (OutTypeId='X08' or OutTypeId='X09') and  ClientId in (select Code from #c) and (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                             
union all                                      
select ClientId,-WareFund,InDate,IsChk,ChkTime,billtime  from [wh_in]     
         where  (InTypeId='I08' or InTypeId='I09')and  ClientId in (select Code from #c)   and  (( ChkTime>@DetailDate  and ChkTime< @EndDate )or isnull(IsChk,0)=0)                                       
    
drop table #c         
    
     
select *From #f    
    
drop table #f    
  
