/*
declare @abortstr varchar(200)  ,  
@worningstr varchar(200)  

exec Pr_MonthEndClose  @abortstr output ,@worningstr output,'000','2009/5/1',1

print @abortstr


select *From TMonthEndClose where fmonth<='2009-05-01'
update TMonthEndClose set isclosed=1 ,closeoperateid='000',closetime=getdate() where fmonth<='2009-05-01'
*/

alter   proc Pr_MonthEndClose  
@abortstr varchar(200) output,  
@worningstr varchar(200) output,  
@OperateManID varchar(20),  
@Month   smalldatetime,  
@isClosed  bit   
as  
begin  
--1.set or clear isclose flag  
--2.Update sale cost  
  
  
if @isClosed=1  
 set @isClosed=0  
else  
 set @isClosed=1  
  
  set @abortstr=''  
        set @worningstr=''  
if @isClosed=1   
  
if @Month>getdate()  
begin  
    set @abortstr=' 不能对未来月份进行月结,只能对当前月份或历史月份进行月结!'  
        return 0  
end  
if exists(select * from TMonthEndClose where fmonth<@month and isClosed=0)  
begin  
 set @abortstr='之前月份未月结，不能对当前月份进行月结!'  
        return 0  
end  
if @isClosed=0  
if exists(select * from TMonthEndClose where fmonth>@month and isClosed=1)  
begin  
 set @abortstr='如需进行反月结，必须从依次从最后已经月结的月份开始!'  
        return 0  
end  
  
     begin tran  
---1.set or clear @isClosed
           update      TMonthEndClose   
           set         isClosed       =case when @isClosed=1 then      1        else 0  end ,     
                       CloseOperateID=case when @isClosed=1 then @OperateManID else '' end ,  
                       CloseTime     =case when @isClosed=1 then getdate()     else null end   
           where year( @Month)=year(fMonth) and Month(@Month)=month(fMonth)  
  
   

		declare @Date smalldatetime		
		set @Date=@Month
--if @isClosed =1 then insert TCltMonthBalance else delete TCltMonthBalance 
		
                if @isClosed =1
                begin
	
			declare @beginDate smalldatetime
			declare @endDate smalldatetime
			 
			
			set @beginDate=  convert(smalldatetime,convert(varchar(4),year( @Date )) +'/'+convert(varchar(2),month( @Date ))+'/01')  
			set @endDate = dateadd(m,1,@beginDate ) 
			print @beginDate
			print  @endDate
			select code into  #c from crm_client 
			        
			                              
			select ClientId,GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime into #f from sl_invoice 
			       where ClientId in (select Code from #c)    and chktime>=@beginDate and chktime<@endDate
			                              
			union all
			
			select ClientId,-PayFund,InvoiceDate,FnIsChk,FnChkTime ,billtime from sl_invoice 
			       where ClientId in (select Code from #c) and FnChkTime>=@beginDate and FnChkTime<@endDate
			
			--union all                                  
			--5.0.2.5之后不能做补货
			--select m.ClientId,-d.RmnQty*d.Price,d.ClsDate,1,d.ClsDate ,billtime from sl_invoicedl d 
			--        inner join sl_invoice m on d.InvoiceId=m.Code 
			--        where m.IsChk=1 and d.ClsDate is not null and ClientId in (select Code from #c)   
			                               
			union all                                  
			select ClientId,-GetFund,ReturnDate,IsChk,ChkTime,billtime from sl_return 
			        where ClientId in (select Code from #c)   and chktime>=@beginDate and chktime<@endDate
			                                
			union all                                  
			select ClientId,-GetFund,ArriveDate,IsChk,ChkTime ,billtime from ph_arrive 
			        where ClientId in (select Code from #c)   and chktime>=@beginDate and chktime<@endDate
			
			union all                                  
			select ClientId,GetFund,ReturnDate,IsChk,ChkTime,billtime  from ph_return 
			        where ClientId in (select Code from #c)    and chktime>=@beginDate and chktime<@endDate
			                          
			union all                                  
			select ClientId,PayFund,PaymentDate,IsChk,ChkTime ,billtime from fn_payment 
			        where ClientId in (select Code from #c)  and chktime>=@beginDate and chktime<@endDate
			union all                                  
			select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from fn_receiver 
			       where ClientId in (select Code from #c) and chktime>=@beginDate and chktime<@endDate
			union all                                  
			select ClientId,PayFund,InDate,IsChk,ChkTime,billtime  from fn_shldin 
			       where ClientId in (select Code from #c)         and chktime>=@beginDate and chktime<@endDate
			
			union all                                  
			select ClientId,-PayFund,OutDate,IsChk,ChkTime,billtime  from fn_shldout 
			        where ClientId in (select Code from #c)     and chktime>=@beginDate and chktime<@endDate                                
			union all                                  
			select InId,PayFund,TrnsfrDate,IsChk,ChkTime,billtime from fn_clntransfer 
			           where InId in (select Code from #c)      and chktime>=@beginDate and chktime<@endDate
			                               
			union all                                  
			select OutId,-PayFund,TrnsfrDate,IsChk,ChkTime,billtime  from fn_clntransfer 
			        where OutId in (select Code from #c)     and chktime>=@beginDate and chktime<@endDate                                
			union all                                  
			select ClientId,WareFund,OutDate,IsChk,ChkTime,billtime  from wh_out 
			         where ClientId in (select Code from #c) and (OutTypeId='X08' or OutTypeId='X09')   and chktime>=@beginDate and chktime<@endDate                                  
			union all                                  
			select ClientId,-WareFund,InDate,IsChk,ChkTime,billtime  from wh_in 
			         where ClientId in (select Code from #c) and (InTypeId='I08' or InTypeId='I09')     and chktime>=@beginDate and chktime<@endDate                                
			
			
			select clientid ,xfund ,year(chktime)as fyear ,month(chktime)as fmonth into #K from #f 
			
			insert into TCltMonthBalance(clientid,balance,chkyear,chkmonth)
			select clientid ,sum(xfund) ,  fyear , fmonth    from #K group by clientid ,  fyear , fmonth 
			 
			insert into TCltMonthBalance(clientid,balance,chkyear,chkmonth) 
                        select clientid,balance,year ( @Month ),month ( @Month)    from TCltMonthBalance
                              where year(dateadd(m,-1,@Month))   =chkyear and chkmonth=month (dateadd(m,-1,@Month)) and clientid not in (select clientid From #K)
			
			
			drop table #c
			drop table #K
			drop table #f
                end
                else
                begin
                    --  select *From TCltMonthBalance where chkyear=2009 and chkmonth=5
                     delete TCltMonthBalance where chkyear=year( @Month ) and chkmonth=month( @Month )
                end
	 

     commit tran  
if @@error<>0
begin
rollback
    set @abortstr=' 月结出错 ！'  
        return 0  
end	

return 1  
   
end