 alter PROCEDURE dbo.sl_retail_dlt    
                 @AbortStr varchar(50) output ,     
                 @EmpId varchar(20),    
                 @Code varchar(20)    
AS    
    
    
if exists(select 1 from sl_invoice where FnIsChk=1 and Code=@Code)    
begin    
  set @AbortStr='本单收款已通过财务审核,删除操作中止！'    
  return 0    
end    
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)    
begin    
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'    
  return 0    
end    
    
--else if not exists(select 1 from sl_retail where Code=@Code and BillManId=@EmpId)    
--begin    
--  set @AbortStr='您无权删除他人编制的单据,操作中止！'    
--  return 0    
--end    
    
begin tran  
 

--select *From sl_retailDisCard
 insert into sl_retailDisCard 
(Code,RetailDate,WhId,SaleManId,WareFund,GetFund,
PayeeId,BillManId,BillTime,ChkManId,ChkTime,
Note,WhOutCode,IsChk,IsClose,IsDepose,BankId,
FnIsChk,FnChkManId,FnChkTime,IsTax,TaxRate,
Profit,InvCode,InvDate,InvFund,InvName,IsInvoice,islock,  DiscardTime,DiscardManID) 

 select Code,RetailDate,WhId,SaleManId,WareFund,GetFund,
PayeeId,BillManId,BillTime,ChkManId,ChkTime,
Note,WhOutCode,IsChk,IsClose,IsDepose,BankId,
FnIsChk,FnChkManId,FnChkTime,IsTax,TaxRate,
Profit,InvCode,InvDate,InvFund,InvName,IsInvoice,islock
 ,getdate(),@EmpId 
from sl_retail where Code=@Code    
  


 insert into sl_retailDLDisCard  
 select   RetailId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,Cost     
 from sl_retaildl where RetailId=@Code    
  
 delete from sl_retaildl where RetailId=@Code    
 delete from sl_retail where Code=@Code    
  
commit tran   
    
return 1  
  


go
alter PROCEDURE dbo.ph_arrive_dlt    
                 @AbortStr varchar(50) output ,     
                 @EmpId varchar(20),    
                 @Code varchar(20)    
AS    
    
--if not exists(select 1 from ph_arrive where Code=@Code and BillManId=@EmpId)    
--begin    
--  set @AbortStr='您无权删除他人编制的单据,操作中止！'    
--  return 0    
--end    
    
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)    
begin    
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'    
  return 0    
end    
--   exec Pr_mergerTableFlds   'ph_arriveDisCard','ph_arrive'
 
begin tran   
 insert into ph_arriveDisCard  
(Code,ClientId,ArriveDate,HandManId,BillManId,
BillTime,ChkManId,ChkTime,Note,WhId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,
WhInCode,ClientName,IsChk,IsConfirm,IsDepose,
IsClose,TaxRate,ClientKey,IsInvoice,IsOutBill,islock,DiscardTime,DiscardManID
)
 select Code,ClientId,ArriveDate,HandManId,BillManId,
BillTime,ChkManId,ChkTime,Note,WhId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,
WhInCode,ClientName,IsChk,IsConfirm,IsDepose,
IsClose,TaxRate,ClientKey,IsInvoice,IsOutBill,islock,getdate(),@EmpId from ph_arrive where Code=@Code    
  
 insert into ph_arriveDLDisCard  
 select   ArriveId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  Qty2,IsOutBill,IsInvoice  
 from ph_arrivedl  where ArriveId=@Code   
  
 delete from ph_arrivedl where ArriveId=@Code    
 delete from ph_arrive where Code=@Code    
commit tran     
return 1  
  

go
alter PROCEDURE dbo.ph_return_dlt    
                 @AbortStr varchar(50) output ,     
                 @EmpId varchar(20),    
                 @Code varchar(20)    
AS    
    
--if not exists(select 1 from ph_return where Code=@Code and BillManId=@EmpId)    
--begin    
--  set @AbortStr='您无权删除他人编制的单据,操作中止！'    
--  return 0    
--end    
    
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)    
begin    
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'    
  return 0    
end    
    exec Pr_mergerTableFlds   'ph_returnDisCard','ph_return'   
begin tran  
 insert into  ph_returnDisCard  
(
Code,ClientId,WhId,BillTo,Fax,SendManId,ReturnDate,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,
BillTime,ChkManId,ChkTime,Note,WhOutCode,ClientName,IsChk,
IsDepose,IsClose,IsConfirm,FnIsChk,FnChkManId,FnChkTime,
ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,islock,DiscardTime,DiscardManID)
 select Code,ClientId,WhId,BillTo,Fax,SendManId,ReturnDate,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,
BillTime,ChkManId,ChkTime,Note,WhOutCode,ClientName,IsChk,
IsDepose,IsClose,IsConfirm,FnIsChk,FnChkManId,FnChkTime,
ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,islock,getdate(),@EmpId   from ph_return where Code=@Code    
  
 insert into  ph_returnDLDisCard  
 select   ReturnId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  IsOutBill,IsInvoice  
 from   ph_returnDL where ReturnId=@Code    
  
 delete from ph_returndl where ReturnId=@Code    
 delete from ph_return where Code=@Code    
commit tran  
    
return 1  
  

go

alter PROCEDURE dbo.sl_invoice_dlt          
                 @AbortStr varchar(50) output ,           
                 @EmpId varchar(20),          
                 @InvoiceId varchar(20)          
AS          
          
--if not exists(select 1 from sl_invoice where Code=@InvoiceId and BillManId=@EmpId)          
--begin          
--  set @AbortStr='您无权删除他人编制的单据,操作中止！'          
--  return 0          
--end       
     
      if exists(select 1 from sl_invoice where islock=1 and Code=@InvoiceId)          
begin          
  set @AbortStr='发货单已经锁定 不能弃单！'          
  return 0          
end          
            
if exists(select 1 from sl_invoice where FnIsChk=1 and Code=@InvoiceId)          
begin          
  set @AbortStr='本单收款已通过财务审核,删除操作中止！'          
  return 0          
end          
          
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)          
begin          
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'          
  return 0          
end          
          
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)          
begin          
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'          
  return 0          
end          
    
if exists(select top 1 *from Tinvoicemsgdl where itemtablebillcode = @InvoiceId)    
begin    
  set @AbortStr='发票已开，不能弃单。 请先删除发票预录入，开票单。'          
  return 0     
end    

    exec Pr_mergerTableFlds   'sl_invoiceDisCard','sl_invoice'   
          
begin tran         
         
 insert into sl_invoiceDisCard        
(Code ,ClientId,ClientName,LinkMan,LinkTel,      
LinkFax,OtherFund,InvoiceDate,DeliverAddr,DeliverId,SaleManId,      
WareFund,GetFund,PayFund,BillManId,BillTime,IsChk,ChkManId,ChkTime,      
IsOnce,IsClose,Note,PayeeId,BankId,PayModeId,WhId,IsConfirm,FnIsChk,      
FnChkManId,FnChkTime,ClientKey,IsInvoice,ClsFund,IsOutBill,IsReced,      
IsNoHint,HintDays,IsTax,TaxRate,Profit,InvCode,InvDate,InvFund,      
InvName,GatheringEmp,GatheringData,DisCardTime,DisCardManID)      
 select       
Code,ClientId,ClientName,LinkMan,LinkTel,      
LinkFax,OtherFund,InvoiceDate,DeliverAddr,DeliverId,SaleManId,WareFund,      
GetFund,PayFund,BillManId,BillTime,IsChk,ChkManId,ChkTime,IsOnce,IsClose,      
Note,PayeeId,BankId,PayModeId,WhId,IsConfirm,FnIsChk,FnChkManId,FnChkTime,      
ClientKey,IsInvoice,ClsFund,IsOutBill,IsReced,IsNoHint,HintDays,IsTax,      
TaxRate,Profit,InvCode,InvDate,InvFund,InvName,GatheringEmp,GatheringData      
,getdate(),@EmpId from sl_invoice       
where Code=@InvoiceId          
      
      
         
 insert into sl_invoiceDLDisCard        
(InvoiceId,MyIndex,WareId,PartNo,Brand,Pack,Qty,Price,bhNote,      
 dlNote,RmnQty,RmnFund,SndQty,ClsDate,IsInvoice,IsOutBill,Cost)      
 select   InvoiceId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,bhNote,  dlNote,RmnQty,RmnFund,SndQty,ClsDate,  IsInvoice,IsOutBill,Cost        
 from sl_invoiceDL where InvoiceId=@InvoiceId         
        
 delete from sl_invoicedl where InvoiceId=@InvoiceId          
 delete from sl_invoice where Code=@InvoiceId          
commit tran         
          
return 1        
      
      
go

alter PROCEDURE dbo.sl_return_dlt      
                 @AbortStr varchar(50) output ,       
                 @EmpId varchar(20),      
                 @Code varchar(20)      
AS      
      
--if not exists(select 1 from sl_return where Code=@Code and BillManId=@EmpId)      
--begin      
--  set @AbortStr='您无权删除他人编制的单据,操作中止！'      
--  return 0      
--end      
      
if not exists(select IsAdmin from sys_user where EmpId=@EmpId and IsAdmin=1)      
begin      
  set @AbortStr='只有管理员才能删除单据,请向管理员咨询.'      
  return 0      
end      
      
if exists(select top 1 *from Tinvoicemsgdl where itemtablebillcode = @Code)  
begin  
  set @AbortStr='发票已开，不能弃单。 请先删除发票预录入，开票单。'        
  return 0   
end   
 
 exec Pr_mergerTableFlds   'sl_returnDisCard','sl_return'   

begin tran     
 insert into sl_returnDisCard    
(
Code,ClientId,ReturnDate,Address,LinkMan,LinkTel,LinkFax,HandManId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,BillTime,ChkManId,
ChkTime,Note,WhId,WhInCode,ClientName,IsChk,IsConfirm,IsClose,IsDepose,FnIsChk,
FnChkManId,FnChkTime,ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,InvCode,
InvDate,InvFund,InvName,GatheringChk,GatheringChkMan,GatheringChkNote,islock,DiscardTime,DiscardManID)

 select Code,ClientId,ReturnDate,Address,LinkMan,LinkTel,LinkFax,HandManId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,BillTime,ChkManId,
ChkTime,Note,WhId,WhInCode,ClientName,IsChk,IsConfirm,IsClose,IsDepose,FnIsChk,
FnChkManId,FnChkTime,ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,InvCode,
InvDate,InvFund,InvName,GatheringChk,GatheringChkMan,GatheringChkNote,islock,getdate(),@EmpId from sl_return where Code=@Code      

 insert into sl_returnDLDisCard    
 select   ReturnId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  IsInvoice,IsOutBill,Cost      
 from sl_returnDL where ReturnId=@Code      
      
 delete from sl_returndl where ReturnId=@Code      
 delete from sl_return where Code=@Code      
commit tran    
      
return 1    
    
  



  
