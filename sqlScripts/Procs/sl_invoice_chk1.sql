CREATE PROCEDURE [dbo].[sl_invoice_chk1]         
                 @InvoiceId varchar(20),        
                 @HandManId varchar(20),        
                 @LoginId varchar(20)        
AS        
        
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@BankId varchar(20),@PayeeId varchar(20),@WhId varchar(20)        
 declare @ClientId varchar(20),@GatheringEmp varchar(20)      
       
      
 set @BillId=19        
 select   @ClientId=ClientId,@GatheringEmp=GatheringEmp,   @WhId=WhId,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@BankId=BankId,@PayeeId=PayeeId from sl_invoice where Code=@InvoiceId and IsChk=0       
 
        
      
      
 if @@rowcount<>1        
   Raiserror('系统找不到该发货单,单据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)        
 else begin        
    --单价是否为0        
    if exists(select 1 from sl_invoicedl where Price=0 and  InvoiceId=@InvoiceId)         
    begin        
      Raiserror('单价不能为0,审核失败!',16,1)        
      return 0        
    end        
    --其它收入是否正确        
            
    --返回库存情况        
    select WareId,PartNo,Brand,Qty,RmnQty,SndQty,        
           Isnull((select sum(d.qty) from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)        
            -Isnull((select sum(d.qty) from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)        
            as myStok        
              
        from sl_invoicedl         
          where InvoiceId=@InvoiceId         
            order by dlId        
      
 end        
    
   update  crm_client set GatheringEmp=  @GatheringEmp where code=@ClientId and isnull(@GatheringEmp,'')=''      
      
  /*    
    declare @PartNo varchar(50),@msg varchar(200)      
          
    select @PartNo =PartNo  From wr_ware where isnull(cost,0)=0 and  id in (select wareid         from sl_invoicedl             where InvoiceId=@InvoiceId)      
          
    if isnull(@PartNo ,'')<>''      
    begin      
           set @msg='<'+@PartNo +'> 成本价不能为0,审核失败!'      
               
           Raiserror(@msg,16,1)     
            Rollback     
           return 0        
    end      
*/    
  if @@error=0         
     Return 1        
  else        
  begin        
     Rollback        
     Raiserror('事务提交失败,操作无效',16,1)        
  end        
  Return 0      
      
    
    
-- select  * From wr_ware where isnull(cost,0)=0    
-- select GatheringEmp, * From crm_client  where  isnull(GatheringEmp,'')='' and code='HZ000004'     
  