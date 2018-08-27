CREATE PROCEDURE [dbo].[sl_invoice_out]     
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
  
go

CREATE   PROCEDURE [dbo].[ph_arrive_chk1]               
                 @ArriveId varchar(20),              
                 @HandManId varchar(20)              
AS              
--2006-7-25����˱�־��1���ٸ��³ɱ�����      2006-8-21��wr_ware isuse=1      
 declare @IsChk bit,@TaxRate money,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int              
 set @BillId=9              
 select @TaxRate=TaxRate,@DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode from ph_arrive where Code=@ArriveId and IsChk=0              
 if @@rowcount<>1              
   Raiserror('ϵͳ�Ҳ����õ�����,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)              
 else begin              
   if exists(select 1 from ph_arrivedl where (Price=0 or Price is null) and  ArriveId=@ArriveId)               
   begin              
     Raiserror('���۲���Ϊ0,���ʧ��!',16,1)              
     return 0              
   end              
   begin tran              
                 
     exec sys_myid 316,@InCode out              
     insert into wh_in(Code,InTypeId,InDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)               
           select @InCode,'I01',GetDate(),WhId,ClientId,HandManId,'�ɹ��������ȷ�ϵ�','sys',GetDate(),1,HandManId,GetDate() from ph_arrive where Code=@ArriveId              
     insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)               
           select @InCode,WareId,PartNo,Brand,Qty,Price-Price*@TaxRate from ph_arrivedl where ArriveId=@ArriveId order by dlId              
     update ph_arrive set IsConfirm=1,WhInCode=@InCode,IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ArriveId              
     --���µ���              
     update wr_ware set Price=IsNull((select top 1 (d.Price-d.Price*m.TaxRate) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.WhInCode is Not null and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc),0) where Id in (select
  
   WareId from ph_arrivedl where ArriveId=@ArriveId)              
            
 exec fn_UpdateCost 'ph_arrive',@ArriveId    --����˱�־��1���ٸ��³ɱ���            
      
      
 update wr_ware set IsUse=1 from wr_ware T1 join ph_arrivedl T2 on T1.id=t2.wareid and ArriveId=@ArriveId     
--�������ñ�־      
      
     Commit              
     if @@error=0               
       Return 1              
     else              
       Rollback              
     Return 0              
 end            
          
        
      
    
    
go

CREATE  PROCEDURE [dbo].[sl_retail_chk1]     
                 @RetailId varchar(20),    
                 @HandManId varchar(20)    
AS    
 declare @IsChk bit,@IsClose bit,@ChkManId varchar(50),@OutCode Varchar(20),@BillId int,@DisCount Money,@WhId varchar(20)    
 set @BillId=3    
 select @IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@OutCode=WhOutCode,@WhId=WhId from sl_retail where Code=@RetailId and IsChk=0    
 if @@rowcount<>1    
   Raiserror('ϵͳ�Ҳ��������۵�,���ݿ����ѱ���������Աɾ����δ���,��[-ˢ��-]��֤!',16,1)    
 else    
 begin    
--/*    
    --������Ƿ�    
     declare @Msg varchar(8000),@WareId int,@Line int,@Qty int,@Stok int,@PartNo varchar(100),@Brand varchar(50)    
     set @Msg=''    
     set @Line=0    
     declare p cursor for    
       select WareId,IsNull(PartNo,''),IsNull(Brand,''),IsNull(Qty,0) from sl_retaildl where RetailId=@RetailId order by dlId    
     open p    
     fetch next from p into @WareId,@PartNo,@Brand,@Qty    
     while @@FETCH_STATUS = 0    
     begin    
       select @Line=@Line+1    
       exec Get1Ware1WhStok @WhId,@WareId,@Stok out    
       if @Qty>@Stok    
       begin             
         set @Msg=@Msg+cast(@Line as varchar(10))+'   '+@PartNo+'   '+@Brand+'     '+cast(@Qty as varchar(10))+'>'+cast(@Stok as varchar(10))+ CHAR(13) + CHAR(10)    
--         close p    
--         deallocate p    
--         Raiserror(@Msg,16,1)    
--         Return 0    
       end    
       fetch next from p into @WareId,@PartNo,@Brand,@Qty    
     end    
     close p    
     deallocate p    
     if @Msg<>''    
     begin    
       set @Msg='������Ʒ��治��:'+char(13)+char(10)+char(13)+char(10)+@Msg      
       Raiserror(@Msg,16,1)    
       Return 0    
     end    
--*/    
     begin tran    
       --����    
       exec sys_myid 320,@OutCode out    
       insert into wh_out(Code,OutTypeId,OutDate,WhId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)     
           select @OutCode,'X00',GetDate(),WhId,@HandManId,'���۷�������ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from sl_retail where Code=@RetailId    
       insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)     
           select @OutCode,WareId,PartNo,Brand,Qty,Price from sl_retaildl where RetailId=@RetailId order by dlId    
       update sl_retail set IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()),WhOutCode=@OutCode where Code=@RetailId    
update sl_retaildl set Cost=(select Cost from wr_ware where Id=WareId) where RetailId=@RetailId and Cost is null    
update sl_retail set TaxRate=(select MoneyX from sys_parameters where Id=6) where TaxRate=0    
declare @TaxRate money    
select @TaxRate=(select TaxRate from sl_retail where Code=@RetailId)    
  
--update sl_retail set Profit=(select sum(Qty*(Price-Cost-Price*@TaxRate)) from sl_retaildl where RetailId=Code)-(WareFund-GetFund) where Code=@RetailId    
--2006-12-28  
update sl_retail set Profit=(select sum(Qty*(Price-Cost)) from sl_retaildl where RetailId=Code)-(WareFund-GetFund) where Code=@RetailId    
  
     goto ACommit    
 end    
ACommit:    
  Commit    
  if @@error=0     
    Return 1    
  else    
  begin    
    Rollback    
    Raiserror('�����ύʧ�ܣ�������Ч',16,1)    
  end    
  Return 0  
  
go



CREATE   PROCEDURE [dbo].[wh_in_chk1]             
                 @InId varchar(20),            
                 @HandManId varchar(20)            
AS            
--2006-7-28ͬ������˰��          
          
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20) ,@TaxRate money           
 set @BillId=21            
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=0            
 if @@rowcount<>1            
   Raiserror('ϵͳ�Ҳ�������ⵥ,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)            
 else            
 begin            
    begin tran            
                
  
  
      select  @TaxRate=MoneyX from sys_parameters where Id=6  --2006-7-28 ȥ��   TaxRate=@TaxRate,      
      update wh_in set IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@InId     
  
  
      if exists(select ChkTime,billtime,* from         wh_in where ChkTime<billtime)  
      begin  
           raiserror('���ʱ������',16,1)            
           return(0)      
      end  
  
 if @InOut='I08' or    @InOut='I09'       
      exec fn_UpdateCost 'wh_in',@InId      
    
 update wr_ware set IsUse=1 from wr_ware T1 join wh_inDl T2 on T1.id=t2.wareid   where InId=@InId     
--�������ñ�־            
      
    commit            
    if @@error=0            
       return(1)            
    rollback            
    raiserror('�����ύʧ��,������Ч!',16,1)            
    return(0)            
 end            
Return 1          
    
  
go
CREATE PROCEDURE [dbo].[wh_out_chk1]   
                 @OutId varchar(20),  
                 @HandManId varchar(20),  
                 @LoginId varchar(20)  
AS  
 declare @IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@Msg varchar(8000),@ClientId varchar(20),@OutTypeId varchar(20),@WhId varchar(20),@InOut varchar(20)  
   
 set @BillId=22  
 select @InOut=OutTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@OutTypeId=OutTypeId,@WhId=WhId from wh_out where Code=@OutId and IsChk=0  
 if @@rowcount<>1  
   Raiserror('ϵͳ�Ҳ����ó��ⵥ,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)  
 else  
 begin  
   --check right  
   declare @a bit,@c varchar(20)  
   if @InOut='X08'   
     set @c='0301040206'  
   else if @InOut='X09'   
     set @c='0301040205'  
   else  
     set @c='0301040203'       
   exec @a=sys_CheckRight @LoginId,@c  
   if @a=0  
   begin  
     Raiserror('�Բ���! �����߱��ó������͵����Ȩ��. �������Ա��ϵ.',16,1)  
     Return(0)  
   end  
   else  
   begin  
--/*  
    --������Ƿ�  
     declare @WareId int,@Line int,@Qty int,@Stok int,@PartNo varchar(100),@Brand varchar(50)  
     set @Msg=''  
     set @Line=0  
     declare p cursor for  
       select WareId,IsNull(PartNo,''),IsNull(Brand,''),IsNull(Qty,0) from wh_outdl where OutId=@OutId order by dlId  
     open p  
     fetch next from p into @WareId,@PartNo,@Brand,@Qty  
     while @@FETCH_STATUS = 0  
     begin  
       select @Line=@Line+1  
       exec Get1Ware1WhStok @WhId,@WareId,@Stok out  
       if @Qty>@Stok  
       begin           
--         set @Msg=@Msg+cast(@Line as varchar(10))+' '+@PartNo+ CHAR(13) + CHAR(10)  
         set @Msg=@Msg+cast(@Line as varchar(10))+'   '+@PartNo+'   '+@Brand+'     '+cast(@Qty as varchar(10))+'>'+cast(@Stok as varchar(10))+ CHAR(13) + CHAR(10)  
       end  
       fetch next from p into @WareId,@PartNo,@Brand,@Qty  
     end  
     close p  
     deallocate p  
     if @Msg<>''  
     begin  
       set @Msg='������Ʒ��治��:'+char(13)+char(10)+char(13)+char(10)+@Msg    
       Raiserror(@Msg,16,1)  
       Return 0  
     end  
--*/  
     begin tran  
       update wh_out set IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@OutId     
     commit  
     if @@error=0  
        return(1)  
     rollback  
     raiserror('�����ύʧ��,������Ч!',16,1)  
     return(0)  
   end  
 end  
  
  
  
Return 1


go
CREATE  PROCEDURE [dbo].[sl_return_chk1]             
                 @ReturnId varchar(20),            
                 @HandManId varchar(20)            
AS            
--2006-7-25�����˻���Ӱ��ɱ���  2006-8-21�������ñ�־      
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@InCode varchar(20)            
 set @BillId=20            
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@InCode=WhInCode from sl_return where Code=@ReturnId and IsChk=0            
 if @@rowcount<>1            
   Raiserror('ϵͳ�Ҳ������˻���,���ݿ����ѱ���������Աɾ����δ���,��[-ˢ��-]��֤!',16,1)            
else            
 begin            
   begin tran            
--     exec fn_UpdateCost 'sl_return',@ReturnId            
     exec sys_myid 316,@InCode out            
     insert into wh_in(Code,InTypeId,InDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)             
           select @InCode,'I03',GetDate(),WhId,ClientId,@HandManId,'�����˻����ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from sl_return where Code=@ReturnId            
     insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)             
           select @InCode,WareId,PartNo,Brand,Qty,Price from sl_returndl where ReturnId=@ReturnId order by dlId            
     update sl_return set IsConfirm=1,WhInCode=@InCode,IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ReturnId            
update sl_returndl set Cost=(select isnull(Cost,0) from wr_ware where Id=WareId) where ReturnId=@ReturnId and Cost is null            
update sl_return set TaxRate=(select MoneyX from sys_parameters where Id=6) where isnull(TaxRate,0)=0            
declare @TaxRate money            
select @TaxRate=(select TaxRate from sl_return where Code=@ReturnId)            
--update sl_return set Profit=(select sum(Qty*(Price-Cost-Price*@TaxRate)) from sl_returndl where ReturnId=Code)-(WareFund-GetFund) where Code=@ReturnId            
  
update sl_return set Profit=(select sum(Qty*(Price)) from sl_returndl where ReturnId=Code)-(WareFund-GetFund) where Code=@ReturnId            
      
--��IsUse      
update wr_ware set Isuse=1 from wr_ware T1 join sl_returnDL T2 on   T1.id=t2.wareid      
      
      
      
   goto ACommit            
 end            
ACommit:            
  commit            
  if @@error=0             
     Return 1            
  else            
  begin            
     Rollback            
     Raiserror('�����ύʧ��,������Ч',16,1)            
  end            
  Return 0   

       
go
CREATE  PROCEDURE [dbo].[ph_return_chk1]       
                 @ReturnId varchar(20),      
                 @HandManId varchar(20)      
AS      
--2006-7-28 �����ʱ����˰��    
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@OutCode varchar(50),@BillId int  ,@TaxRate money    
    
 set @BillId=13      
 select @DisCount=WareFund-GetFund,@PayFund=PayFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@OutCode=WhOutCode from ph_return where Code=@ReturnId and IsChk=0      
         
if @@rowcount<>1      
     Raiserror('ϵͳ�Ҳ������˻���,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)      
 else      
 begin      
    --������Ƿ�      
    declare @WareId int,@Line int,@Qty decimal(15,2),@Stok decimal(15,2),@WhId varchar(20),@Msg varchar(100)      
    set @Line=0      
    select @WhId=(select WhId from ph_return where Code=@ReturnId)      
    declare p cursor for      
      select WareId,IsNull(Qty,0) from ph_returndl where ReturnId=@ReturnId order by dlId      
    open p      
    fetch next from p into @WareId,@Qty      
    while @@FETCH_STATUS = 0      
    begin      
      select @Line=@Line+1      
      exec Get1Ware1WhStok @WhId,@WareId,@Stok out      
      if @Qty>@Stok      
      begin      
         close p      
         deallocate p      
         set @Msg='��[ '+cast(@Line as varchar(10))+' ]�д�����������,���ʧ��'      
         Raiserror(@Msg,16,1)      
         Return 0      
      end      
      fetch next from p into @WareId,@Qty      
    end      
    close p      
    deallocate p      
    begin tran      
      exec sys_myid 320,@OutCode out      
      insert into wh_out(Code,OutTypeId,OutDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)       
           select @OutCode,'X03',GetDate(),WhId,ClientId,@HandManId,'�ɹ��˻�����ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from ph_return where Code=@ReturnId      
      insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)       
           select @OutCode,WareId,PartNo,Brand,Qty,Price from ph_returndl where ReturnId=@ReturnId order by dlId      
/*      
           select m.ClientId,m.ReturnDate,'�ɹ��˻�:'+d.PartNo+','+d.Brand+' '+cast(Qty as varchar(50))+'*'+cast(Price as varchar(50)),Qty*Price,0,@BillId,Code from ph_return m,ph_returndl d where m.Code=d.ReturnId and m.Code=@ReturnId      
      if @DisCount<>0      
         insert into fn_ca(ClientId,Xdate,Brief,Increase,Subtract,BillId,BillCode)      
              select ClientId,ReturnDate,Code+'�Ųɹ��˻����ۿ�',0,@DisCount,@BillId,Code from ph_return where Code=@ReturnId      
*/    
      select  @TaxRate=MoneyX from sys_parameters where Id=6  --2006-7-28add   12-28ȥ�� TaxRate=@TaxRate,  
      update ph_return set IsConfirm=1,IsChk=1,WhOutCode=@OutCode,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ReturnId      
    
     
    
    Commit      
    if @@error=0       
      Return 1      
    else      
      Rollback      
    Return 0      
 end    


go


CREATE PROCEDURE [dbo].[fn_alrdyinout_chk]     
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
   Raiserror('�Բ���,�����߱������� �տ��ʻ� ��Ȩ��,�������Ա��ϵ.',16,1)    
   return 0    
 end    
  
 if @IsChk=1    
 begin    
    
   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)    
   begin    
       Raiserror('ֻ�й���Ա���з���˵��ݵ�Ȩ��,�������Աѯ��.',16,1)    
       return 0    
   end    
   else   
   begin    
         set @IsChk=0    
         set @ChkManId=null    
  
  
    
          ---����Ƿ��Ѿ��½�  
          declare @fmonth smalldatetime    
          declare @Msg    varchar(200)    
    
     
    
         if @Pre='FR'    
              select @fmonth=   chktime from fn_receiver    where Code=@ReceiverId    
         else if @Pre='SI'    
              select @fmonth=   chktime from sl_invoice   where Code=@ReceiverId    
         else if @Pre='FP'    
              select @fmonth=   chktime from fn_payment   where Code=@ReceiverId    
         else if @Pre='RT'    
             select @fmonth=   chktime from sl_retail     where Code=@ReceiverId    
         else if @Pre='FT'   
             select @fmonth=   xChkTime from fn_bnktransfer   where Code=@ReceiverId-- and OutId=@BankId    
   
  
          if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
          begin    
             set @Msg='���е����������������'+char(13)+convert(varchar(4), year(@fmonth))  +'��'+  convert(varchar(4), month(@fmonth) ) +  '���Ѿ� [�½�]�� �����ٶԸõ��������� ��'     
             Raiserror( @Msg ,16,1)            
             return 0          
          end    
   end    
 end   
 else    
 begin    
     set @IsChk=1    
     set @ChkManId=@HandManId    
 end    
    
       if @Pre='FR'    
         update fn_receiver set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate())  where Code=@ReceiverId    
       else if @Pre='SI'    
         update sl_invoice set FnIsChk=@IsChk,FnChkManId=@ChkManId,FnChkTime=IsNull(FnChkTime,GetDate()) where Code=@ReceiverId    
        else if @Pre='FP'    
         update fn_payment set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ReceiverId    
       else if @Pre='RT'    
         update sl_retail set FnIsChk=@IsChk,FnChkManId=@ChkManId,FnChkTime= IsNull(FnChkTime,GetDate())  where Code=@ReceiverId    
       else if @Pre='FT'    
       begin    
         if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and OutId=@BankId) --ת��    
         begin    
           if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and IsiChk=1) and (@IsChk=0)    
           begin    
             Raiserror('�Բ���,���ڲ�ת�ʵ��Ѿ�ͨ��ת�뷽�����,��Ϊ�����ܽ��з���˲���.',16,1)    
             return 0    
           end    
           else    
             update fn_bnktransfer set IsxChk=@IsChk,xChkManId=@ChkManId,xChkTime= IsNull(xChkTime,GetDate()) where Code=@ReceiverId-- and OutId=@BankId    
         end    
         else begin    
           if exists(select 1 from fn_bnktransfer where Code=@ReceiverId and IsxChk=0)    
           begin    
             Raiserror('�Բ���,���ڲ�ת�ʵ�δ��ת���������,��Ϊ�����ܽ�����˲���.',16,1)    
             return 0    
           end    
           else           
             update fn_bnktransfer set IsiChk=@IsChk,iChkManId=@ChkManId,iChkTime=IsNull(iChkTime,GetDate()) where Code=@ReceiverId --and InId=@BankId    
         end    
       end    
    
Return 1  
  
go

CREATE PROCEDURE [dbo].[fn_shldinout_chk]   
                 @LoginId varchar(20),  
                 @HandManId varchar(20),  
                 @ShldId varchar(20),  
                 @IsChk bit  
AS  
 declare @ChkManId varchar(50),@ChkTime datetime,@Pre varchar(2)  
 set @Pre=substring(@ShldId,1,2)  
-- else if @IsClose=1  
--   Raiserror('�Ѿ�[-�ر�-]����ⵥ,���ܽ���[-���-]����',16,1)  
  
declare @HaveRit bit,@RitId varchar(50)  
 if @IsChk=1  
 begin  
--   if @ChkManId<>@HandManId  
--     Raiserror('ֻ������˲�����Ӧ���ݵķ����Ȩ��!',16,1)  
--   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)  
--   begin  
--     Raiserror('ֻ�й���Ա���з���˵��ݵ�Ȩ��,�������Աѯ��.',16,1)  
--     return 0  
--   end  
   set @RitId='0301050803'  
   set @IsChk=0  
   set @ChkManId=null  
   set @Chktime=null  
 end else  
 begin  
   set @RitId='0301050802'  
   set @IsChk=1  
   set @ChkManId=@HandManId  
   set @Chktime=GetDate()  
 end  
  
   exec @HaveRit=sys_CheckRight @LoginId,@RitId  
   if @HaveRit=0   
   begin  
     Raiserror('�Բ���,��û�иù��ܵĲ���Ȩ��,�������Աѯ��.',16,1)  
     return 0  
   end  
  
       if @Pre='YI'  
         update fn_shldin set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ShldId  
       else if @Pre='YO'  
         update fn_shldout set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ShldId  
       else if @Pre='FC'  
         update fn_clntransfer set IsChk=@IsChk,ChkManId=@ChkManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@ShldId  
        
Return 1
