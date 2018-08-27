alter  proc Sp_FormalInvoiceChk1    
@code  varchar(20)  ,  
@Empid varchar(20)    
as    
    
begin tran    
    
declare @FormalInvCode varchar(20)    
declare @FormalInvDate varchar(20)    
    
    
if @code<>''     
begin     
        select @FormalInvCode=InvCode,@FormalInvDate =InvDate from TFormalInvoiceM  where  code=@code    
    
    if isnull(@FormalInvCode,'')='' or isnull(@FormalInvDate,'')=''    or len(@FormalInvCode )<8 or isnumeric(left(@FormalInvCode,8))=0
 begin    
             raiserror('����д��ȷ��Ʊ���뷢Ʊ����,�����.',16,1)          
             rollback                   
 end    
 else    
 update TFormalInvoiceM  set chkmanid=@Empid,Ischk=1 ,chktime=getdate() where code=@code    
end    
    
    
commit tran          
          
if @@error<>0           
begin          
 raiserror('��ʽ��Ʊ��˴���',16,1)          
 rollback             
end          
         
  
