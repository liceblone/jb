exec jbhzuserdata.dbo.Pr_DataValidation  

go
use erpUserData
go  

  exec Pr_SyncInfrastructureData


declare @FBeginMonth smalldatetime, @FEndMonth smalldatetime
set @FBeginMonth =dbo.Fn_GetFirstDayofMonth('2017-8-1')
set @FEndMonth=  dateadd(m,1,@FBeginMonth) 

print @FBeginMonth
print @FEndMonth

  exec Pr_SyncBusinessData @FBeginMonth ,@FEndMonth
-- exec Pr_SyncBusinessData20170402   @FBeginMonth ,@FEndMonth



  
declare @p1 varchar(300), @p2 varchar(3000), @Fmonth smalldatetime

--set @FBeginMonth ='2016-6-1'
set  @FEndMonth = dateadd(d,-1,@FEndMonth  ) --'2015-10-31'

set @Fmonth =@FBeginMonth
while (@Fmonth<=@FEndMonth)
begin

    delete TMonthlyProfitByCompany where Fmonth =@Fmonth
    delete TGLBalanceMonthlyReport where FMonth=@Fmonth
     
    exec  PR_ImportPayReceiveAble @Fmonth

 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'009','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'009','','000'

 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'008','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'008','','000'

 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'02','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'02','','000'

  exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'01','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'01','','000'

   exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'01','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'01','','000'

    exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'014','ºËËã','000'
 exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,@FMonth,'014','','000'

 ---  declare @p1 varchar(50) , @p2 varchar(50)
  
 exec PR_InvStorageHisChk @p1 output,@p2 output,@FMonth,'008','0','000'
 exec PR_InvStorageHisChk @p1 output,@p2 output,@FMonth,'009','0','000'
 exec PR_InvStorageHisChk @p1 output,@p2 output,@FMonth,'01','0','000'
 exec PR_InvStorageHisChk @p1 output,@p2 output,@FMonth,'02','0','000'
 exec PR_InvStorageHisChk @p1 output,@p2 output,@FMonth,'014','0','000'
 
 exec Pr_InvCostAcctMonthEndClose @p1 output,@p2 output,@FMonth,0,'000'

    exec Pr_ImportGLBalance @FMonth
        
 set @Fmonth =DATEADD(m,1,@Fmonth)
end

--- sync client balance 
--exec Pr_SyncClientBalance
  go 

  