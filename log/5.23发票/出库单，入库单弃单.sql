
 


alter PROCEDURE dbo.wh_out_dlt    
                 @AbortStr varchar(50) output ,     
                 @EmpId varchar(20),    
                 @Code varchar(20)    

AS    
    
if not exists(select 1 from wh_out where Code=@Code and BillManId=@EmpId)    
begin    
  set @AbortStr='您无权删除他人编制的单据,操作中止！'    
  return 0    
end    
    
    
begin tran   
 insert into wh_outDisCard  
(Code,OutTypeId,WhId,OutDate,HandManId,
BillManId,BillTime,ChkManId,ChkTime,
Note,ClientId,Validate,IsChk,IsDepose,IsClose,
WareFund,LnkBlCd,ClientName,IsFirst,IsInvoice,
IsOutBill,islock,DisCardTime,DisCardManID
)
 select Code,OutTypeId,WhId,OutDate,HandManId,
BillManId,BillTime,ChkManId,ChkTime,
Note,ClientId,Validate,IsChk,IsDepose,IsClose,
WareFund,LnkBlCd,ClientName,IsFirst,IsInvoice,
IsOutBill,islock, getdate(),@EmpId 
from wh_out where Code=@Code    
  
 insert into wh_outDLDisCard  
 select    OutId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  IsInvoice,IsOutBill from wh_outdl  
  
 delete from wh_outdl where OutId=@Code    
 delete from wh_out where Code=@Code    
  
commit tran     
return 1  
  
go


alter  PROCEDURE dbo.wh_in_dlt    
                 @AbortStr varchar(50) output ,     
                 @EmpId varchar(20),    
                 @Code varchar(20)    
AS    
    
if not exists(select 1 from wh_in where Code=@Code and BillManId=@EmpId)    
begin    
  set @AbortStr='您无权删除他人编制的单据,操作中止！'    
  return 0    
end    
    
    
--    exec Pr_mergerTableFlds   'wh_inDisCard','wh_in'  

--select name+',' ,*from syscolumns where id=object_id('wh_inDisCard')
   



begin tran  
 insert into wh_inDisCard  
(
Code,InTypeId,WhId,InDate,HandManId,BillManId,BillTime,
ChkManId,ChkTime,Note,ClientId,ClientName,IsChk,IsDepose,
IsClose,WareFund,IsInvoice,IsOutBill,TaxRate ,Istax,islock,
DisCardTime,DisCardManID
)
 select 
Code,InTypeId,WhId,InDate,HandManId,BillManId,BillTime,
ChkManId,ChkTime,Note,ClientId,ClientName,IsChk,IsDepose,
IsClose,WareFund,IsInvoice,IsOutBill,TaxRate ,Istax,islock, getdate(),@EmpId from wh_in where Code=@Code   
   
 insert into wh_indlDiscard  
 select   InId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  IsInvoice,IsOutBill from wh_indl where InId=@Code    
  
 delete from wh_indl where InId=@Code    
 delete from wh_in where Code=@Code    
    
commit tran   
  
return 1  
  
