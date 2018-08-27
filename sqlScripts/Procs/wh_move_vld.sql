--  exec wh_move_vld 'WM00048848','000'
  
go

alter PROCEDURE [dbo].[wh_move_vld]       
				 @Abortstr varchar(300) output,
                 @MoveId varchar(20),      
                 @HandManId varchar(20)      
AS      
--2006-7-12 更改调拨过程,调拨，审核权改成受货方    
												
 declare @IsChk bit,@IsConfirm bit,@IsClose bit,@InCode Varchar(20),@OutCode Varchar(20)     ,@rowCount int 
 
 set @Abortstr=''
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@IsClose=IsClose,@InCode=WhInCode,@OutCode=WhOutCode from wh_move where Code=@MoveId      
 set @rowCount =@@rowcount
     
   
  if @rowCount<>1      
   Raiserror('系统找不到该调拨单,数据可能已被其它操作员删除,请[-刷新-]验证!',16,1)      
-- else if @IsClose=1      
--   Raiserror('已经[-关闭-]的调拨单不能进行[-确认-]操作',16,1)      
 else if @IsChk<>1      
   Raiserror('未经[-审核-]的调拨单不能进行[-确认-]操作',16,1)      
--确认      
 else if @IsConfirm=0   
 begin  
     if exists (select * from jbhzuserdata.dbo.TParamsAndValues where Fparamcode ='020101' and FparamValue=1 )
     begin		 
   	    select distinct  wareid into #wr from wh_movedl where MoveID=@MoveId     
		   
        select d.WareId,d.qty   into #Stg             
        from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 where d.WareId in (select WareId from #wr)                        
        union all                        
        select d.WareId,-d.qty from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 where d.WareId in (select WareId from #wr)                        
        union all                        
        select WareId,Qty from wh_regulate where WareId in (select WareId from #wr) 
 					  		             	
         select A.*	  into #InsurStg
         from	( select wareid, sum(Qty) Qty from wh_movedl where MoveID=@MoveId	 group by wareid) A
         join   ( select wareid ,sum(Qty) Qty from #Stg group by wareid ) stg on A.wareid=stg.wareid
         where isnull(A.Qty,0)<isnull(Stg.Qty,0)
 
        if exists(select * from #InsurStg)
         begin
		     select @Abortstr= '['+partNo+']  '+isnull('['+pack+']','')+isnull(+'['+Brand+']','')+'  库存不足！'
		     from wh_movedl where MoveID=@MoveId	 and wareid in ( select wareid from #InsurStg)
             return 0
         end
    end

  begin tran  
   /*    
    --出库      
    exec sys_myid 320,@OutCode out      
    insert into wh_out(Code,OutTypeId,OutDate,WhId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)       
           select @OutCode,'X02',GetDate(),OutWhId,@HandManId,'调拨出库确认单','herling',GetDate(),1,@HandManId,GetDate() from wh_move where Code=@MoveId      
    insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)       
           select @OutCode,WareId,PartNo,Brand,Qty,Price from wh_movedl where MoveId=@MoveId order by dlId      
    --入库      
    exec sys_myid 316,@InCode out      
    insert into wh_in(Code,InTypeId,InDate,WhId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)       
           select @InCode,'I02',GetDate(),InWhId,@HandManId,'调拨入库确认单','herling',GetDate(),1,@HandManId,GetDate() from wh_move where Code=@MoveId      
    insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)       
           select @InCode,WareId,PartNo,Brand,Qty,Price from wh_movedl where MoveId=@MoveId order by dlId      
*/       
 --标志      
    update wh_in set IsChk=1 where code=@InCode    
    update wh_Out set IsChk=1 where code=@OutCode    
    update wh_move set IsConfirm=1 where Code=@MoveId      
  goto Acommit      
 end else      
--反确认      
 begin      
   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)      
     Raiserror('只有管理员才有<反确认>单据的权限,请向管理员询问.',16,1)      
   else      
   begin      
     begin tran      
/*    
       delete from wh_outdl where OutId=@OutCode      
       delete from wh_out where Code=@OutCode      
       delete from wh_indl where InId=@InCode      
       delete from wh_in where Code=@InCode      
*/     update wh_in set IsChk=0 where code=@InCode    
       update wh_Out set IsChk=0 where code=@OutCode    
       update wh_move set IsConfirm=0 where Code=@MoveId          
     goto Acommit      
   end      
 end      
      
ACommit:      
 Commit      
 if @@Error=0       
    Return 1      
 Rollback      
 Raiserror('事务提交失败，操作无效',16,1)      
 Return 0      
      

go