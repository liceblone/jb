drop table	TRemindType
go
create Table TRemindType
(
FRemindTypeCode varchar(20),
FRemindTypeName varchar(20),
FNote            varchar(200)
)


go
drop table TRemindItem
go
create table TRemindItem
(
  FRemindTypeCode varchar(50),
  FInformaction	   varchar(200) ,
  FNote  varchar(200)
)

insert into	  TRemindItem ( FRemindTypeCode, FInformaction , FNote)
select 'OverDueAcceptancebill'	 ,'即将到期承兑汇票' , ''

go
drop proc Pr_GetRemindInformation
go
create proc Pr_GetRemindInformation
as

-- overdue acceotance bill
  /*            
 declare    @BeginDate smalldatetime,                
@EndDate   smalldatetime,                
@ClientID varchar(30),                    
@AcceptancebillCode varchar(30),                    
@IsUnPay  bit,                    
@DueDateCnt  int                
              
set @BeginDate= '2016-02-04 00:00:00'         
set @EndDate= '2017-03-06 00:00:00'        
set @ClientID =null    
set @AcceptancebillCode=null    
set @IsUnPay=1        
set @DueDateCnt=null        
*/              


declare @OverDueCnt  int , @RemindOverDuecnt int

set @RemindOverDuecnt =20

select @OverDueCnt =count(*)    
from fn_receiver i 
left join  fn_payment  p on p.ReceiverCode=i.Code 
left join fn_bnktransfer t	on  t.ReceiverCode =i.code 
where i.isAcceptancebill =1  
and ( p.clientName is    null    and   t.TrnsfrDate is   null  and i.Code <>'FR00031076' )     
and  DATEDIFF (d,getdate(),i.Duedate) <@RemindOverDuecnt                  
               

delete TRemindItem where  FRemindTypeCode='OverDueAcceptancebill'				  
if isnull(@OverDueCnt,0)>0
    insert into	 TRemindItem ( FRemindTypeCode, FInformaction, FNote)
    select	 'OverDueAcceptancebill'	 ,'有 '+convert(varchar(20),@OverDueCnt) + ' 张承兑汇票 即将到期'  
    , convert(varchar(20),@RemindOverDuecnt)+' 天到期提醒.'



select * from TRemindItem