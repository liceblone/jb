 --销售发货单  update   
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
    set @Result='发货单: 已经被锁定不能更改'                          
  return 0           
end        
        --去掉 @PayeeId    折扣率不能大于3%,超过500元                
                      
if (@GetFund-@OtherFund)/@WareFund<0.97 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                           
  set @Result='对不起,折扣率不能大于3%,请与管理员联系.'                          
  return 0                          
end                          
if @WareFund-(@GetFund-@OtherFund)>500 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                           
  set @Result='对不起,折扣金额不能超过500元,请与管理员联系.'                          
  return 0                          
end                          
if (isnull(@PayFund,0)<>0) and (isnull(@BankId,'')=''or isnull(@PayModeId ,'')='')              
begin                          
  set @Result='对不起,在 <本单已收> 不为0时,您必需填写<收款方式>和<收款帐户>.'                          
  return 0                          
end                          
              
if (isnull(@PayFund,0)=0) and (isnull(@BankId,'')<>''or isnull(@PayModeId ,'')<>'')              
begin                          
  set @Result='对不起,在 <本单已收> 为0时,您不需填写<收款方式>和<收款帐户>.   如要清除<收款帐户>请按Delete'               
  return 0                          
end                          
                          
if exists(select 1 from sl_invoice where Code=@Code and FnIsChk=1 and (PayFund<>@PayFund or BankId<>@BankId))                          
begin                          
  set @Result='对不起,本单收款已经财务审核通过,您不能再修改<本单已收>及<收款帐户>！'                          
  return 0                          
end                          
                          
if (@GetFund  <>@WareFund+@OtherFund)       --2007-6-30  ori   if @isTax=1 and (@GetFund  <>@WareFund+@OtherFund)             
begin                        
  set @Result='发货单: 实际应收=货款+其它'                          
  return 0                          
end                        
          
if @InvoiceDate>getdate()          
begin          
  set @Result='发货不能大于当前日期'                          
  return 0               
end          
 
if exists(select *from crm_client where code =@clientid and BadCreditStatus=0 )    
begin    
 set @warningstr='客户欠款即将超额度,是否发货？'                          
 return 0     
end     
if exists(select *from crm_client where code =@clientid and BadCreditStatus=1 )    
begin    
 set @Result='客户欠款已经超过欠款额度,不能发货。'                          
 return 0     
end       
 if exists(select *from crm_client where code =@clientid and isnull(CreditLine,0)<>0 and isnull(debt,0)+ @GetFund>isnull(CreditLine,0) )    
 begin    
 set @warningstr='已经超过欠款额度,是否还要保存？'                          
 return 0     
end     
   
  
select @Result= partno+'   '+ pack+'   '+isnull(brand,'') From sl_invoicedl where invoiceid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)  
if @Result<>''  
begin    
   set @Result=@Result+char(13)+' 该资料已经被停用请联系管理员    '  
  return 0    
end    
  return 1                        
              
--select *From crm_client    
          
          
           
        
      
    
              
        
      
  