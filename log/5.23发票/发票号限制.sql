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
             raiserror('请填写正确发票号与发票日期,再审核.',16,1)          
             rollback                   
 end    
 else    
 update TFormalInvoiceM  set chkmanid=@Empid,Ischk=1 ,chktime=getdate() where code=@code    
end    
    
    
commit tran          
          
if @@error<>0           
begin          
 raiserror('正式发票审核错误',16,1)          
 rollback             
end          
         
  
