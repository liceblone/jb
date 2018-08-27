alter proc Pr_EvaluateCltCreditStatus
@Clientcode varchar(20)
,@EmpID   varchar(20)
,@LoginId varchar(20)
,@NickName varchar(20)
as

/*
declare @ClientID varchar(20) ,@EmpID   varchar(20)	 ,@LoginId varchar(20) ,@NickName varchar(20)
 set @ClientID ='%'
 set @EmpID   ='000%'
 set @LoginId ='chy%'
 set @NickName='%'
--  exec Pr_EvaluateCltCreditStatus '%','000%','chy%','%'
--- select *from  sys_user	  drop table #CltBalance
			*/
set  @EmpID    =replace (@EmpID,'%','')
set  @LoginId  =replace (@LoginId,'%','') 


select * into #c 
  from crm_Client                                
where                                 
 (  (select IsAdmin from sys_user where LoginId=@LoginId)=1                                 
or code in (select Code  from dbo.Fn_GetValideCltAccount (@Empid))      --所有客户  Fn_GetValideClt     --Fn_GetValideCltAccount 去掉负责收款          
or classid <>'05')  
and OldNickName like '%'+@NickName+'%' or NickName like '%'+@NickName+'%' 
 order by code desc    
 
 
 
create table #CltBalance(     GatheringEmp  varchar(20),               
Code  varchar(20),Name  varchar(50),NickName  varchar(20),ClassId  varchar(50),FatherId  varchar(20),RegionId  varchar(50),  
TaxId  varchar(30),LawMan  varchar(20),Bank  varchar(50),BankId  varchar(30),LinkMan  varchar(30),Tel  varchar(50),  
Fax  varchar(50),Addr  varchar(50),Zip  varchar(6),Mobile  varchar(23),BeepPager  varchar(20),Url  varchar(50),  
Email  varchar(50),Note  text,Demand  varchar(200),Products  varchar(200),IsPub  bit,Balance  money,AddEmpId  varchar(20),  
MIncrease  numeric(5),MSubtract  numeric(5),ChkFund  decimal(17,2),rpRemain  decimal(17,2))  
declare @Today smalldatetime  ---,  @EmpId varchar(20)    drop table #CltBalance  
set @Today =GETDATE()  
insert into #CltBalance 
exec fn_Client_fund '', @Today ,'日期','Admin','纯客户'  

delete	 #CltBalance  where (  rpRemain<=0 ) or code not in (select code from #c)


       
 
 ---select *from #CltBalance    ---  drop table #ARItems

create table #ARItems(
ClientId   varchar(20)
,BillCode    varchar(20)
,GetFund decimal(15,3)
,FDate smalldatetime
,IsChk  bit
,ChkTime smalldatetime
,billtime smalldatetime	 
,Balance  decimal(19,3)
,Findex	 int identity(1,1)
,IsStartingPoint int   
,rpRemain  decimal(19,3)
CONSTRAINT PK_ClientIDBilltime PRIMARY KEY (clientid,billtime desc,BillCode)
)

		 --select * from fn_shldin
		 
insert into #ARItems(ClientId,BillCode, GetFund,FDate,IsChk,ChkTime,BillTime,Balance)
select ClientId,code, GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime ,GetFund as Balance 
from sl_invoice where billtime >= dateadd(year,-3,getdate()) and  ClientId in (select Code from #CltBalance)                                    
union all               
select ClientId,code,PayFund,InDate,IsChk,ChkTime,billtime , PayFund as Balance 
from fn_shldin where billtime >= dateadd(year,-3,getdate()) and  ClientId in (select Code from #CltBalance)  
order by clientid,billtime desc


Declare @i int	 ,@balance decimal(29,3) ,@rpRemain decimal(19,2) , @ClientID varchar(20)
Declare Cur Cursor For Select  code, rpRemain From #CltBalance   
Open Cur
Fetch next From Cur Into @ClientID	,@rpRemain
While @@fetch_status=0     
Begin
    select @balance =0 
    print @ClientID   
    print @rpRemain
    Update #ARItems Set   Balance =@balance	   
    ,IsStartingPoint=case  when  @balance>=@rpRemain then 1 end	,@balance=GetFund+@balance 	where clientId =@clientId 
     
	update #ARItems set IsStartingPoint=2  ,rpRemain=@rpRemain
	where clientId =@clientId 
	and  Findex=(select findex from #ARItems 
	              where clientId =@clientId and IsStartingPoint=1 
	              and Findex=(select min(findex) from #ARItems where clientId =@clientId and IsStartingPoint=1 )
	              )	    
    Fetch Next From Cur Into @ClientID   ,@rpRemain
End   
Close Cur   
Deallocate Cur

delete #ARItems where  isnull(isStartingPoint,0)<>2


 ---drop table #CltCreditStatus 
 
 select BL.*  , datediff(d,AR.billtime, getdate() )	as DayCount	  , null as BadCreditStatus
 into   #CltCreditStatus
  From #CltBalance BL join #ARItems	 AR	   on   BL.Code=AR.clientId
 

 
  update #CltCreditStatus set BadCreditStatus  =b.WarningStatus		 --select A.*,B.*
 from   #CltCreditStatus A
 join   crm_clientclass  cltClass on A.ClassID=cltClass.Code
 join   TCltTermsOfPayment  B on cltClass.Code like B.CltClassID+'%' and  b.WarningStatus=0	  and 
                               ( (isnull(A.rpRemain,0)>isnull(B.CreditAmt ,0) and isnull(B.CreditAmt ,0)>0 )and  isnull(A.DayCount,0) >isnull(b.CreditDays,0) )
                               
  update #CltCreditStatus set BadCreditStatus  =b.WarningStatus		  -- select A.*,B.*
 from   #CltCreditStatus A
 join   crm_clientclass  cltClass on A.ClassID=cltClass.Code
 join   TCltTermsOfPayment  B on cltClass.Code like B.CltClassID+'%' and  b.WarningStatus=1 and 
                               ( (isnull(A.rpRemain,0)>isnull(B.CreditAmt ,0) and isnull(B.CreditAmt ,0)>0 )and  isnull(A.DayCount,0) >isnull(b.CreditDays,0) )
 
                                                        
 update #CltCreditStatus set BadCreditStatus  =b.WarningStatus
 from   #CltCreditStatus A
 join    TCltTermsOfPayment  B on A.code =B.ClientID and  b.WarningStatus=0	  and  
                               ( (isnull(A.rpRemain,0)>isnull(B.CreditAmt ,0) and isnull(B.CreditAmt ,0)>0 )and  isnull(A.DayCount,0) >isnull(b.CreditDays,0) )
 
  update #CltCreditStatus set BadCreditStatus  =b.WarningStatus
 from   #CltCreditStatus A
 join    TCltTermsOfPayment  B on A.code =B.ClientID and  b.WarningStatus=1  and  
                               ( (isnull(A.rpRemain,0)>isnull(B.CreditAmt ,0) and isnull(B.CreditAmt ,0)>0 )and  isnull(A.DayCount,0) >isnull(b.CreditDays,0) )
 
 update crm_client set	BadCreditStatus=b.BadCreditStatus
 from crm_client clt join #CltCreditStatus b on clt.code =b.code
 
select *,case when BadCreditStatus=0 then '提醒' when BadCreditStatus=1 then '禁止发货' end as BadCreditStatusLkp
 from #CltCreditStatus  where   BadCreditStatus is not null	   and code like  @Clientcode	+'%'
order by daycount  desc   --- update #CltCreditStatus set BadCreditStatus=null




drop table #CltBalance
drop table #ARItems	
drop table #CltCreditStatus

go




 