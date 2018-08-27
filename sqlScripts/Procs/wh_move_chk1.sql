  
CREATE PROCEDURE [dbo].[wh_move_chk1]               
                 @MoveId varchar(20),              
                 @HandManId varchar(20)              
AS              
              
               
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@InWhId varchar(50),@OutWhId varchar(50)              
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InWhId=InWhId,@OutWhId=OutWhId from wh_move where Code=@MoveId and IsChk=0              
 if @@rowcount<>1              
   Raiserror('系统找不到该调拨单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)              
 else if @IsConfirm=1              
   Raiserror('已经[-确认-]过的调拨单,不能进行[-审核-]操作',16,1)              
 else              
 begin              
    --是否同个地方                  
    if @InWhId=@OutWhId              
    begin              
       Raiserror('调出点与调入点不能是同一个地方,审核失败  ',16,1)              
       Return 0              
    end              
    --库存量是否够              
    declare @WareId int,@Line int,@Qty decimal(15,2),@Stok decimal(15,2),@Msg varchar(100)              
    set @Line=0           
      
      
  declare @FBarCodeList varchar(1000), @FPackageBarcode varchar(50)       
  select @FBarCodeList=@FBarCodeList+ FBarCodeList+',' from wh_movedl where moveid = @Moveid      
         
  select @FPackageBarcode=f1 from  dbo.Fn_SplitStrBySeprator(@FBarCodeList,',')  as cd       
  where not exists (select * from TBarcode where FPackageBarcode =cd.f1)   and cd.f1<>''      
  if @FPackageBarcode<>''      
  begin      
  set @msg=@FPackageBarcode+'不存在.  '      
   Raiserror(@msg,16,1)              
   Return 0          
  end       
       
 --更新    
 begin try            
 begin tran              
    exec wh_move_vld_WhenChk        @MoveId , @HandManId   --加出入库表记录            
    update wh_move set IsChk=1,ChkManId=@HandManId,ChkTime=GetDate() where Code=@MoveId           
             
    update TBarcodeIO   set Fstatus ='movingout'  
    from   TBarcodeIO bio   
    join   tbarcodestorage  st on bio.fpackagebarcode =   st.fpackagebarcode  
    where exists(select FBillDLF_ID from wh_move m join wh_movedl dl on m.code =dl.moveid  
      where  dl.MoveId=@MoveId and dl.moveF_ID = bio.FBillDLF_Id   )      
          
 COMMIT                                                 
 END TRY                                
 BEGIN CATCH                                
    EXECUTE USP_GETERRORINFO;     -- EXECUTE ERROR RETRIEVAL ROUTINE.             
      RAISERROR('事务提交失败,操作无效!',16,1)                                                 
    ROLLBACK                                                                                   
    RETURN 0                                   
 END CATCH    ;              
            
    return 1   
end;              
          
          
