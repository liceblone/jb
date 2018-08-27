
declare @abortstr varchar(200)
declare @worningstr varchar(20)
declare @OperateManID varchar(20)
declare @Month   smalldatetime 
declare @isClosed  bit

set @abortstr=''
exec Pr_MonthEndClose @abortstr output ,@worningstr,'000','2009-1-01 00:00:00','1'
select @abortstr
go
select *from TMonthEndClose
 