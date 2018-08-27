  
alter proc PR_WhMoveBarCodeConfirmList         
@WhinID   varchar(30),                   
@WhOutID  varchar(30),                           
@BeginDate  smalldatetime,                  
@EndDate  smalldatetime,                  
@Partno   varchar(30),                  
@Pack   varchar(30),                  
@Brand   varchar(30),                  
@FBarCodeList varchar(200)                  
as    
--declare @WhinID varchar(30)           
-- set @WhinID ='02'          
           
   select        
 case when m.IsChk=1 then '√' else '' end isChk  ,      case when m.IsConfirm=1 then '√' else '' end isConfirm            
,m.movedate    ,m.ChkTime, m.code  ,inwh.Name as inWh , m.OutWhId,OutWh.Name as OutWh                    
,BAR.FBarCodeQty ,BAR.FPackageBarcode                
,case when ISNULL( bar.fstatus ,'')<>'out' then '' else '√' end FIsBarCodeConfirmed         
,wr.PartNo,wr.Brand,wr.Pack,wr.Origin      
into #tmp        
from wh_move m        
join wh_movedl dl on m.code =dl.MoveId   and   m.MoveDate   >'2016-1-1'      
join TBarcodeIO BAR  on   dl.moveF_ID=bar.FBillDLF_ID        
join wr_ware wr on bar.Wareid =wr.id        
left join wh_warehouse inwh on m.InWhId = inwh.Code        
left join wh_warehouse outwh on m.OutWhId = outwh.Code        
where m.IsChk=1  ---  and isnull(m.IsConfirm,0)=0 -- and m.Code='wm00080871'      
and isnull(bar.IsMoveConfirmed, 0) = 0       
and m.inWhId like @WhinID        
and isnull(wr.partno,'') like @Partno                  
and isnull(wr.pack  ,'') like @Pack                 
and isnull(wr.brand ,'') like @Brand     
    
select * from #tmp m where  m.MoveDate>=@BeginDate and m.MoveDate<=@endDate+1      
drop table #tmp   


go
					-- exec PR_WhMoveConfirm 'WM00083164','2116081136606501'
    
alter proc PR_WhMoveConfirm                
@FBillCode     varchar(30)  ,        
@FBarCodeList  varchar(200)           
as              
/*            
declare @WhinID varchar(30),              
@WhOutID varchar(30),              
@BeginDate smalldatetime,              
@EndDate smalldatetime,              
@Partno varchar(30),              
@Pack varchar(30),              
@Brand   varchar(30),              
@FBarCodeList  varchar(200)              
            
set @FBarCodeList='223,23,23,2,32,3'            
            
select * from dbo.Fn_SplitStrBySeprator(@FBarCodeList, ',')            
      
           
*/        
        
            
BEGIN TRY                                
BEGIN TRAN               
 declare @InWhid varchar(30), @outWhid varchar(30)        
         
  select  @InWhid= InWhid, @outWhid= OutWhId from wh_move where code=@FBillCode        
      
          
   update TBarcodeIO   set Fstatus ='movingout' ,IsMoveConfirmed=1 
    from   TBarcodeIO bio   
    join   tbarcodestorage  st on bio.fpackagebarcode =   st.fpackagebarcode  
     JOIN  DBO.FN_SPLITSTRBYSEPRATOR(@FBARCODELIST, ',') AS BARLIST ON st.FPACKAGEBARCODE=BARLIST.F1   and bio.FPACKAGEBARCODE=BARLIST.F1       
    where exists(select FBillDLF_ID from wh_move m join wh_movedl dl on m.code =dl.moveid  
      where  dl.MoveId=@FBillCode and dl.moveF_ID = bio.FBillDLF_Id   )   
        
   UPDATE TBarcodeStorage            
   SET  whid= @inwhid  
   FROM TBarcodeStorage  BAR            
   JOIN  DBO.FN_SPLITSTRBYSEPRATOR(@FBARCODELIST, ',') AS BARLIST ON BAR.FPACKAGEBARCODE=BARLIST.F1             
                
          
  --  update wh_move    set IsConfirm =1            
  select m.Code   
   into #code          
  from wh_move m              
  join wh_movedl dl on m.Code = dl.MoveId     and dl.MoveId=@FBillCode                 
  where isnull(m.IsConfirm, 0) =0 and ISNULL(m.IsChk, 0)=1            
  and  not exists(  select* from  TBarcodeIO bar where   isnull(bar.isMoveConfirmed ,0)=0 and bar.Fbillcode = @FBillCode )         
           
  update wh_move set IsConfirm =1 ,confirmTime=GETDATE() where code in (select Code from #code)            
  update wh_in   set IsChk=1      from wh_in i  join wh_move mv on i.Code = mv.WhInCode     where mv.code in (select Code from #code)            
  update wh_Out  set IsChk=1      from wh_Out o join wh_move mv on o.Code = mv.WhoutCode     where mv.code in (select Code from #code)           
               
COMMIT                                                 
END TRY                                
BEGIN CATCH                                
   EXECUTE USP_GETERRORINFO;     -- EXECUTE ERROR RETRIEVAL ROUTINE.             
           RAISERROR('事务提交失败,操作无效!',16,1)                                                 
   ROLLBACK                                                                                   
   RETURN 0                                   
END CATCH    ;              
            
return 1            

go

sp_helptext wh_move_vld 
declare @p1 varchar(300)
set @p1=''
exec wh_move_vld @p1 output,'WM00083144','000'
select @p1
				 exec PR_WhMoveConfirm 'WM00083144','2116080636605401'
      
go

alter PROCEDURE [dbo].[wh_move_vld]               
     @Abortstr varchar(300) output,        
     @MoveId varchar(20),              
     @HandManId varchar(20)              
AS              
--2006-7-12 更改调拨过程,调拨，审核权改成受货方            
                    
 declare @IsChk bit,@IsConfirm bit,@IsClose bit,@InCode Varchar(20),@OutCode Varchar(20)  ,@OutWhid varchar(30)   ,@rowCount int ,@FMonth smalldatetime  
   
  select @FMonth= max(fMonth) from TMonthEndClose  where isClosed=1        
         
 set @Abortstr=''        
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@IsClose=IsClose,@InCode=WhInCode,@OutCode=WhOutCode ,@OutWhid=OutWhid from wh_move where Code=@MoveId              
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
        from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 where d.WareId in (select WareId from #wr) and m.WhId=@OutWhid                               
        union all                                
        select d.WareId,-d.qty from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 where d.WareId in (select WareId from #wr) and m.WhId=@OutWhid      
        union all                                
        select WareId,Qty from wh_regulate where WareId in (select WareId from #wr)   and WhId=@OutWhid      
                                
         select A.*   into #InsurStg        
         from ( select wareid, sum(Qty) Qty from wh_movedl where MoveID=@MoveId  group by wareid) A        
         join   ( select wareid ,sum(Qty) Qty from #Stg group by wareid ) stg on A.wareid=stg.wareid        
         where isnull(A.Qty,0)>isnull(Stg.Qty,0)        
         
        if exists(select * from #InsurStg)        
         begin        
       select @Abortstr= '['+partNo+']  '+isnull('['+pack+']','')+isnull(+'['+Brand+']','')+'  库存不足！'        
       from wh_movedl where MoveID=@MoveId  and wareid in ( select wareid from #InsurStg)        
             return 0        
         end        
    end        
        
         
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
   BEGIN TRY                                
   BEGIN TRAN         
    --标志              
      update wh_in  set IsChk=1 ,ChkTime =GETDATE()  where code=@InCode            
      update wh_Out set IsChk=1 ,ChkTime =GETDATE()where code=@OutCode            
      update wh_move set IsConfirm=1, confirmTime =GETDATE() where Code=@MoveId		 
           
   COMMIT                                                 
   END TRY                                
   BEGIN CATCH                                
         EXECUTE USP_GETERRORINFO;     -- EXECUTE ERROR RETRIEVAL ROUTINE.             
           RAISERROR('事务提交失败,操作无效!',16,1)                                                 
         ROLLBACK                                                                                   
         RETURN 0                                   
    END CATCH                      
 end else              
--反确认              
 begin     
   if exists( select * from wh_move where ChkTime< dateadd(m,1,@FMonth) and Code=@MoveId    )  
   begin  
      Raiserror('已经月节不能修改数据',16,1)         
      return 0       
   end      
   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)              
      Raiserror('只有管理员才有<反确认>单据的权限,请向管理员询问.',16,1)              
   else              
   begin              
        BEGIN TRY                                
           BEGIN TRAN             
             
           update wh_in set IsChk=0 ,ChkTime =null where code=@InCode            
           update wh_Out set IsChk=0 ,ChkTime =null where code=@OutCode            
           update wh_move set IsConfirm=0 , confirmTime =null where Code=@MoveId    
       
           update TBarcodeIO   set Fstatus =case when FIOType ='G' then 'IN' else 'movingout' end	,IsMoveConfirmed =0
           from   TBarcodeIO bio   join	wh_move mv on bio.FbillCode =   mv.code	  where	mv.code=@MoveId
        
           UPDATE TBarcodeStorage	SET  whid = @OutWhid	   --select	 BAR.whid,	mv.outwhid 
			from   TBarcodeIO bio   
			join   tbarcodestorage  st on bio.fpackagebarcode =   st.fpackagebarcode  
			join   wh_movedl		dl on  dl.moveF_ID = bio.FBillDLF_Id  and dl.MoveId=@MoveId  
				
          COMMIT                                                 
       END TRY                                
       BEGIN CATCH                                
       EXECUTE USP_GETERRORINFO;     -- EXECUTE ERROR RETRIEVAL ROUTINE.             
               RAISERROR('事务提交失败,操作无效!',16,1)                                                 
               ROLLBACK                                                                                   
               RETURN 0                                   
       END CATCH            
   end              
 end              
              
return 1    
				    
              
             

						    
 
  
  
  go						 
    
alter PROCEDURE [dbo].[wh_move_chk1]               
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
             
    update TBarcodeIO   set Fstatus ='movingout',  FIOType ='MV'	,FbillTypeid=21, fbillcode =@MoveId, fdlid= dl.dlid
                            ,FbarCode =st.FbarCode,FpackageQty =st.FpackageQty,whid = st.whid
    from   TBarcodeIO bio   
    join   tbarcodestorage  st on bio.fpackagebarcode =   st.fpackagebarcode  
    join   wh_movedl		dl on  dl.moveF_ID = bio.FBillDLF_Id  and dl.MoveId=@MoveId  
				
				-- select FbarCode,* from tbarcodestorage				   
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
          
          	    
            
go

       
 alter  PROCEDURE [dbo].[wh_move_chk0]                 
                 @MoveId varchar(20),                
                 @HandManId varchar(20)                
AS                
                
                 
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@InWhId varchar(50),@OutWhId varchar(50) ,@PhArriveCode varchar(20)   ,@msg varchar(200)            
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InWhId=InWhId,@OutWhId=OutWhId ,@PhArriveCode= PhArriveCode from wh_move where Code=@MoveId and IsChk=1                
 if @@rowcount<>1       
 begin             
   Raiserror('系统找不到该调拨单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)    
   return 0        
 end    
 if @IsConfirm=1      
 begin              
   Raiserror('已经[-确认-]过的调拨单,不能进行[-审核-]操作',16,1)         
   return 0           
 end    
if exists(select *   from   TBarcodeIO bio     
     where exists(select FBillDLF_ID from wh_move m join wh_movedl dl on m.code =dl.moveid    
       where  dl.MoveId=@MoveId and dl.moveF_ID = bio.FBillDLF_ID  ) and fstatus='movingout' and isnull(isMoveConfirmed,0)=1 )    
begin    
  Raiserror('条码已经被确认，不能弃审',16,1)         
  return 0    
end         
if ISNULL(@PhArriveCode,'')<>''  
begin  
 set @msg='请对采购入库单:'+@PhArriveCode+'进行数量弃审'  
 Raiserror(@msg ,16,1)         
  return 0    
end    
begin try     
 begin tran               
    exec wh_move_vld_WhenChk        @MoveId , @HandManId   --删除出入库表记录              
    update wh_move set IsChk=0,ChkManId=null,ChkTime=null where Code=@MoveId            
              
					
    update TBarcodeIO   set Fstatus ='movingunchk'    
    from   TBarcodeIO bio        
    join   tbarcodestorage  st on bio.fpackagebarcode =   st.fpackagebarcode  
    join   wh_movedl		dl on  dl.moveF_ID = bio.FBillDLF_Id  and dl.MoveId=@MoveId 
    where bio.FIOTYPE='MV'    
    
    if exists(select * from  TBarcodeIO where FbillCOde = @MoveId and FIOType='G')
    begin
		 delete TBarcodeIO  where FbillCOde = @MoveId
		 delete tbarcodestorage  where FbillCOde = @MoveId
    end
COMMIT                                                   
END TRY                                  
BEGIN CATCH                                  
   EXECUTE USP_GETERRORINFO;     -- EXECUTE ERROR RETRIEVAL ROUTINE.               
     RAISERROR('事务提交失败,操作无效!',16,1)                                                   
   ROLLBACK                                                                                     
   RETURN 0                                     
END CATCH    ;                
          
return 1                
            
            
go
alter table TBarcodeStorage add FStatus varchar(3)
alter table TBarcodeIO add IsMoveConfirmed bit

go
		  
     alter PROCEDURE [dbo].[sl_invoice_out]               
                 @abortstr varchar(200) output,                            
                 @WhId varchar(20),                              
                 @InvoiceId varchar(20),                              
                 @HandManId varchar(20),                              
                 @OutCode varchar(20) output                              
AS                        
set @abortstr=''                  
declare @IsClose bit                              
set @IsClose=0                              
/*                              
if (select ChkTime from sl_invoice where Code=@InvoiceId) is null and GetDate()<(select xDate from fn_date where Id=1)                              
begin                              
  Raiserror('服务器日期与会计日期有出入,该单据目前不能审核,请检查日期或咨询会计!',16,1)                               
  return 0                              
end                              
*/                              
                      
    declare @GatheringEmp varchar(30)  , @ClientId varchar(30)         ,@isTax bit                  
    select  @GatheringEmp = GatheringEmp , @ClientId =ClientId    ,@isTax  =   isTax from sl_invoice              where code =@InvoiceId                      
                      
    declare @PartNo varchar(50),@msg varchar(200)                          
                              
       --2016-2-27                      
  if exists( select istax from sl_order ord join sl_orderdl orddl on ord.code = orddl.orderid    
    where orddl.f_ID  in ( select slorderid from sl_invoicedl where invoiceid=@InvoiceId )    
    and ord.isTax <>@IsTax    
    )    
  begin    
    set @msg= ' 含税标志错误 ,审核失败!'                          
           Raiserror(@msg,16,1)     
      return 0        
  end    
      /* */      
    if  exists( select * from sl_order ord join sl_orderdl orddl on ord.Code =orddl.OrderId  
   where orddl.f_id in (  select SLOrderID from sl_invoicedl where InvoiceId=@InvoiceId)  
   and ord.ClientId <>@ClientID )  -- 'HZ003719'  -- @ClientID  
    begin  
         Raiserror('客户选择与订单不匹配.',16,1)        
         return 0  
    end         
            
    select @PartNo =PartNo  From wr_ware where isnull(cost,0)=0 and  id in (select wareid         from sl_invoicedl             where InvoiceId=@InvoiceId)                          
    if isnull(@PartNo ,'')<>''                          
    begin                          
           set @msg=isnull(@PartNo,'') +' 成本价 为0,出库失败!'                          
           Raiserror(@msg,16,1)                                   
           return 0                                
    end                          
                      
                      
    if Not exists(select 1 from sl_invoicedl where InvoiceId=@InvoiceId and Not ((SndQty is null) or SndQty=0))                              
    begin                              
       Raiserror('出库失败,原因是: 没有提供任何补货数量.',16,1)                              
       return 0                              
    end                              
                
    if exists (select * from sl_invoicedl  where InvoiceId=@InvoiceId and IsNull(SndQty,0)>0                 
                     and IsNull(SndQty,0)>Isnull((select sum(d.qty) from wh_in m                 
                                                            inner join wh_indl d  on m.Code=d.InId and m.IsChk=1                 
                                                                and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)                
                                         -Isnull((select sum(d.qty) from wh_out m                 
                                                            inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1                 
                                                                and m.WhId=@WhId and d.WareId=sl_invoicedl.WareId),0)                
                                           +Isnull((select sum(Qty) from wh_regulate where WhId=@WhId and WareId=sl_invoicedl.WareId),0))                            
     begin                              
         Raiserror('出库失败,原因是: 部份存货的库存数量不够出库,请查证.',16,1)                              
         return 0                              
     end                              
                
begin tran            
      exec sys_myid 320,@OutCode out                              
      insert into wh_out(LnkBlCd,Code,OutTypeId,OutDate,WhId,ClientId,ClientName,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)                               
           select @InvoiceId,@OutCode,'X01',GetDate(),WhId,ClientId,ClientName,@HandManId,'销售发货出库单',@HandManId,GetDate(),1,@HandManId,GetDate() from sl_invoice where Code=@InvoiceId                              
      insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)                               
           select @OutCode,WareId,PartNo,Brand,SndQty,Price from sl_invoicedl where InvoiceId=@InvoiceId and Not ((SndQty is null) or SndQty=0) order by dlId                  
                
      update sl_invoicedl set SndQty=null,RmnQty=Qty-IsNull((select sum(w.Qty) from wh_outdl w where w.WareId=sl_invoicedl.WareId and w.OutId in (select Code from wh_out where LnkBlCd=@InvoiceId)),0) where InvoiceId=@InvoiceId                             
 
      if not exists(select 1 from sl_invoicedl where InvoiceId=@InvoiceId and RmnQty<>0)                               
         set @IsClose=1                              
      update sl_invoice set IsClose=@IsClose where Code=@InvoiceId                              
      --sl_invoice.isclose not used                  
                                    
      if exists(select *from sl_invoicedl  where InvoiceId=@InvoiceId and isnull(RmnQty,0)<>0  )            
      begin            
         rollback            
         set @abortstr='版本5.0.2.5之后不能做补货'                        
         return 0               
      end            
            
      if exists (select 1 from sl_invoice where IsChk=0 and Code=@InvoiceId)                              
      begin                              
        update sl_invoice set IsOnce=@IsClose,IsChk=1,ChkManId=@HandManId,ChkTime=dbo.Fn_IsMonthClose (ChkTime)   ,IsConfirm=1 where Code=@InvoiceId                              
        update sl_invoicedl set bhNote='欠'+cast(RmnQty as varchar(10))+'psc' where InvoiceId=@InvoiceId and RmnQty<>0                              
        update wh_out set IsFirst=1 where Code=@OutCode                              
      end                              
                
      update sl_invoicedl                         
      set Cost=isnull( (select isnull(Cost,price) from wr_ware where Id=WareId and (Cost>0 or price>0) ),0) where InvoiceId=@InvoiceId and isnull(Cost,0)=0        
                         
                        
      update sl_invoice set TaxRate=(select MoneyX from sys_parameters where Id=6) where Code=@InvoiceId and IsTax=1 and TaxRate=0                              
      declare @TaxRate money                              
      select @TaxRate=(select TaxRate from sl_invoice where Code=@InvoiceId)                              
      --update sl_invoice set Profit=(select sum(Qty*(Price-Cost-Price*@TaxRate)) from sl_invoicedl where InvoiceId=Code)-(WareFund-GetFund) where Code=@InvoiceId                              
      update sl_invoice set Profit=(select sum(Qty*(Price-Cost)) from sl_invoicedl where InvoiceId=Code)  -(WareFund-GetFund) where Code=@InvoiceId                              
                              
                            
      update  crm_client set GatheringEmp=  @GatheringEmp where code=@ClientId and isnull(GatheringEmp,'')=''                          
                
      update sl_orderdl set deliveryQty= Ship.Qty      
       from sl_orderdl sldl       
       join (select SUM(convert(decimal(19,0), case when iv.IsChk=1 then Qty else 0 end)) as Qty,SLOrderID       
       from sl_invoicedl ivdl  join sl_invoice iv on ivdl.InvoiceId = iv.Code where    InvoiceId =@InvoiceId      
       group by SLOrderID      
       ) Ship on sldl.f_id = Ship.SLOrderID      
                
        update TBarcodeStorage set Fstatus = 'OUT'
       from   TBarcodeStorage st 
       join TBarcodeIO i  on  st.fpackageBarCode   =i.fpackageBarCode
       join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
       join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
       where	 sldl.invoiceid= @InvoiceId         
commit tran            
                
  return 1            
            
            
            
            go
    
alter PROCEDURE [dbo].[sl_invoice_chk0]             
                 @InvoiceId varchar(20),            
                 @HandManId varchar(20),            
                 @LoginId varchar(20)            
AS            
            
declare @fmonth smalldatetime    
declare @Msg    varchar(200)    
    
select @fmonth=   chktime from sl_invoice  where code= @InvoiceId    
    
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
begin    
   set @Msg=convert(varchar(4), year(@fmonth))  +'年'+  convert(varchar(4), month(@fmonth) ) +  '月已经 月结， 不能再对该单进行弃审 ！'     
   Raiserror( @Msg ,16,1)            
   return 0          
end    
		    
if exists(select *from sl_invoicedl  where InvoiceID= @InvoiceId and isnull(FpID,'')<>'' )          
begin         
 Raiserror('这单的明细已经开完发票不能再弃审',16,1)            
 return 0           
end          
      
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@PayFund Money,@BillId varchar(20),@BankId varchar(20),@PayeeId varchar(20),@WhId varchar(20)            
 set @BillId=19            
 select @WhId=WhId,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@DisCount=WareFund-GetFund,@PayFund=PayFund,@BankId=BankId,@PayeeId=PayeeId from sl_invoice where Code=@InvoiceId and IsChk=1            
            
      
        
 if @@rowcount<>1            
   Raiserror('系统找不到该发货单,单据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)            
 else            
   begin            
     begin tran            
       delete from wh_outdl where OutId in (select code from wh_out where LnkBlCd=@InvoiceId)            
       delete from wh_out where LnkBlCd=@InvoiceId            
       update sl_invoice set IsConfirm=0,IsClose=0,IsChk=0,ChkManId=null where Code=@InvoiceId--,ChkTime=null                
       update sl_invoicedl set bhNote='',RmnQty=null,RmnFund=null,ClsDate=null where InvoiceId=@InvoiceId    
         
       update sl_orderdl set deliveryQty= Ship.Qty  
       from sl_orderdl sldl   
       join (select SUM(convert(decimal(19,0), case when iv.IsChk=1 then Qty else 0 end)) as Qty,SLOrderID   
       from sl_invoicedl ivdl  join sl_invoice iv on ivdl.InvoiceId = iv.Code where    InvoiceId =@InvoiceId  
       group by SLOrderID  
       ) Ship on sldl.f_id = Ship.SLOrderID    
       
       update TBarcodeStorage set Fstatus = ''
       from   TBarcodeStorage st 
       join TBarcodeIO i  on  st.fpackageBarCode   =i.fpackageBarCode
       join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
       join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
       where	 sldl.invoiceid= @InvoiceId
             
     Commit              
     select WareId,PartNo,Brand,Qty,RmnQty,SndQty,0 as myStok from sl_invoicedl where 1=2            
   end            
            
            
  if @@error=0             
     Return 1            
  else            
  begin            
     Rollback            
     Raiserror('事务提交失败,操作无效',16,1)            
  end            
  Return 0          
          
------------    
      
      
go

        
alter proc Pr_BarCodeWarehouse          
@BeginDate smalldatetime,          
@EndDate   smalldatetime, 
@Whid varchar(10)  ,      
@FPackageBarCode varchar(30),      
       
@FBillCode varchar(30),      
        
@Model  varchar(20)='%',        
@PartNo varchar(20)='%',        
@Pack   varchar(20)='%',        
@Brand  varchar(20)='%'        
as          
          
--select * from wh_warehouse          
select bar.*, wh.Name as WhName          
,wr.PartNo,wr.Model,wr.Brand,wr.Pack,wr.Origin,wr.RsSurfix          
--, case when bar.FOutisChk=1 then 'clred' else 'clblue'end fntclr        
--,ivitem.ClientName, ivitem.ClientId, ivitem.InvoiceDate, ivitem.InvoiceId  ,ivitem.MoveId        
 from tbarcodestorage bar join wh_warehouse wh on bar.whid= wh.Code          
join wr_ware wr on bar.Wareid =wr.id          
 where     isnull( bar.Fstatus ,'')=''    
--and bar.CreateTime>=@BeginDate and bar.CreateTime<=@EndDate +1
  and bar.FPackageBarcode like @FPackageBarCode+'%'          
and bar.FBarCode like @FBillCode  +'%'        and bar.whid like @Whid            
order by bar.whid ,FBarCode,CreateTime desc     
  
  go
go




 alter proc PR_GeneratorBarCode                          
@FBillCode varchar(30),      
@FPackageBarCode varchar(50)=''        
as                          
/*       
       
declare @FBillCode varchar(30)                           
set @FBillCode='WM00080918'   */                         
                 
  
                          
declare @BarCntPerPackage int  ,@sql varchar(500), @PackageNumLen int ,  @i int    ,@FWareid varchar(30)                      
select @BarCntPerPackage= FParamValue from TParamsAndValues where FParamCode='02020201'                          
select @PackageNumLen =   FParamValue from TParamsAndValues where FParamCode='02020203'                          
set @i=0                        

create table #tmp    (FBillCode varchar(50),FWareid varchar(50) ,FRowNum int,FBarCodeQty int ,FLastPrintTime smalldatetime)  -- ,FBarCode varchar(50),FDescription varchar(50)                        

 insert into #tmp(FBillCode ,FWareid,FBarCodeQty  )                          
 select bar.FBillCode,bar.Wareid ,bar.Qty     from TBarcodeIO  bar join wr_ware wr on bar.Wareid=wr.Id where FBillCode =@FBillCode                         
                         
              
                     
            --  select *from TBarcodeIO           
               
update TBarcodeIO set FBillTypeid= REPLACE(space(2-LEN(sysid.F_ID)),' ','0')+convert(varchar(20),sysid.F_ID)              
from TBarcodeIO bar join sys_id sysid on LEFT( bar.FBillCode,2)= sysid.pre  where FBillCode =@FBillCode --'PA00029528'              
              
update TBarcodeIO   set FBarCode =FBillTypeid+ CONVERT(varchar(6), GETDATE(), 12)+REPLACE(space(6-LEN(FDlid)),' ','0')+convert(varchar(20),FDlid ) , FIOType ='G' ,FStatus='IN'         
where FBillCode =  @FBillCode --'PA00029528'      
                       
 																								              
declare @FQtyItems varchar(300), @Cnt int , @FBarCodeQty decimal(19,0)         
update #tmp set FRowNum =null                    
select @FWareid=FWareid from #tmp  where FRowNum is null                    
while (exists(select * from #tmp where FWareid=@FWareid and FRowNum is null))                    
begin                    
     print @Fwareid                    
     set @i=0                       
     update #tmp       set FRowNum = @i , @i=@i+1   where FWareid=@FWareid                    
     set @i=0                      
     update TBarcodeIO   set FRowNum = @i , @i=@i+1 where FBillCode =@FBillCode   and Wareid=@FWareid               
     set @i=1                      
     select @FQtyItems =case when isnull(FQtyitems,'')='' then  convert(varchar(50),Qty) else Fqtyitems end  from  TBarcodeIO  where FBillCode =@FBillCode   and Wareid=@FWareid               
     select @Cnt = COUNT(*) from dbo.Fn_SplitStrBySeprator(@FQtyItems,'+')              
     while(@i<=@Cnt)              
     begin      
       select @FBarCodeQty = f1 from  dbo.Fn_SplitStrBySeprator(@FQtyItems,'+') where frow =@i              
       update TBarcodeIO   set  FBarCodeQty=@FBarCodeQty, FPackageNumLen=@PackageNumLen       
          where FBillCode =@FBillCode   and Wareid=@FWareid and FRowNum =@i              
              
       set @i=@i+1              
     end       
                           
     select @FWareid=FWareid from #tmp where FRowNum is null                     
end                    
      --  select *from #tmp  declare @sql varchar(500) ,@BarCntPerPackage int ,@FBillCode varchar(30)  set @BarCntPerPackage=2  set @FBillCode='PA00028256'                    
--if not exists( select *from TBarcodeIO where Fstatus='IN'  and  FBillCode= @FBillCode  ) 
       update TBarcodeIO   set FPackageBarCode =FBarCode+replace(space(FPackageNumLen-len(FRowNum)),' ','0')+convert(varchar(3),FRowNum)     where FBillCode =  @FBillCode --'PA00029528'   
  
set @sql =''                         
while (@BarCntPerPackage>0)                          
begin                          
 set @sql ='alter table #tmp add  FBarCode' +CONVERT(varchar(20),@BarCntPerPackage)+' varchar(50)'                        
 print @sql                        
 exec(@sql)                        
  set @sql ='alter table #tmp add  FDescription' +CONVERT(varchar(20),@BarCntPerPackage)+' varchar(50)'                        
 print @sql                        
 exec(@sql)                        
                        
 -- set @sql= 'update tmp set FBarCode'+CONVERT(varchar(20),@BarCntPerPackage)+'=right( bar.FPackageBarcode ,len(bar.FPackageBarcode)-1) '  --+'' ''+ISNULL(wr.brand,'''')                        
 set @sql= 'update tmp set FBarCode'+CONVERT(varchar(20),@BarCntPerPackage)+'= bar.FPackageBarcode  '                        
 set @sql=@sql+ ',FDescription'+CONVERT(varchar(20),@BarCntPerPackage)+'= wr.PartNo+'' ''+ISNULL(wr.Pack,'''') +'',''+convert(varchar(10),convert(decimal(19,0),FPackageQty)) '                        
 --select bar.FBillCode,bar.Wareid,bar.FBarCode, wr.PartNo+' '+ISNULL(wr.Pack,'') as FDescription                           
 set @sql=@sql+ '  from TBarcodeIO  bar join wr_ware wr on bar.Wareid=wr.Id  join #tmp tmp on tmp.fbillcode=bar.FBillCode '                      
 set @sql=@sql+ '  and tmp.fwareid=wr.Id and tmp.fwareid=bar.Wareid and bar.FRowNum =tmp.frownum where bar.FBillCode ='''+@FBillCode +''''                        
 print @sql                        
 exec(@sql)                         
                          
 set @BarCntPerPackage=@BarCntPerPackage-1                          
end                          
                          
     
if @FPackageBarCode<>''      
 select * from #tmp where Fbarcode1=@FPackageBarCode      
else      
 select * from #tmp  order by fbarcode1  ,FBarCodeQty desc                    
                          
                        
 drop table #tmp     
   



go


create proc Pr_QueryBarcodeIO
@FBeginDate		smalldatetime,
@FEndDate		smalldatetime,
@FPackageBarCode varchar(30), 
@FBillCode       varchar(30)  

as

select * from TBarcodeIO
where createTime >= @FBeginDate
and   createTime <= @FEndDate+1
and   FPackageBarCode like @FPackageBarCode 
and   FBillCode       like @FBillCode


go


     
       
          
alter PROCEDURE [dbo].Pr_WhOutImport                                              
                 @partNo varchar(50),                                                     
                 @Model varchar(50),                              
                 @Brand varchar(50),                              
                 @Pack  varchar(50),                                                    
                 @WhId varchar(20) ,                              
                 @SourceType varchar(20)  =''                               
                ,@Code   varchar(20) =''                          
                ,@FBarCodeList varchar(5000)=''                                              
AS                                                    
          --2009.07.12 只显示未被停用的规格                                
/*      Partno,Model,Brand,Pack,WhId,SourceType,Code                                  
exec Pr_WhOutImport '90',NULL,NULL,NULL,'008','发货单',NULL    
  
-- exec Pr_WhOutImport '%','%','%','%','01%','库存信息%','%','2116061935498601,2116061935498601'  
   go                   
                            
declare  @partNo varchar(50),   @Model varchar(50),   @Brand varchar(50),  @Pack  varchar(50) , @WhId varchar(20) , @SourceType varchar(20)  ,@Code   varchar(20),@FBarCodeList varchar(5000)                      
                      
set @partNo='%'                      
set @Model ='%'                      
set @Brand='%'                      
set @Pack='%'                      
set @WhId='01%'                      
set @SourceType='库存信息%'                      
set @Code='%'                      
set @FBarCodeList='2116061935498601,2116061935498601'                    
         */  
                     
set  @SourceType=  replace(@SourceType,'%','')                                                 
                                                 
-- remove invalid barcode                       
select   bar.FBarcodeQty as Qty,bar.FPackageBarcode, bar.wareid                      
into #TBarCodelList                      
from TBarcodeStorage bar join (select distinct f1 from dbo.Fn_SplitStrBySeprator ( @FBarCodeList  ,',' )) Spliter                           
        on bar.fpackageBarcode= spliter.f1  where bar.whid like @WhId                
                         
                             
create table #TInvBarCodeList (wareid varchar(30),qty  int,FPackageBarcode varchar(1000),FBillDLF_ID varchar(50) default newid() )                      
                      
declare @Wareid varchar(30),@FPackageBarcode varchar(1000)                      
select @Wareid =wareid from #TBarCodelList                      
while exists(select * from #TBarCodelList)                      
begin                      
   set @FPackageBarcode=''                      
   select @FPackageBarcode=@FPackageBarcode+FPackageBarcode+',' from #TBarCodelList where Wareid =@Wareid                      
   insert into #TInvBarCodeList (wareid ,qty  ,FPackageBarcode )select wareid ,SUM(qty),@FPackageBarcode from #TBarCodelList where Wareid =@Wareid group by Wareid                      
   delete #TBarCodelList where Wareid =@Wareid                      
   select @Wareid =wareid from #TBarCodelList                      
end                      
                      
select  m.Code,m.ClientId,m.ClientName,                  
    m.ArriveDate,dl.WareId , dl.Qty,dl.f_ID ,dl.FQtyItems                 
    into #PhDL                  
    from ph_arrive m join ph_arrivedl dl on m.Code =dl.ArriveId                   
    where   m.ArriveDate >GETDATE()-30                   
                      
--select *from  ph_arrivedl   #TInvBarCodeList                      
-- drop table #TBarCodelList                      
-- drop table #TInvBarCodeList                      
                      
select distinct  avbar.Qty as FBarCodeQty, IsNull(w.PriceRate,c.PriceRate) as myRate,w.*   into #wr                                
from wr_ware w  left  join wr_class c on w.ClassId=c.Code   
join (select distinct wareid, SUM(Qty) Qty from #TInvBarCodeList    group by Wareid) as AvBar on w.id= AvBar.Wareid                        
union all                           
select  null, IsNull(w.PriceRate,c.PriceRate) as myRate,w.*         
      from wr_ware w                                 
inner join wr_class c on w.ClassId=c.Code                                 
where w.isUse=1 and @FBarCodeList=''   and isnull(w.partno,'') like  isnull(@partno,'')+'%'                               
and isnull(w.Model,'')  like  isnull(@Model,'')+'%'                               
and isnull(w.Brand,'') like  isnull(@Brand,'')+'%'                               
and isnull(w.Pack,'') like  isnull(@Pack,'')+'%'                         
                         
                                                
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                                      
union all                                                    
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') and d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02') and d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                                                    
union all                                                    
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                                                    
union all                                                    
select '',WhId,WareId,Qty,1 from wh_regulate where WareId in (select Id from #wr)                                                    
                                             
                                          
   -- select * from sl_invoicedl                              
                                        
if replace(@SourceType,'%','')='发货单'                              
begin                          
  select top 30 d.f_id  ,w.id as Wareid                  
     ,w.id,w.PartNo,w.Brand,isnull(w.cost,0) as cost,w.Pack,w.origin                            
     ,IsNull((select sum(Qty) from #tmp where WareId=w.Id),0) as alStok                                    
     ,IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok                              
     , w.Price*w.myRate as Fund                                     
     , m.code, m.invoicedate ,  ISNULL( w.FBarCodeQty ,d.qty) as qty     ,m.ClientName                    
     ,isnull(invBar.FBillDLF_ID,d.f_id) as FBillDLF_ID               
     ,null as FQtyItems                       
  from sl_invoice m                               
  inner join sl_invoicedl d on m.Code=d.InvoiceId                               
  inner join #wr          w on w.id=d.wareid                    
  left join #TInvBarCodeList invBar on invBar.wareid = w.Id and invBar.wareid =d.WareId                           
  where  m.ischk=0                                                    
  and m.Code like isnull(@Code ,'')+'%'                     
  order by m.BillTime desc, w.ClassId, w.Model                 
end                              
else                      
begin                       
  if @SourceType ='采购到货单'                    
     select top 30 ph.f_id  ,w.id as Wareid                 
     ,w.id,w.PartNo,w.Brand,isnull(w.cost,0) as cost,w.Pack,w.origin                            
     ,IsNull((select sum(Qty) from #tmp where WareId=w.Id),0) as alStok                                          
     ,IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok                              
     , w.Price*w.myRate as Fund                                     
     , ph.code, ph.ArriveDate  as invoicedate, ph.qty  ,ph.ClientName                     
     , ph.f_id  as FBillDLF_ID  ,     FQtyItems                      
     from #PhDL ph                               
     inner join #wr          w on w.id=ph.wareid                     
     order by  ph.ArriveDate desc,ph.Code,w.ClassId, w.Model                    
   
  else                  
  select TOp 50  null as F_ID, w.id as wareid              
        ,w.id,w.PartNo,w.Brand,isnull(w.cost,0) as cost,w.Pack,w.origin               
        ,IsNull((select sum(Qty) from #tmp where WareId=w.Id),0) as alStok                      
        ,IsNull((select sum(Qty) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok                      
        ,w.Price*w.myRate as Fund       , ISNULL( w.FBarCodeQty ,0) as qty                       
     ,isnull(invBar.FBillDLF_ID,newid()) as FBillDLF_ID   ,null as  FQtyItems                               
     ,case when w.isdel=1 then 'clred'       else 'clblack' end as fntclr                                                   
  from #wr w                       
  left join #TInvBarCodeList invBar on invBar.wareid = w.Id                      
  order by w.ClassId, w.Model                     
end                      
              
               
                      
-- clear resource                      
drop table #wr                                                    
drop table #tmp                       
drop table #TBarCodelList                      
drop table #TInvBarCodeList                  
drop table #PhDL   
  
    
  
go


  create index idx_wh_movedlMoveF_ID	 on	 wh_movedl(MoveF_ID)
      
  create index idx_wh_movedlinvoicedlF_ID on	 wh_movedl(invoicedlF_ID)
 
  create index idx_sl_invoicedlF_ID on	 sl_invoicedl(F_ID)
