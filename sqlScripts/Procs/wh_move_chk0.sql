      
 alter  PROCEDURE [dbo].[wh_move_chk0]         
                 @MoveId varchar(20),        
                 @HandManId varchar(20)        
AS        
        
         
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@InWhId varchar(50),@OutWhId varchar(50)        
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InWhId=InWhId,@OutWhId=OutWhId from wh_move where Code=@MoveId and IsChk=1        
 if @@rowcount<>1        
   Raiserror('系统找不到该调拨单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)        
 else if @IsConfirm=1        
   Raiserror('已经[-确认-]过的调拨单,不能进行[-审核-]操作',16,1)        
 else        
begin      
begin tran       
    exec wh_move_vld_WhenChk        @MoveId , @HandManId   --删除出入库表记录      
    update wh_move set IsChk=0,ChkManId=null,ChkTime=null where Code=@MoveId    
      
    update TBarcode set foutbillCode=null, FOutDLID=null , foutBillTypeID = null , FOutPackageBarCode = null , foutischk=null from TBarcode bar where bar.foutbillCode = @MoveId  
    delete  TBarcode      where   foutbillCode = @MoveId  and FpreviousFID is not null
    
    
commit        
end      
    
    