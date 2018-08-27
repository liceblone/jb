alter PROCEDURE [dbo].[ph_return_chk0]           
                 @ReturnId varchar(20),          
                 @HandManId varchar(20)          
AS          
    
declare @fmonth smalldatetime    
declare @Msg    varchar(200)    
    
select @fmonth=   chktime from ph_return  where code= @ReturnId    
    
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
begin    
   set @Msg='���е����������������'+char(13)+convert(varchar(4), year(@fmonth))  +'��'+  convert(varchar(4), month(@fmonth) ) +  '���Ѿ� [�½�]�� �����ٶԸõ��������� ��'     
   Raiserror( @Msg ,16,1)            
   return 0          
end    
    
    
    
--2006-7-28 add ��taxrate        
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@OutCode varchar(50),@BillId int          
 set @BillId=13          
 select @DisCount=WareFund-GetFund,@PayFund=PayFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@OutCode=WhOutCode from ph_return where Code=@ReturnId and IsChk=1          
             
   if @@rowcount<>1          
     Raiserror('ϵͳ�Ҳ������˻���,���ݿ����ѱ���������Աɾ��,��[-ˢ��-]��֤!',16,1)          
   else          
   begin          
     begin tran          
       delete from wh_outdl where OutId=@OutCode          
       delete from wh_out where Code=@OutCode          
       update ph_return set IsConfirm=0,WhOutCode=null,IsChk=0,ChkManId=null where Code=@ReturnId  --,ChkTime=null          
   
        
      update ph_orderdl set phreturnQty= ISNULL( b.qty,0)              
      from ph_orderdl dl               
      left join (select SUM(qty)as Qty , PhOrdFID               
                 from ph_returndl  ardl join ph_return arM on ardl.returnid =arm.Code              
                 where arm.IsChk=1 and  Code=@ReturnId  group by PhOrdFID )  as b on dl.PhOrdFID = b.PhOrdFID              
      where dl.PhOrdFID in (select PhOrdFID from ph_returndl where  returnid=@ReturnId )              
                  
   -- 2006-12-28 ȥ���taxrate=0,      select  * from ph_returndl  
     Commit          
     if @@error=0           
       Return 1          
     else          
       Rollback          
     Return 0          
   end        
      
  
  