
CREATE    PROCEDURE [dbo].[ph_arrive_Qtychk0]                             
                 @ArriveId varchar(20),                            
                 @HandManId varchar(20)                            
AS                            
                
declare @fmonth smalldatetime                
declare @Msg    varchar(200)                
                
select @fmonth=   i.chktime from ph_arrive ph join wh_in i on ph.whincode=i.Code  where ph.code= @ArriveId                
                
if exists(select *From TMonthEndClose where dbo.Fn_MonthEqual( fmonth, @fmonth) =1   and isclosed=1  )                
begin                
   set @Msg='所有单据以审核日期立帐'+char(13)+convert(varchar(4), year(@fmonth))  +'年'+  convert(varchar(4), month(@fmonth) ) +  '月已经 [月结]， 不能再对该单进行弃审 ！'                 
   Raiserror( @Msg ,16,1)                        
   return 0                      
end                
                
                
--2006-7-25在审核标志置0后加上更新成本单价                            
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int                            
 set @BillId=9                            
 select @DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode from ph_arrive where Code=@ArriveId and FQtyChk=1                             
 if @@rowcount<>1                            
   Raiserror('系统找不到该到货单,单据可能已被[价格审核][删除]或[反审核],请[-刷新-]验证!',16,1)                            
 else             
 begin         
   if exists( select * from ph_arrive where Code=@ArriveId  and ISNULL( IsChk, 0)=1)        
   begin        
     Raiserror('请先做价格弃审.',16,1)                   
     return 0;          
   end         
   declare @foutbillcode varchar(30)      
   select  @foutbillcode= foutbillcode  from TBarcode where FBillCode  =@ArriveId   and FOutPackageBarCode is not null      
        
   if (@foutbillcode<>'')      
   begin      
     set @Msg='条码已经出库,不能删除.'+CHAR(13)+CHAR(10)+'单号:'+@foutbillcode      
     Raiserror(@Msg,16,1)     
     return 0      
   end      
                      
   BEGIN TRY                        
    begin tran                               
       delete from wh_indl where InId=@InCode                            
       delete from wh_in where Code=@InCode            
                           
       update ph_arrive set IsConfirm=0, FQtyChk=0,ChkManId=null where Code=@ArriveId  --,ChkTime=null                            
             
       update ph_orderdl set ArrivedQty= ISNULL( b.qty,0)      
       from ph_orderdl dl       
       left join (select SUM(qty)as Qty , PhOrdFID       
                 from ph_arrivedl ardl join ph_arrive arM on ardl.ArriveId =arm.Code      
                 where arm.FQtyChk=1 and  ArriveId=@ArriveId group by PhOrdFID )  as b on dl.PhOrdFID = b.PhOrdFID      
       where dl.PhOrdFID in (select PhOrdFID from ph_arrivedl where  ArriveId=@ArriveId )      
           
       delete     TBarcode  where FBillCode  =@ArriveId                         
    commit                                         
    END TRY                        
    BEGIN CATCH                        
       EXECUTE usp_GetErrorInfo;     -- Execute error retrieval routine.                        
               raiserror('事务提交失败,操作无效!',16,1)                                         
       rollback                                                                           
       return 0                           
    END CATCH    ;                            
 end                          
                  
                  
                  
---------------     