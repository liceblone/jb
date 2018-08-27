--  exec wh_move_vld 'WM00048848','000'
  
go

alter PROCEDURE [dbo].[wh_move_vld]       
				 @Abortstr varchar(300) output,
                 @MoveId varchar(20),      
                 @HandManId varchar(20)      
AS      
--2006-7-12 ���ĵ�������,���������Ȩ�ĳ��ܻ���    
												
 declare @IsChk bit,@IsConfirm bit,@IsClose bit,@InCode Varchar(20),@OutCode Varchar(20)     ,@rowCount int 
 
 set @Abortstr=''
 select @IsChk=IsChk,@IsConfirm=IsConfirm,@IsClose=IsClose,@InCode=WhInCode,@OutCode=WhOutCode from wh_move where Code=@MoveId      
 set @rowCount =@@rowcount
     
   
  if @rowCount<>1      
   Raiserror('ϵͳ�Ҳ����õ�����,���ݿ����ѱ���������Աɾ��,��[-ˢ��-]��֤!',16,1)      
-- else if @IsClose=1      
--   Raiserror('�Ѿ�[-�ر�-]�ĵ��������ܽ���[-ȷ��-]����',16,1)      
 else if @IsChk<>1      
   Raiserror('δ��[-���-]�ĵ��������ܽ���[-ȷ��-]����',16,1)      
--ȷ��      
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
		     select @Abortstr= '['+partNo+']  '+isnull('['+pack+']','')+isnull(+'['+Brand+']','')+'  ��治�㣡'
		     from wh_movedl where MoveID=@MoveId	 and wareid in ( select wareid from #InsurStg)
             return 0
         end
    end

  begin tran  
   /*    
    --����      
    exec sys_myid 320,@OutCode out      
    insert into wh_out(Code,OutTypeId,OutDate,WhId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)       
           select @OutCode,'X02',GetDate(),OutWhId,@HandManId,'��������ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from wh_move where Code=@MoveId      
    insert into wh_outdl(OutId,WareId,PartNo,Brand,Qty,Price)       
           select @OutCode,WareId,PartNo,Brand,Qty,Price from wh_movedl where MoveId=@MoveId order by dlId      
    --���      
    exec sys_myid 316,@InCode out      
    insert into wh_in(Code,InTypeId,InDate,WhId,HandManId,Note,BillManId,BillTime,IsChk,ChkManId,ChkTime)       
           select @InCode,'I02',GetDate(),InWhId,@HandManId,'�������ȷ�ϵ�','herling',GetDate(),1,@HandManId,GetDate() from wh_move where Code=@MoveId      
    insert into wh_indl(InId,WareId,PartNo,Brand,Qty,Price)       
           select @InCode,WareId,PartNo,Brand,Qty,Price from wh_movedl where MoveId=@MoveId order by dlId      
*/       
 --��־      
    update wh_in set IsChk=1 where code=@InCode    
    update wh_Out set IsChk=1 where code=@OutCode    
    update wh_move set IsConfirm=1 where Code=@MoveId      
  goto Acommit      
 end else      
--��ȷ��      
 begin      
   if Not Exists(select IsAdmin from sys_user where EmpId=@HandManId and IsAdmin=1)      
     Raiserror('ֻ�й���Ա����<��ȷ��>���ݵ�Ȩ��,�������Աѯ��.',16,1)      
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
 Raiserror('�����ύʧ�ܣ�������Ч',16,1)      
 Return 0      
      

go