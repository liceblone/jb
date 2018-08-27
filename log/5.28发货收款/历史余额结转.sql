---    结转已审的数据，每月状态汇总
      
      select code into  #c from crm_client 
       
                              
select ClientId,GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime into #f from sl_invoice where ClientId in (select Code from #c)                                  
union all             
select ClientId,-PayFund,InvoiceDate,FnIsChk,FnChkTime ,billtime from sl_invoice where ClientId in (select Code from #c)                                  
union all                                  
select m.ClientId,-d.RmnQty*d.Price,d.ClsDate,1,d.ClsDate ,billtime from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and d.ClsDate is not null and ClientId in (select Code from #c)                                  
union all                                  
select ClientId,-GetFund,ReturnDate,IsChk,ChkTime,billtime from sl_return where ClientId in (select Code from #c)                                  
union all                                  
select ClientId,-GetFund,ArriveDate,IsChk,ChkTime ,billtime from ph_arrive where ClientId in (select Code from #c)                                  
union all                                  
select ClientId,GetFund,ReturnDate,IsChk,ChkTime,billtime  from ph_return where ClientId in (select Code from #c)                             
union all                                  
select ClientId,PayFund,PaymentDate,IsChk,ChkTime ,billtime from fn_payment where ClientId in (select Code from #c) --and ItemId not in ('0160000','0170000')                                  
union all                                  
select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from fn_receiver where ClientId in (select Code from #c)-- and ItemId not in ('0160000','0170000')  2006-12-29恢复股东借款                                
union all                                  
select ClientId,PayFund,InDate,IsChk,ChkTime,billtime  from fn_shldin where ClientId in (select Code from #c)                                   
union all                                  
select ClientId,-PayFund,OutDate,IsChk,ChkTime,billtime  from fn_shldout where ClientId in (select Code from #c)                                   
union all                                  
select InId,PayFund,TrnsfrDate,IsChk,ChkTime,billtime from fn_clntransfer where InId in (select Code from #c)                                   
union all                                  
select OutId,-PayFund,TrnsfrDate,IsChk,ChkTime,billtime  from fn_clntransfer where OutId in (select Code from #c)                                   
union all                                  
select ClientId,WareFund,OutDate,IsChk,ChkTime,billtime  from wh_out where ClientId in (select Code from #c) and (OutTypeId='X08' or OutTypeId='X09')                                   
union all                                  
select ClientId,-WareFund,InDate,IsChk,ChkTime,billtime  from wh_in where ClientId in (select Code from #c) and (InTypeId='I08' or InTypeId='I09')                                   
union all                                  
select Code,Balance,null,1,null,null from crm_client where Code in (select Code from #c)                                  
                                  

go


create Table TCltMonthBalance
(ClientId varchar(20) not null,
Balance  decimal(19,5)not null,
Chkyear varchar(20)not null,
ChkMonth varchar(20)not null,
FNote  varchar(200)
)
 

create index indx_clt on TCltMonthBalance (ClientID)
create index indx_year on TCltMonthBalance (Chkyear)
create index indx_month on TCltMonthBalance (ChkMonth)

truncate table TCltMonthBalance


go
create table #fmonth
(
clientid varchar(39),
chkyear varchar(39),
chkmonth varchar(30)
)


declare @i int
declare @starttime smalldatetime

set @i=0
set @starttime='2007/1/1'


while @i<28
begin

     insert into #fmonth
     select Code, year(@starttime),month(@starttime)  from crm_client 
     print @starttime
     set @i=@i+1
     set @starttime=dateadd(m,1,  @starttime)
end

   
   select Clientid,xfund,  year(chktime )fy ,month(chktime)fm into  #g from  #f   


   select Clientid,sum(xfund) as xfund,   fy , fm  into #s from  #g  group by Clientid, fy , fm   


--select * from #s

  


insert into TCltMonthBalance(clientid,chkyear,chkmonth,balance)
select *
,isnull((select sum(xfund) from #s where clientid=Mt.clientid 
and  convert(smalldatetime,  convert(varchar(4),fy)+'/'+ convert(varchar(2), fm)+'/01')  <=convert(smalldatetime, Mt.chkyear+'/'+Mt.chkmonth+'/01'  )),0) as balance
From #fmonth Mt 

 

 

  --drop table TCltMonthBalance

select *from TCltMonthBalance where chkyear=2009 and chkmonth=5 order by balance desc

 
drop table  #g
drop table  #s
drop table #f
drop table #c
drop table #fmonth
