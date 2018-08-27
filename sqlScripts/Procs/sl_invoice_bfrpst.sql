 --���۷�����  update   
alter  PROCEDURE [sl_invoice_bfrpst]                           
                 @Result varchar(250) output,                          
                 @warningstr varchar(250) output,                          
                 @LoginId varchar(20),                          
                 @PayFund Money,                          
                 @BankId varchar(20),                          
                 @PayeeId varchar(20),                          
                 @GetFund Money,                          
                 @OtherFund Money,                          
                 @WareFund Money,                          
                 @PayModeId varchar(20),                          
                 @Code varchar(20)  ,                        
                 @isTax bit         ,          
                 @InvoiceDate     smalldatetime  ,        
                 @islock    bit       
               ,    @clientID  varchar(20)    
                        
AS                          
        
  set @warningstr=''    
if isnull(@islock,0)='1'        
begin        
    set @Result='������: �Ѿ����������ܸ���'                          
  return 0           
end        
        --ȥ�� @PayeeId    �ۿ��ʲ��ܴ���3%,����500Ԫ                
                      
if (@GetFund-@OtherFund)/@WareFund<0.97 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                           
  set @Result='�Բ���,�ۿ��ʲ��ܴ���3%,�������Ա��ϵ.'                          
  return 0                          
end                          
if @WareFund-(@GetFund-@OtherFund)>500 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                           
  set @Result='�Բ���,�ۿ۽��ܳ���500Ԫ,�������Ա��ϵ.'                          
  return 0                          
end                          
if (isnull(@PayFund,0)<>0) and (isnull(@BankId,'')=''or isnull(@PayModeId ,'')='')              
begin                          
  set @Result='�Բ���,�� <��������> ��Ϊ0ʱ,��������д<�տʽ>��<�տ��ʻ�>.'                          
  return 0                          
end                          
              
if (isnull(@PayFund,0)=0) and (isnull(@BankId,'')<>''or isnull(@PayModeId ,'')<>'')              
begin                          
  set @Result='�Բ���,�� <��������> Ϊ0ʱ,��������д<�տʽ>��<�տ��ʻ�>.   ��Ҫ���<�տ��ʻ�>�밴Delete'               
  return 0                          
end                          
                          
if exists(select 1 from sl_invoice where Code=@Code and FnIsChk=1 and (PayFund<>@PayFund or BankId<>@BankId))                          
begin                          
  set @Result='�Բ���,�����տ��Ѿ��������ͨ��,���������޸�<��������>��<�տ��ʻ�>��'                          
  return 0                          
end                          
                          
if (@GetFund  <>@WareFund+@OtherFund)       --2007-6-30  ori   if @isTax=1 and (@GetFund  <>@WareFund+@OtherFund)             
begin                        
  set @Result='������: ʵ��Ӧ��=����+����'                          
  return 0                          
end                        
          
if @InvoiceDate>getdate()          
begin          
  set @Result='�������ܴ��ڵ�ǰ����'                          
  return 0               
end          
 
if exists(select *from crm_client where code =@clientid and BadCreditStatus=0 )    
begin    
 set @warningstr='�ͻ�Ƿ��������,�Ƿ񷢻���'                          
 return 0     
end     
if exists(select *from crm_client where code =@clientid and BadCreditStatus=1 )    
begin    
 set @Result='�ͻ�Ƿ���Ѿ�����Ƿ����,���ܷ�����'                          
 return 0     
end       
 if exists(select *from crm_client where code =@clientid and isnull(CreditLine,0)<>0 and isnull(debt,0)+ @GetFund>isnull(CreditLine,0) )    
 begin    
 set @warningstr='�Ѿ�����Ƿ����,�Ƿ�Ҫ���棿'                          
 return 0     
end     
   
  
select @Result= partno+'   '+ pack+'   '+isnull(brand,'') From sl_invoicedl where invoiceid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)  
if @Result<>''  
begin    
   set @Result=@Result+char(13)+' �������Ѿ���ͣ������ϵ����Ա    '  
  return 0    
end    
  return 1                        
              
--select *From crm_client    
          
          
           
        
      
    
              
        
      
  