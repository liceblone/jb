  alter   PROCEDURE [dbo].[sl_return_chk0]             
                 @ReturnId varchar(20),            
                 @HandManId varchar(20)            
AS            
        
declare @fmonth smalldatetime    
declare @Msg    varchar(200)    
    
select @fmonth=   chktime from sl_return  where code= @ReturnId    
    
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
begin    
   set @Msg='所有单据以审核日期立帐'+char(13)+convert(varchar(4), year(@fmonth))  +'年'+  convert(varchar(4), month(@fmonth) ) +  '月已经 [月结]， 不能再对该单进行弃审 ！'     
   Raiserror( @Msg ,16,1)            
   return 0          
end    
    
    
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
        
    BEGIN TRY     
     begin tran            
       delete from wh_indl where InId=@InCode            
       delete from wh_in where Code=@InCode            
       update sl_return set IsConfirm=0,WhInCode=null,IsChk=0,Taxrate=0,ChkManId=null where Code=@ReturnId -- ,ChkTime=null              
      update wr_ware set IsUse=1 from wr_ware T1 join sl_returnDL T2 on T1.id=t2.wareid   where ReturnId=@ReturnId  
      
      -- set returnqty  select * from sl_orderdl
      update sl_orderdl set returnqty= ISNULL( b.qty,0)              
      from sl_orderdl dl               
      left join (select SUM(qty)as Qty , ardl.SLOrderID               
                 from sl_returndl ardl join sl_return  arM on ardl.ReturnId =arm.Code              
                 where arm.IsChk=1    and   ReturnId=@ReturnId group by ardl.SLOrderID )  as b on dl.F_ID = b.SLOrderID              
      where dl.f_id in (select SLOrderID from sl_returndl where  ReturnId=@ReturnId )              
             
                      
     commit                                                 
    END TRY                                
    BEGIN CATCH                                
       EXECUTE usp_GetErrorInfo;     -- Execute error retrieval routine.                                
               raiserror('事务提交失败,操作无效!',16,1)                                         
       rollback                                                                                   
    return 0                                   
    END CATCH    ;  
end     
        
    
-----------------  