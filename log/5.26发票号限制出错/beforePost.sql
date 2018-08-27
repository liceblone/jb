alter     proc Sp_FormalInvoiceMBFP    
@abortstr varchar(100) output,    
@worningstr varchar(100) output,    
    
@PreInvFund decimal(19,6),    
@Amt        decimal(19,6),
@InvCode     varchar(20),
@InvDate    smalldatetime

as    
set @worningstr =''    
set @abortstr =''    
    
if convert(decimal(19,2),@PreInvFund) <>convert(decimal(19,2),@Amt)            
begin    
    set  @abortstr ='��ϸ���ܽ����Ҫ���ڼ�˰�ϼƲ��ܱ���'    
    return 0     
end    

 
        
 if isnull(@InvCode,'')='' or isnull(@InvDate,'')=''    or len(@InvCode )<8 or isnumeric(left(@InvCode,8))=0
 begin    
       set  @abortstr ='����д��ȷ��Ʊ���뷢Ʊ���� '    
       return 0                 
 end  
return 1     
  
