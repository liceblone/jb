alter PROCEDURE dbo.fn_receiver_bfrdlt  
                 @ResultStr varchar(200) output,  
                 @EmpId varchar(20),  
                 @BillManId varchar(20)  ,
                 @Code  varchar(20)   
As  
  
if @EmpId<>@BillManId  
begin  
  set @ResultStr='�Բ���,�����Ǳ��տ���Ƶ���,������ɾ��������.'  
  return 0  
end  
  

declare @Brief varchar(200)


select @Brief= isnull(clientid ,'')+' , '+isnull(clientName,'') +','+ convert(varchar(20),   payfund)+','+ convert(varchar(10),ReceiverDate ,121   ) from fn_receiver  where   Code=@Code
 --       select Code,Operate,BillManId,BillTime,F_Note From fn_clientdlinout_isbilLog  where billmanid='000'
 insert into fn_clientdlinout_isbilLog    
 
 select @Code,'ɾ�� �տ' ,@BillManId ,getdate(),@Brief    


return 1
