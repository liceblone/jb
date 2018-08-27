
alter PROCEDURE [dbo].[wh_in_chk0]                 
                 @InId varchar(20),                
                 @HandManId varchar(20)                
AS                
    
    
  ---����Ƿ��Ѿ��½�  
declare @fmonth smalldatetime    
declare @Msg    varchar(200)    
    
select @fmonth=   chktime from wh_in  where code= @InId    
    
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )    
begin    
   set @Msg='���е����������������'+char(13)+convert(varchar(4), year(@fmonth))  +'��'+  convert(varchar(4), month(@fmonth) ) +  '���Ѿ� [�½�]�� �����ٶԸõ��������� ��'     
   Raiserror( @Msg ,16,1)            
   return 0          
end    
    
    
--2006-7-28��˰��              
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20)                
 set @BillId=21                
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=1                
 if @@rowcount<>1                
   Raiserror('ϵͳ�Ҳ�������ⵥ,���ݿ����ѱ���������Աɾ����δ���,��[-ˢ��-]��֤!',16,1)                
 else                
   begin                
     begin tran                
       update wh_in set IsChk=0,ChkManId=null where Code=@InId--,ChkTime=null           
          
        -- if @InOut='I08' or    @InOut='I09'     --2006-12-28     2007-1-1  ȡ���½���      
        -- exec fn_UpdateCost_UnChk  'wh_in',@InId                
        --  update wr_ware set cost  =isnull(Price ,0) where isnull(Price ,0) >0 and   id in (select wareid  From wh_indl where inid=@InId)               
         if @InOut='I08' or    @InOut='I09'               
            exec fn_UpdateCost 'wh_in',@InId   
                 
     commit                
     if @@error=0                
        return(1)                
     rollback                
     raiserror('�����ύʧ��,������Ч!',16,1)                
     return(0)                
   end              
            
          
    
----------------  
  