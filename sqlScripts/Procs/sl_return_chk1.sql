
 alter  PROCEDURE [dbo].[sl_return_chk1]               
                 @ReturnId varchar(20),              
                 @HandManId varchar(20)              
AS              
--2006-7-25�����˻���Ӱ��ɱ���  2006-8-21�������ñ�־        
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@InCode varchar(20) ,@IsTax bit             
 set @BillId=20              
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@InCode=WhInCode ,@IsTax= IsTax from sl_return where Code=@ReturnId and IsChk=0              
 if @@rowcount<>1              
   Raiserror('ϵͳ�Ҳ������˻���,���ݿ����ѱ���������Աɾ����δ���,��[-ˢ��-]��֤!',16,1)              
 else              
 begin 
   if exists (select * from sl_order m join sl_orderdl dl on m.Code=dl.OrderId 
               where m.IsTax <>@IsTax and dl.F_ID in ( select SLOrderID from sl_returndl where ReturnId= @ReturnId ) )
   begin
       Raiserror( '��˰��־����' ,16,1)            
       return 0    
   end 
   
   BEGIN TRY               
   begin tran              
     --     exec fn_UpdateCost 'sl_return',@ReturnId              
     exec sys_myid 316,@InCode out              
     insert into wh_in(Code,InTypeId,InDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)               
           select @InCode,'I03',GetDate(),WhId,ClientId,@HandManId,'�����˻����ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from sl_return where Code=@ReturnId              
     insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)               
           select @InCode,WareId,PartNo,Brand,Qty,Price from sl_returndl where ReturnId=@ReturnId order by dlId              
     update sl_return set IsConfirm=1,WhInCode=@InCode,IsChk=1,ChkManId=@HandManId,ChkTime=dbo.Fn_IsMonthClose (ChkTime) where Code=@ReturnId              
     update sl_returndl set Cost=(select isnull(Cost,0) from wr_ware where Id=WareId) where ReturnId=@ReturnId and Cost is null              
     update sl_return set TaxRate=(select MoneyX from sys_parameters where Id=6) where isnull(TaxRate,0)=0              
     declare @TaxRate money              
     select @TaxRate=(select TaxRate from sl_return where Code=@ReturnId)              
     --update sl_return set Profit=(select sum(Qty*(Price-Cost-Price*@TaxRate)) from sl_returndl where ReturnId=Code)-(WareFund-GetFund) where Code=@ReturnId              
    
     update sl_return set Profit=(select sum(Qty*(Price)) from sl_returndl where ReturnId=Code)-(WareFund-GetFund) where Code=@ReturnId              
        
     --��IsUse        
     update wr_ware set Isuse=1 from wr_ware T1 join sl_returnDL T2 on   T1.id=t2.wareid        
    
     -- set returnqty  select * from sl_orderdl
     
      update sl_orderdl set returnqty= ISNULL( b.qty,0)              
      from sl_orderdl dl               
      left join (select SUM(qty)as Qty , ardl.SLOrderID               
                 from sl_returndl ardl join sl_return  arM on ardl.ReturnId =arm.Code              
                 where arm.IsChk=1    and   ReturnId=@ReturnId group by ardl.SLOrderID )  as b on dl.F_ID = b.SLOrderID              
      where dl.f_id in (select SLOrderID from sl_returndl where  ReturnId=@ReturnId )              
                  
     
 
     
    commit                                                 
    END TRY                                
    BEGIN CATCH                                
       EXECUTE usp_GetErrorInfo;     -- Execute error retrieval routine.                                
               raiserror('�����ύʧ��,������Ч!',16,1)                                         
       rollback                                                                                   
    return 0                                   
    END CATCH    ;       
end

   
  
   
  
  go
  