alter proc  sp_formalInvoiceDLBFP    
@abotyStr varchar(20) output,    
@wrongingStr varchar(20) output,    
@Qty decimal(19,5),    
@Amt decimal(19,5),    
@Sqty decimal(19,5)  ,  
@ItemTableBillcode varchar(20)  
as    
    
set @wrongingStr =''    
set @abotyStr =''    
    
    
IF @ItemTableBillcode<>'1'   
begin  
  
    
 if (@Sqty <0 ) and (@Qty <>@sQty )    
 begin    
   set @abotyStr ='�������ܸ�������'    
   return 0     
 end    
     
 if (@Sqty >0 ) and (@Qty <=0)    
 begin    
   set @abotyStr ='����д��ȷ��Ӧ������'    
   return 0     
 end    
  
end  
return 1    
  
