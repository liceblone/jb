 
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
  
go



/*  
���۷��� sl_invoice_chk0  
  
�����˻�sl_return_chk0  
  
�ɹ�����  ph_arrive_chk0  
  
�ɹ��˻� ph_return_chk0  
  
  
���  
�տ  
  
Ӧ�յ�  
Ӧ����  
  
�ͻ�ת�ʵ�  
  
(fn_alrdyinout_chk)  
  
  
���ⵥ wh_out_chk0  
  
��ⵥ wh_in_chk0  
  
���۵� sl_retail_chk0   
  
  
  
select f04,f33 ,*From T602  
*/  
  
  
CREATE PROCEDURE [dbo].[sl_invoice_chk0]           
                 @InvoiceId varchar(20),          
                 @HandManId varchar(20),          
                 @LoginId varchar(20)          
AS          
          
   
  
  
declare @fmonth smalldatetime  
declare @Msg    varchar(200)  
  
select @fmonth=   chktime from sl_invoice  where code= @InvoiceId  
  
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )  
begin  
   set @Msg=convert(varchar(4), year(@fmonth))  +'��'+  convert(varchar(4), month(@fmonth) ) +  '���Ѿ� �½ᣬ �����ٶԸõ��������� ��'   
   Raiserror( @Msg ,16,1)          
   return 0        
end  
   
    
  
if exists(select *from sl_invoicedl  where InvoiceID= @InvoiceId and isnull(FpID,'')<>'' )        
begin       
 Raiserror('�ⵥ����ϸ�Ѿ����귢Ʊ����������',16,1)          
 return 0         
end        
    
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@BankId varchar(20),@PayeeId varchar(20),@WhId varchar(20)          
 set @BillId=19          
 select @WhId=WhId,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@BankId=BankId,@PayeeId=PayeeId from sl_invoice where Code=@InvoiceId and IsChk=1          
          
    
      
 if @@rowcount<>1          
   Raiserror('ϵͳ�Ҳ����÷�����,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)          
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
     Raiserror('�����ύʧ��,������Ч',16,1)          
  end          
  Return 0        
        
------------  
