
CREATE    PROCEDURE [dbo].[ph_arrive_QtyChk1]                                           
                 @ArriveId varchar(20),                                          
                 @HandManId varchar(20)                                          
AS                                          
--2006-7-25在审核标志置1后再更新成本单价      2006-8-21置wr_ware isuse=1                           
--12/15/2012 ( d.Price/(1+m.TaxRate))                                  
 declare @IsChk bit,@TaxRate money,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int , @RowCount int ,@ErrorMessage varchar(300)                                    
 set @BillId=9                                          
 select @TaxRate=TaxRate,@DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode from ph_arrive where Code=@ArriveId and isnull( FQtyChk ,0)=0                                          
 set @RowCount=@@rowcount                  
 set @ErrorMessage = '系统找不到该到货单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!'--- +convert(varchar(10), @RowCount)                  
                          
 if exists(select m.ClientId, ph.ClientId ,m.Code from ph_arrive m           
    join ph_arrivedl dl on m.Code=dl.ArriveId          
    left join (select ordm.ClientId, orddl.PhOrdFID from ph_order ordM join ph_orderdl ordDL on ordm.Code=orddl.OrderId )          
          ph on m.ClientId <>ISNULL(ph.ClientId,'') and dl.PhOrdFID =ph.PhOrdFID          
    where ph.PhOrdFID is not null   and m.Code=@ArriveId )          
 begin          
   set @ErrorMessage='明细的订单供应商跟表头供应商不一致。'          
   Raiserror(@ErrorMessage ,16,1)             
   return 0          
 end           
              
 if @RowCount<>1                                          
    select @RowCount --                   
  --  Raiserror(@ErrorMessage ,16,1)                                          
 else                         
 begin                                      
  BEGIN TRY                                
   begin tran                                   
      if isnull(@InCode ,'')=''  
        exec sys_myid 316,@InCode out                                          
      insert into wh_in(Code,InTypeId,InDate,WhId,ClientId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)                                           
           select @InCode,'I01',GetDate(),WhId,ClientId,HandManId,'采购到货入库确认单','sys',GetDate(),1,HandManId,GetDate() from ph_arrive where Code=@ArriveId                                          
      insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)                                           
           select @InCode,WareId,PartNo,Brand,Qty,Price  from ph_arrivedl where ArriveId=@ArriveId order by dlId                                          
      update ph_arrive set IsConfirm=1,WhInCode=@InCode,FQtyChk=1  where Code=@ArriveId                                                           
                                  
      --开户雇用标志                             
      update wr_ware set IsUse=1 from wr_ware T1 join ph_arrivedl T2 on T1.id=t2.wareid and ArriveId=@ArriveId                                 
                             
      update ph_orderdl set ArrivedQty= ISNULL( b.qty,0)              
      from ph_orderdl dl               
      left join (select SUM(qty)as Qty , PhOrdFID               
                 from ph_arrivedl ardl join ph_arrive arM on ardl.ArriveId =arm.Code              
                 where arm.FQtyChk=1 and  ArriveId=@ArriveId group by PhOrdFID )  as b on dl.PhOrdFID = b.PhOrdFID              
      where dl.PhOrdFID in (select PhOrdFID from ph_arrivedl where  ArriveId=@ArriveId )              
                  
      update     TBarcode set fischk =1 where FBillCode  =@ArriveId               
                                
    commit                                                 
    END TRY                                
    BEGIN CATCH                                
       EXECUTE usp_GetErrorInfo;     -- Execute error retrieval routine.                                
               raiserror('事务提交失败,操作无效!',16,1)                                         
       rollback                                                                                   
 return 0                                   
    END CATCH    ;                        
end 
