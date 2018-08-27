    alter  PROCEDURE dbo.sl_return_dlt      
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
  
begin tran     
 insert into sl_returnDisCard   
(
Code,ClientId,ReturnDate,Address,LinkMan,LinkTel,LinkFax,HandManId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,BillTime,ChkManId,
ChkTime,Note,WhId,WhInCode,ClientName,IsChk,IsConfirm,IsClose,IsDepose,FnIsChk,
FnChkManId,FnChkTime,ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,InvCode,InvDate,
InvFund,InvName,GatheringChk,GatheringChkMan,GatheringChkNote,islock,discardtime,discardmanid) 
 select * ,getdate(),@EmpId from sl_return where Code=@Code      
 insert into sl_returnDLDisCard    
 select   ReturnId,MyIndex,WareId,PartNo,  Brand,Pack,Qty,Price,dlNote,  IsInvoice,IsOutBill,Cost      
 from sl_returnDL where ReturnId=@Code      
      
 delete from sl_returndl where ReturnId=@Code      
 delete from sl_return where Code=@Code      
commit tran    
      
return 1    


    
select *From sl_returnDisCard 

alter table sl_returnDisCard  add islock bit
  
select name+',',*from syscolumns where object_id('sl_return')=id



select name+',',*from syscolumns where object_id('sl_returnDisCard')=id


 insert into sl_returnDisCard   
(
Code,ClientId,ReturnDate,Address,LinkMan,LinkTel,LinkFax,HandManId,WareFund,
OtherFund,GetFund,PayFund,PayeeId,BankId,PayModeId,BillManId,BillTime,ChkManId,
ChkTime,Note,WhId,WhInCode,ClientName,IsChk,IsConfirm,IsClose,IsDepose,FnIsChk,
FnChkManId,FnChkTime,ClientKey,IsInvoice,IsOutBill,IsTax,TaxRate,Profit,InvCode,InvDate,
InvFund,InvName,GatheringChk,GatheringChkMan,GatheringChkNote,islock,discardtime,discardmanid) 
 select * ,getdate(),@EmpId from sl_return where Code=@Code     