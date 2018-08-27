
alter PROCEDURE [dbo].[wh_in_chk0]                 
                 @InId varchar(20),                
                 @HandManId varchar(20)                
AS                
    
    
  ---检查是否已经月结  
declare @fmonth smalldatetime    
declare @Msg    varchar(200)    
    
select @fmonth=   chktime from wh_in  where code= @InId    
    
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
begin    
   set @Msg='所有单据以审核日期立帐'+char(13)+convert(varchar(4), year(@fmonth))  +'年'+  convert(varchar(4), month(@fmonth) ) +  '月已经 [月结]， 不能再对该单进行弃审 ！'     
   Raiserror( @Msg ,16,1)            
   return 0          
end    
    
    
--2006-7-28清税率              
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20)                
 set @BillId=21                
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=1                
 if @@rowcount<>1                
   Raiserror('系统找不到该入库单,单据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)                
 else                
   begin                
     begin tran                
       update wh_in set IsChk=0,ChkManId=null where Code=@InId--,ChkTime=null           
          
        -- if @InOut='I08' or    @InOut='I09'     --2006-12-28     2007-1-1  取最新进价      
        -- exec fn_UpdateCost_UnChk  'wh_in',@InId                
        --  update wr_ware set cost  =isnull(Price ,0) where isnull(Price ,0) >0 and   id in (select wareid  From wh_indl where inid=@InId)               
         if @InOut='I08' or    @InOut='I09'               
            exec fn_UpdateCost 'wh_in',@InId   
                 
     commit                
     if @@error=0                
        return(1)                
     rollback                
     raiserror('事务提交失败,操作无效!',16,1)                
     return(0)                
   end              
            
          
    
----------------  
  