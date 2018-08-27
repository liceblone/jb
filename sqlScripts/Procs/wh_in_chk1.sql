alter PROCEDURE [dbo].[wh_in_chk1]                   
                 @InId varchar(20),                  
                 @HandManId varchar(20)                  
AS                  
--2006-7-28同行入库加税率                
                
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20) ,@TaxRate money                 
 set @BillId=21                  
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=0                  
 if @@rowcount<>1                  
   Raiserror('系统找不到该入库单,数据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)                  
 else                  
 begin                  
    BEGIN TRY        
    begin tran                         
       select  @TaxRate=MoneyX from sys_parameters where Id=6  --2006-7-28 去掉   TaxRate=@TaxRate,            
       update wh_in set IsChk=1,ChkManId=@HandManId,ChkTime=dbo.Fn_IsMonthClose (ChkTime)   where Code=@InId           
        
       if exists(select ChkTime,billtime,* from         wh_in where ChkTime<billtime and  Code=@InId )        
       begin        
           raiserror('审核时间有误！',16,1)                  
           --return(0)            
       end        
        
       if @InOut='I08' or    @InOut='I09'             
          exec fn_UpdateCost 'wh_in',@InId            
         
       --开户雇用标志                   
       update wr_ware set IsUse=1 from wr_ware T1 join wh_inDl T2 on T1.id=t2.wareid   where InId=@InId           
   
       --更新最低限价	  select* from wr_ware  where id not in (select wareid from TPriceChangeInfo)
       --if @InOut='I08' or    @InOut='I09' 
       if  exists( select* from wh_inDL  where InID=@InId and  wareid not in (select wareid from TPriceChangeInfo))  
       insert into TPriceChangeInfo(WareID ,model,partno,Brand,Origin,pack,MinPrice,note)  
       select  dl.wareid,wr.model,dl.partno,dl.brand ,wr.Origin, dl.pack, dl.Price/(1+m.TaxRate) ,'同行，异地调配:'+@InId   
       from wh_inDL  dl join wr_ware wr on dl.wareid=wr.id	join Wh_in m on m.code=dl.inid
       where InID=@InId  and  dl.wareid not in (select wareid from TPriceChangeInfo)  
  
       update TPriceChangeInfo   set MinPrice = dl.Price/(1+m.TaxRate)   ,BillTime=getdate()  
       from TPriceChangeInfo A  
       join wh_inDL          dl on A.wareid=dl.wareid  and dl.InID=@InId  
       join Wh_in m on m.code=dl.inid
       where isnull( A.MinPrice ,0) >= isnull( dl.Price/(1+m.TaxRate)   ,0) 

   commit                 
   END TRY        
   BEGIN CATCH        
       EXECUTE usp_GetErrorInfo;		   -- Execute error retrieval routine.        
               raiserror('事务提交失败,操作无效!',16,1)                         
       rollback                                                           
       return 0           
   END CATCH;  
 end                  
Return 1                
          
        
    
  