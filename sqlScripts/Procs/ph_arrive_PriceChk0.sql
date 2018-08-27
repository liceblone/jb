
alter    PROCEDURE [dbo].[ph_arrive_PriceChk0]                           
                 @ArriveId varchar(20),                          
                 @HandManId varchar(20)                          
AS                          
        
                
declare @fmonth smalldatetime              
declare @Msg    varchar(200)              
              
select @fmonth=   chktime from ph_arrive  where code= @ArriveId              
              
if exists(select *From TMonthEndClose where year(fmonth)= year(@fmonth) and month(fmonth)=month(@fmonth)  and isclosed=1  )              
begin              
   set @Msg='���е����������������'+char(13)+convert(varchar(4), year(@fmonth))  +'��'+  convert(varchar(4), month(@fmonth) ) +  '���Ѿ� [�½�]�� �����ٶԸõ��������� ��'               
   Raiserror( @Msg ,16,1)                      
   return 0                    
end              
              
--2006-7-25����˱�־��0����ϸ��³ɱ�����                          
 declare @IsChk bit,@IsConfirm bit,@ChkManId varchar(50),@DisCount Money,@InCode varchar(50),@BillId int                          
 set @BillId=9                          
 select @DisCount=WareFund-GetFund,@IsChk=IsChk,@IsConfirm=IsConfirm,@ChkManId=ChkManId,@InCode=WhInCode from ph_arrive where Code=@ArriveId and IsChk=1                          
 if @@rowcount<>1                          
   Raiserror('ϵͳ�Ҳ����õ�����,���ݿ����ѱ���������Աɾ�������,��[-ˢ��-]��֤!',16,1)                          
 else begin                          
     begin tran                         
     /* 2014-4-18      
       delete from wh_indl where InId=@InCode                          
       delete from wh_in where Code=@InCode         
       */                       
       update ph_arrive set IsConfirm=0, IsChk=0,ChkManId=null where Code=@ArriveId  --,ChkTime=null                          
                          
       --���µ���                          
       update wr_ware set Price=IsNull((select top 1 d.Price/(1+ isnull(m.TaxRate,0)) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.ischk =1 and m.WhInCode is Not null and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc),0)             
                        where Id in (select WareId from ph_arrivedl where ArriveId=@ArriveId)                          
                
       -- update wr_ware set cost=IsNull((select top 1 (d.Price-d.Price*m.TaxRate) from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code and m.WhInCode is Not null and d.WareId=wr_ware.Id order by m.ArriveDate Desc,d.dlId desc),0)               
       -- where Id in (select WareId from ph_arrivedl where ArriveId=@ArriveId)                                  
       --2006-12-28 ���³ɱ�  ����˱�־��1���ٸ��³ɱ���   2007-1-1 ����֮�� �����²ɹ������ɱ���                     
       --update wr_ware set cost  =isnull(Price ,0) where isnull(Price ,0) >0 and id in (select  wareid  from ph_arrivedl where arriveid=@ArriveId)                         
        exec fn_UpdateCost 'ph_arrive',@ArriveId    --����˱�־��1���ٸ��³ɱ���          
                
     commit                          
     if @@error=0                           
       Return 1                          
     else                          
       Rollback                          
     Return 0                          
 end 
 
 
 go
 