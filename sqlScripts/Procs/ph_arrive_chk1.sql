     
alter    PROCEDURE [dbo].[ph_arrive_chk1]                               
                 @ArriveId varchar(20),                              
                 @HandManId varchar(20)                              
AS                              
--2006-7-25����˱�־��1���ٸ��³ɱ�����      2006-8-21��wr_ware isuse=1               
--12/15/2012 ( d.Price/(1+m.TaxRate))                      
 declare @IsChk bit,@TaxRate money,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int ,@FQtyChk int                             
 set @BillId=9                              
 select @TaxRate=TaxRate,@DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode,@FQtyChk=FQtyChk from ph_arrive where Code=@ArriveId and IsChk=0                              
              
 if @@rowcount<>1                              
   Raiserror('ϵͳ�Ҳ����õ�����,���ݿ����ѱ���������Աɾ���������,��[-ˢ��-]��֤!',16,1)                              
 else             
 begin      
   if exists(select 1 from ph_arrive  where code=@ArriveId and convert(decimal(19,0),warefund) <> convert(decimal(19,0), OtherFund+ GetFund) )                               
   begin                              
     Raiserror('Ӧ������ȷ!',16,1)                              
     return 0                              
   end             
   if exists( select * from TParamsAndValues where FParamCode='020201' and FParamValue=1 )and  isnull(@FQtyChk,0)=0             
   begin        
  Raiserror('��ѡ���������!',16,1)                              
  return 0;         
   end ;         
   if @TaxRate>=1              
   begin              
     Raiserror('˰�ʲ���ȷ!',16,1)                              
     return 0;              
   end;                  
     
       
     
   if exists(select 1 from ph_arrivedl where (Price=0 or Price is null) and  ArriveId=@ArriveId)                               
   begin                              
     Raiserror('���۲���Ϊ0,���ʧ��!',16,1)                              
     return 0                              
   end                              
   BEGIN TRY                    
   begin tran                                   
      exec sys_myid 316,@InCode out                              
      insert into wh_in(Code,InTypeId,InDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)                               
           select @InCode,'I01',GetDate(),WhId,ClientId,HandManId,'�ɹ��������ȷ�ϵ�','sys',GetDate(),1,HandManId,GetDate() from ph_arrive where Code=@ArriveId                              
      insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)                               
           select @InCode,WareId,PartNo,Brand,Qty,Price /(1+@TaxRate) from ph_arrivedl where ArriveId=@ArriveId order by dlId                              
      update ph_arrive set IsConfirm=1,WhInCode=@InCode,IsChk=1,ChkManId=@HandManId,ChkTime=dbo.Fn_IsMonthClose (ChkTime)   where Code=@ArriveId                              
      --���µ���                              
      update wr_ware set Price=IsNull((select top 1 ( d.Price/(1+m.TaxRate)) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.WhInCode is Not null and IsChk=1  and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc), cost)     
  
    
        
      where Id in (select WareId from ph_arrivedl where ArriveId=@ArriveId)                              
                            
      exec fn_UpdateCost 'ph_arrive',@ArriveId    --����˱�־��1���ٸ��³ɱ���                            
                      
      --�������ñ�־                 
      update wr_ware set IsUse=1 from wr_ware T1 join ph_arrivedl T2 on T1.id=t2.wareid and ArriveId=@ArriveId                     
                 
      --��������޼�            
      if  exists( select* from ph_arrivedl  where ArriveId=@ArriveId and  wareid not in (select wareid from TPriceChangeInfo))              
          insert into TPriceChangeInfo(WareID ,model,partno,Brand,Origin,pack,MinPrice,note)              
          select  dl.wareid,wr.model,dl.partno,dl.brand ,wr.Origin, dl.pack, dl.Price/(1+m.TaxRate) ,'�ɹ�:'  +@ArriveId               
          from ph_arrivedl  dl join wr_ware wr on dl.wareid=wr.id  join ph_arrive M on M.code =dl.Arriveid          
          where ArriveId=@ArriveId  and  dl.wareid not in (select wareid from TPriceChangeInfo)            
                   
      update TPriceChangeInfo   set MinPrice =dl.Price/(1+m.TaxRate)  ,BillTime=getdate()              
      from TPriceChangeInfo A              
      join ph_arrivedl          dl on A.wareid=dl.wareid  and dl.ArriveId=@ArriveId  join ph_arrive M on M.code =dl.Arriveid            
      where isnull( A.MinPrice ,0) >= isnull( dl.Price/(1+m.TaxRate) ,0)                     
    commit                                     
    END TRY                    
    BEGIN CATCH                    
       EXECUTE usp_GetErrorInfo;     -- Execute error retrieval routine.                    
               raiserror('�����ύʧ��,������Ч!',16,1)                                     
       rollback                                                                       
       return 0                       
    END CATCH    ;            
end 