go


--update TMtrLStorageHisCorrection set FAvgPrice =ISNULL(stg.FAvgPrice,stg.FUltimoPrice)  
--from TMtrLStorageHisCorrection his join TMtrLStorage stg on his.FInvCode =stg.FinvCode 
  
--  update TMtrLStorageHisCorrection  set FisChk=1
 use erpUserData
go	

  
declare @p1 varchar(300)
declare @p2 varchar(3000)
declare @Fmonth smalldatetime, @FBeginMonth smalldatetime, @FEndMonth smalldatetime
set @p2=NULL set @p1=NULL

set @FBeginMonth ='2015-3-1'
set  @FEndMonth ='2015-3-31'

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

  go 

  