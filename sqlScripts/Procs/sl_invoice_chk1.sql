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
   Raiserror('ϵͳ�Ҳ����÷�����,���ݿ����ѱ���������Աɾ����δ���,��[-ˢ��-]��֤!',16,1)        
 else begin        
    --�����Ƿ�Ϊ0        
    if exists(select 1 from sl_invoicedl where Price=0 and  InvoiceId=@InvoiceId)         
    begin        
      Raiserror('���۲���Ϊ0,���ʧ��!',16,1)        
      return 0        
    end        
    --���������Ƿ���ȷ        
            
    --���ؿ�����        
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
           set @msg='<'+@PartNo +'> �ɱ��۲���Ϊ0,���ʧ��!'      
               
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
     Raiserror('�����ύʧ��,������Ч',16,1)        
  end        
  Return 0      
      
    
    
-- select  * From wr_ware where isnull(cost,0)=0    
-- select GatheringEmp, * From crm_client  where  isnull(GatheringEmp,'')='' and code='HZ000004'     
  