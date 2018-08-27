/*
销售发货  sp_helptext sl_invoice_chk0

销售退货  sp_helptext sl_return_chk0

采购到货  sp_helptext ph_arrive_chk0

采购退货 sp_helptext ph_return_chk0


付款单
收款单

应收单
应付单

客户转帐单

sp_helptext fn_alrdyinout_chk 


出库单 sp_helptext wh_out_chk0

入库单 sp_helptext wh_in_chk0

零售单 sp_helptext sl_retail_chk0	
*/

alter PROCEDURE [dbo].[sl_invoice_chk0]         
                 @InvoiceId varchar(20),        
                 @HandManId varchar(20),        
                 @LoginId varchar(20)        
AS        
        
if exists(select *from sl_invoicedl  where InvoiceID= @InvoiceId and isnull(FpID,'')<>'' )      
begin     
 Raiserror('这单的明细已经开完发票不能再弃审',16,1)        
 return 0       
end      
  
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@BankId varchar(20),@PayeeId varchar(20),@WhId varchar(20)        
 set @BillId=19        
 select @WhId=WhId,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@BankId=BankId,@PayeeId=PayeeId from sl_invoice where Code=@InvoiceId and IsChk=1        
        
  
    
 if @@rowcount<>1        
   Raiserror('系统找不到该发货单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)        
 else        
   begin        
     begin tran        
       delete from wh_outdl where OutId in (select code from wh_out where LnkBlCd=@InvoiceId)        
       delete from wh_out where LnkBlCd=@InvoiceId        
       update sl_invoice set IsConfirm=0,IsClose=0,IsChk=0,ChkManId=null where Code=@InvoiceId--,ChkTime=null            
       update sl_invoicedl set bhNote='',RmnQty=null,RmnFund=null,ClsDate=null where InvoiceId=@InvoiceId        
     Commit          
     select WareId,PartNo,Brand,Qty,RmnQty,SndQty,0 as myStok from sl_invoicedl where 1=2        
   end        
        
        
  if @@error=0         
     Return 1        
  else        
  begin        
     Rollback        
     Raiserror('事务提交失败,操作无效',16,1)        
  end        
  Return 0      
      

------
go

alter   PROCEDURE [dbo].[sl_return_chk0]         
                 @ReturnId varchar(20),        
                 @HandManId varchar(20)        
AS        
    
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@InCode varchar(20)        
 set @BillId=20        
     
if exists(select *from sl_returnDL where returnID=@ReturnId and isnull(FpID,'')<>'')      
begin    
   Raiserror('这张明细已经开完发票不能弃审核',16,1)      
   return 0    
end    
    
select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@InCode=WhInCode from sl_return where Code=@ReturnId and IsChk=1          
        
if @@rowcount<>1        
   Raiserror('系统找不到该退货单,单据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)        
 else        
   begin        
    
    
     begin tran        
       delete from wh_indl where InId=@InCode        
       delete from wh_in where Code=@InCode        
       update sl_return set IsConfirm=0,WhInCode=null,IsChk=0,Taxrate=0,ChkManId=null where Code=@ReturnId -- ,ChkTime=null          
      update wr_ware set IsUse=1 from wr_ware T1 join sl_returnDL T2 on T1.id=t2.wareid   where ReturnId=@ReturnId   
     goto ACommit        
   end        
        
ACommit:        
  commit        
  if @@error=0         
     Return 1        
  else        
  begin        
     Rollback        
     Raiserror('事务提交失败,操作无效',16,1)        
  end        
  Return 0      


----------
go
alter     PROCEDURE [dbo].[ph_arrive_chk0]             
                 @ArriveId varchar(20),            
                 @HandManId varchar(20)            
AS            
--2006-7-25在审核标志置0后加上更新成本单价            
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int            
 set @BillId=9            
 select @DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode from ph_arrive where Code=@ArriveId and IsChk=1            
 if @@rowcount<>1            
   Raiserror('系统找不到该到货单,单据可能已被其它操作员删除或反审核,请[-刷新-]验证!',16,1)            
 else begin            
     begin tran            
       delete from wh_indl where InId=@InCode            
       delete from wh_in where Code=@InCode            
       update ph_arrive set IsConfirm=0,WhInCode=null,IsChk=0,ChkManId=null where Code=@ArriveId  --,ChkTime=null            
            
       --更新单价            
       update wr_ware set Price=IsNull((select top 1 (d.Price-d.Price*m.TaxRate) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.WhInCode is Not null and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc),0) 
                      where Id in (select WareId from ph_arrivedl where ArriveId=@ArriveId)            
  
      -- update wr_ware set cost=IsNull((select top 1 (d.Price-d.Price*m.TaxRate) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.WhInCode is Not null and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc),0)
                     -- where Id in (select WareId from ph_arrivedl where ArriveId=@ArriveId)                    
         --2006-12-28 更新成本  在审核标志置1后再更新成本价   2007-1-1 弃审之后 用最新采购价做成本价       
         update wr_ware set cost  =isnull(Price ,0) where isnull(Price ,0) >0 and id in (select  wareid  from ph_arrivedl where arriveid=@ArriveId)           
  
  
  
     commit            
     if @@error=0             
       Return 1            
     else            
       Rollback            
     Return 0            
 end          
  
  
  
-----------

go

alter   PROCEDURE [dbo].[ph_return_chk0]       
                 @ReturnId varchar(20),      
                 @HandManId varchar(20)      
AS      
--2006-7-28 add 清taxrate    
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@OutCode varchar(50),@BillId int      
 set @BillId=13      
 select @DisCount=WareFund-GetFund,@PayFund=PayFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@OutCode=WhOutCode from ph_return where Code=@ReturnId and IsChk=1      
         
   if @@rowcount<>1      
     Raiserror('系统找不到该退货单,数据可能已被其它操作员删除,请[-刷新-]验证!',16,1)      
   else      
   begin      
     begin tran      
       delete from wh_outdl where OutId=@OutCode      
       delete from wh_out where Code=@OutCode      
       update ph_return set IsConfirm=0,WhOutCode=null,IsChk=0,ChkManId=null where Code=@ReturnId  --,ChkTime=null      
   -- 2006-12-28 去年掉taxrate=0,  
     Commit      
     if @@error=0       
       Return 1      
     else      
       Rollback      
     Return 0      
   end    
  

    
-------------
go

alter PROCEDURE [dbo].[fn_alrdyinout_chk]   
                 @LoginId varchar(20),  
                 @HandManId varchar(20),  
                 @ReceiverId varchar(20),  
                 @BankId varchar(20),  
                 @IsChk bit  
AS  
 declare @ChkManId varchar(50),@ChkTime datetime,@IsClose bit,@Pre varchar(2)  
 set @Pre=substring(@ReceiverId,1,2)  
 if not exists(select 1 from sys_userbank where UserId=@LoginId and BankId=@BankId)  
 begin   
   Raiserror('对不起,您不具备操作本 收款帐户 的权限,请与管理员联系.',16,1)  
   return 0  
 end  
 if @IsChk=1  
 begin  
--   if @ChkManId<>@HandManId  
--     Raiserror('只有审核人才有相应单据的反审核权限!',16,1)  
   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)  
   begin  
     Raiserror('只有管理员才有反审核单据的权限,请向管理员询问.',16,1)  
     return 0  
   end  
   else begin  
      set @IsChk=0  
      set @ChkManId=null  
   end  
 end else  
 begin  
   set @IsChk=1  
   set @ChkManId=@HandManId  
 end  
  
       if @Pre='FR'  
         update fn_receiver set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate())  where Code=@ReceiverId  
       else if @Pre='SI'  
         update sl_invoice set FnIsChk=@IsChk,FnChkManId=@ChkManId,FnChkTime=IsNull(FnChkTime,GetDate()) where Code=@ReceiverId  
--       else if @Pre='PR'  
--         update ph_return set FnIsChk=@IsChk,FnChkManId=@ChkManId,FnChkTime=(case IsChk when 1 then ChkTime else IsNull(ChkTime,@ChkTime) end) where Code=@ReceiverId  
       else if @Pre='FP'  
         update fn_payment set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ReceiverId  
       else if @Pre='RT'  
         update sl_retail set FnIsChk=@IsChk,FnChkManId=@ChkManId,FnChkTime= IsNull(FnChkTime,GetDate())  where Code=@ReceiverId  
       else if @Pre='FT'  
       begin  
         if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and OutId=@BankId) --转出  
         begin  
           if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and IsiChk=1) and (@IsChk=0)  
           begin  
             Raiserror('对不起,该内部转帐单已经通过转入方的审核,因为您不能进行反审核操作.',16,1)  
             return 0  
           end  
           else  
             update fn_bnktransfer set IsxChk=@IsChk,xChkManId=@ChkManId,xChkTime= IsNull(xChkTime,GetDate()) where Code=@ReceiverId-- and OutId=@BankId  
         end  
         else begin  
           if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and IsxChk=0)  
           begin  
             Raiserror('对不起,该内部转帐单未经转出方的审核,因为您不能进行审核操作.',16,1)  
             return 0  
           end  
           else         
             update fn_bnktransfer set IsiChk=@IsChk,iChkManId=@ChkManId,iChkTime=IsNull(iChkTime,GetDate()) where Code=@ReceiverId --and InId=@BankId  
         end  
       end  
  
Return 1


----------------------
go

alter PROCEDURE [dbo].[wh_out_chk0]   
                 @OutId varchar(20),  
                 @HandManId varchar(20),  
                 @LoginId varchar(20)  
AS  
 declare @IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@Msg varchar(4000),@ClientId varchar(20),@OutTypeId varchar(20),@WhId varchar(20),@InOut varchar(20)  
   
 set @BillId=22  
 select @InOut=OutTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@OutTypeId=OutTypeId,@WhId=WhId from wh_out where Code=@OutId and IsChk=1  
 if @@rowcount<>1  
   Raiserror('系统找不到该出库单,数据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)  
 else  
     begin  
       begin tran  
         update wh_out set IsChk=0,ChkManId=null where Code=@OutId--,ChkTime=null  
       commit  
       if @@error=0  
         return(1)  
       rollback  
       raiserror('事务提交失败,操作无效!',16,1)  
       return(0)  
     end  
  
  
Return 1



--------------
go


alter     PROCEDURE [dbo].[wh_in_chk0]             
                 @InId varchar(20),            
                 @HandManId varchar(20)            
AS            
--2006-7-28清税率          
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20)            
 set @BillId=21            
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=1            
 if @@rowcount<>1            
   Raiserror('系统找不到该入库单,单据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)            
 else            
   begin            
     begin tran            
       update wh_in set IsChk=0,ChkManId=null where Code=@InId--,ChkTime=null       
      
     -- if @InOut='I08' or    @InOut='I09'     --2006-12-28     2007-1-1  取最新进价  
     -- exec fn_UpdateCost_UnChk  'wh_in',@InId            
          update wr_ware set cost  =isnull(Price ,0) where isnull(Price ,0) >0 and   id in (select wareid  From wh_indl where inid=@InId)           
  
             
     commit            
     if @@error=0            
        return(1)            
     rollback            
     raiserror('事务提交失败,操作无效!',16,1)            
     return(0)            
   end          
        
      
---------

go


alter  PROCEDURE [dbo].[sl_retail_chk0]   
                 @RetailId varchar(20),  
                 @HandManId varchar(20)  
AS  
 declare @IsChk bit,@IsClose bit,@ChkManId varchar(50),@OutCode Varchar(20),@BillId int,@DisCount Money,@WhId varchar(20)  
 set @BillId=3  
 select @IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@OutCode=WhOutCode,@WhId=WhId from sl_retail where Code=@RetailId and IsChk=1  
 if @@rowcount<>1  
   Raiserror('系统找不到该零售单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)  
 else  
   begin  
  begin tran  
    delete from wh_outdl where OutId=@OutCode  
    delete from wh_out where Code=@OutCode  
    update sl_retail set IsChk=0,ChkManId=null,WhOutCode=null where Code=@RetailId  --,ChkTime=null    
  goto ACommit  
  end  
  
ACommit:  
  Commit  
  if @@error=0   
    Return 1  
  else  
  begin  
    Rollback  
    Raiserror('事务提交失败，操作无效',16,1)  
  end  
  Return 0
