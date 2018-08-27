 alter  PROCEDURE [dbo].[ph_return_chk1]         
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
      update ph_return set IsConfirm=1,IsChk=1,WhOutCode=@OutCode,ChkManId=@HandManId,ChkTime=dbo.Fn_IsMonthClose (ChkTime)   where Code=@ReturnId        
      
      update ph_orderdl set phreturnQty= ISNULL( b.qty,0)              
      from ph_orderdl dl               
      left join (select SUM(qty)as Qty , PhOrdFID               
                 from ph_returndl  ardl join ph_return arM on ardl.returnid =arm.Code              
                 where arm.IsChk=1 and  Code=@ReturnId  group by PhOrdFID )  as b on dl.PhOrdFID = b.PhOrdFID              
      where dl.PhOrdFID in (select PhOrdFID from ph_returndl where  returnid=@ReturnId )              
                                
      
    Commit        
    if @@error=0         
      Return 1        
    else        
      Rollback        
    Return 0        
 end      
  
  