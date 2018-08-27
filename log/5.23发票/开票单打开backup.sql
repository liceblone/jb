CREATE    proc sp_Formal_InvoiceMsg_open    
                 @LoginId varchar(50),      
                 @WhId varchar(20),      
                 @TypId varchar(2),      
                 @Key varchar(20)      
AS      
    
--   select *from TFormalInvoiceM    order by code desc    
    
if @TypId='1'       
  select * from TFormalInvoiceM where Code like @Key+'%' order by code desc      
    
else if @TypId='2'      
  select A.*     
  from TFormalInvoiceM A    
  join crm_client  B on A.clientid=B.code    
 where B.Nickname like @Key+'%'  or B.tel =@Key  order by A.code desc      
    
else   select * from TFormalInvoiceM where DateDiff(d,billtime,GetDate())<=5 or ischk=0 order by code desc     
--  select * from TFormalInvoiceM    
    
  
