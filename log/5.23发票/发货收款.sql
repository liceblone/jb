
DECLARE @fBeginDate smalldatetime
DECLARE @fEndDate smalldatetime
                   
set @fBeginDate ='2009-1-1'     
set @fEndDate ='2009-1-31'

select code,ClientId,GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime  from sl_invoice where chktime >=@fBeginDate and chktime<=@fEndDate
union all             
select ClientId,-PayFund,InvoiceDate,FnIsChk,FnChkTime ,billtime from sl_invoice where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select m.ClientId,-d.RmnQty*d.Price,d.ClsDate,1,d.ClsDate ,billtime from sl_invoicedl d 
                                       inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and d.ClsDate is not null and  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,-GetFund,ReturnDate,IsChk,ChkTime,billtime from sl_return where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,-GetFund,ArriveDate,IsChk,ChkTime ,billtime from ph_arrive where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,GetFund,ReturnDate,IsChk,ChkTime,billtime  from ph_return where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,PayFund,PaymentDate,IsChk,ChkTime ,billtime from fn_payment where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from fn_receiver where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,PayFund,InDate,IsChk,ChkTime,billtime  from fn_shldin where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,-PayFund,OutDate,IsChk,ChkTime,billtime  from fn_shldout where  chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select InId,PayFund,TrnsfrDate,IsChk,ChkTime,billtime from fn_clntransfer where   chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select OutId,-PayFund,TrnsfrDate,IsChk,ChkTime,billtime  from fn_clntransfer where         chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,WareFund,OutDate,IsChk,ChkTime,billtime  from wh_out where  (OutTypeId='X08' or OutTypeId='X09') and chktime >=@fBeginDate and chktime<=@fEndDate
union all                                  
select ClientId,-WareFund,InDate,IsChk,ChkTime,billtime  from wh_in where    (InTypeId='I08' or InTypeId='I09')  and chktime >=@fBeginDate and chktime<=@fEndDate







select  * from #f







