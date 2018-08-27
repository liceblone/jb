alter PROCEDURE [dbo].[sl_invoice_out]   
                 @abortstr varchar(200) output,                
                 @WhId varchar(20),                  
                 @InvoiceId varchar(20),                  
                 @HandManId varchar(20),                  
                 @OutCode varchar(20) output                  
AS            
set @abortstr=''      
declare @IsClose bit                  
set @IsClose=0                  
/*                  
if (select ChkTime from sl_invoice where Code=@InvoiceId) is null and GetDate()<(select xDate from fn_date where Id=1)                  
begin                  
  Raiserror('�������������������г���,�õ���Ŀǰ�������,�������ڻ���ѯ���!',16,1)                   
  return 0                  
end                  
*/                  
          
    declare @GatheringEmp varchar(30)  , @ClientId varchar(30)            
    select  @GatheringEmp = GatheringEmp , @ClientId =ClientId    from sl_invoice              where code =@InvoiceId          
          
    declare @PartNo varchar(50),@msg varchar(200)              
                  
    select @PartNo =PartNo  From wr_ware where isnull(cost,0)=0 and  id in (select wareid         from sl_invoicedl             where InvoiceId=@InvoiceId)              
                  
    if isnull(@PartNo ,'')<>''              
    begin              
           set @msg=isnull(@PartNo,'') +' �ɱ��� Ϊ0,����ʧ��!'              
           Raiserror(@msg,16,1)                       
           return 0                    
    end              
          
          
    if Not exists(select 1 from sl_invoicedl where InvoiceId=@InvoiceId and Not ((SndQty is null) or SndQty=0))                  
    begin                  
       Raiserror('����ʧ��,ԭ����: û���ṩ�κβ�������.',16,1)                  
       return 0                  
    end                  
    
    if exists (select * from sl_invoicedl  where InvoiceId=@InvoiceId and IsNull(SndQty,0)>0     
                     and IsNull(SndQty,0)>Isnull((select sum(d.qty) from wh_in m     
                                                            inner join wh_indl d  on m.Code=d.InId and m.IsChk=1     
                                                                and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)    
                                         -Isnull((select sum(d.qty) from wh_out m     
                                                            inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1     
                                                                and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)    
                                           +Isnull((select sum(Qty) from wh_regulate where WhId=@WhId and WareId=sl_invoicedl.WareId),0))                
     begin                  
         Raiserror('����ʧ��,ԭ����: ���ݴ���Ŀ��������������,���֤.',16,1)                  
         return 0                  
     end                  
    
begin tran
      exec sys_myid 320,@OutCode out                  
      insert into wh_out(LnkBlCd,Code,OutTypeId,OutDate,WhId,ClientId,ClientName,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)                   
           select @InvoiceId,@OutCode,'X01',GetDate(),WhId,ClientId,ClientName,@HandManId,'���۷������ⵥ',@HandManId,GetDate(),1,@HandManId,GetDate() from sl_invoice where Code=@InvoiceId                  
      insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)                   
           select @OutCode,WareId,PartNo,Brand,SndQty,Price from sl_invoicedl where InvoiceId=@InvoiceId and Not ((SndQty is null) or SndQty=0) order by dlId                  
    
      update sl_invoicedl set SndQty=null,RmnQty=Qty-IsNull((select sum(w.Qty) from wh_outdl w where w.WareId=sl_invoicedl.WareId and w.OutId in (select Code from wh_out where LnkBlCd=@InvoiceId)),0) where InvoiceId=@InvoiceId                  
      if not exists(select 1 from sl_invoicedl where InvoiceId=@InvoiceId and RmnQty<>0)                   
         set @IsClose=1                  
      update sl_invoice set IsClose=@IsClose where Code=@InvoiceId                  
      --sl_invoice.isclose not used      
                        
      if exists(select *from sl_invoicedl  where InvoiceId=@InvoiceId and isnull(RmnQty,0)<>0  )
      begin
         rollback
         set @abortstr='�汾5.0.2.5֮����������'            
         return 0   
      end

      if exists (select 1 from sl_invoice where IsChk=0 and Code=@InvoiceId)                  
      begin                  
        update sl_invoice set IsOnce=@IsClose,IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()),IsConfirm=1 where Code=@InvoiceId                  
        update sl_invoicedl set bhNote='Ƿ'+cast(RmnQty as varchar(10))+'psc' where InvoiceId=@InvoiceId and RmnQty<>0                  
        update wh_out set IsFirst=1 where Code=@OutCode                  
      end                  
    
      update sl_invoicedl             
      set Cost=isnull( (select isnull(Cost,price) from wr_ware where Id=WareId and Cost>0 and price>0),0) where InvoiceId=@InvoiceId and Cost is null                  
             
            
      update sl_invoice set TaxRate=(select MoneyX from sys_parameters where Id=6) where Code=@InvoiceId and IsTax=1 and TaxRate=0                  
      declare @TaxRate money                  
      select @TaxRate=(select TaxRate from sl_invoice where Code=@InvoiceId)                  
      --update sl_invoice set Profit=(select sum(Qty*(Price-Cost-Price*@TaxRate)) from sl_invoicedl where InvoiceId=Code)-(WareFund-GetFund) where Code=@InvoiceId                  
      update sl_invoice set Profit=(select sum(Qty*(Price-Cost)) from sl_invoicedl where InvoiceId=Code)  -(WareFund-GetFund) where Code=@InvoiceId                  
                  
                
                
      update  crm_client set GatheringEmp=  @GatheringEmp where code=@ClientId and isnull(GatheringEmp,'')=''              
    
    
    
commit tran
    
  return 1
