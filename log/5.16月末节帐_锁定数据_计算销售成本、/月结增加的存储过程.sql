drop table TMonthEndClose

CREATE TABLE [TMonthEndClose] (
	[F_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[fMonth] [smalldatetime] NULL ,
	[isClosed] [bit] not null default 0 ,
	[CloseOperateID] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[CloseTime] [smalldatetime] NULL ,
	[f_note] [varchar] (200) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO


SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter  proc Pr_MonthEndClose
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
           update      TMonthEndClose 
           set         isClosed       =case when @isClosed=1 then      1        else 0  end ,   
                       CloseOperateID=case when @isClosed=1 then @OperateManID else '' end ,
                       CloseTime     =case when @isClosed=1 then getdate()     else null end 
           where year( @Month)=year(fMonth) and Month(@Month)=month(fMonth)


     commit tran
return 1
end





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

alter proc Pr_ShowMothEndCloseHis
@billManID varchar(20)
as
 

if not exists(select * from TMonthEndClose where month(fMonth) =month(getdate()) and year(fMonth)=year(getdate()) ) 
begin
	declare @i int
	declare @month smalldatetime
	set @i=0
	
	set @month=convert(varchar(4),year(getdate()))+'/01/01'
	while (@i<12)
	begin
	    insert into TMonthEndClose (fMonth)
	    values(@month)
	
	   set @month=dateadd(m,1,@month)
	   set @i=@i+1
	end
end

select isclosed,fmonth,f_note,Closetime , year(fMonth) as fyear  ,month(fmonth) as fmonth2 ,case when isclosed=1  then '已月结' else '' end as ClosedFlag from TMonthEndClose where year(fMonth)=year(getdate())  



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

select model  as billManID from sys_finditem   where 1<>1


