ALTER               PROCEDURE [dbo].[fn_client_fund_Gathering]                                       
                 @ClassId     varchar(50),                                      
                 @EndDate     datetime,                                   
                 @DateType    varchar(20)='�Ƶ�ʱ��'   ,                                  
                 @loginID     varchar(20)      ,                            
                 @CltType     Varchar(20) ='���ͻ�'      ,  
        
                 @F_EmpCode   varchar(20)     ,       --@CurrentUserF_EmpCode  
                 @CurrentUserLoginID varchar(20)      --@CurrentUserLoginID       
                                          
AS                                      
     
/*   
  
declare          @ClassId varchar(50),                                      
                 @EndDate datetime,                                   
                 @DateType varchar(20)   ,                                  
                 @loginID  varchar(20)      ,                            
                 @CltType Varchar(20)  ,               
                 @F_EmpCode Varchar(20)      ,      
@CurrentUserLoginID Varchar(20)            
set @ClassId =''        
set  @EndDate =getdate()        
set @DateType ='�Ƶ�ʱ��'           
set @loginID  ='0001'        
set @CltType ='���ͻ�'        
set @F_EmpCode=''        
set @CurrentUserLoginID='0005'      
-- select isuse,gatheringemp, *From crm_Client          
   */        
         
        create table #TmpGatheringEmp  
(code varchar(50))  
  
  
if isnull(@F_EmpCode,'')=''  
begin  
      insert into #TmpGatheringEmp  
      select M.Code        
      from hr_employee M        
      join hr_employee Dn on M.Boss =Dn.code      
      where M.Boss =  (select empid from sys_user where loginid=@CurrentUserLoginID )   --����  
   union all  
      select M.Code        
      from hr_employee M        
      where M.Code =  (select empid from sys_user where loginid=@CurrentUserLoginID )  --�Լ�  
end  
else  
begin  
	/*
	      insert into #TmpGatheringEmp  
	      select M.Code        
	      from hr_employee M  where code=@F_EmpCode or name=@F_EmpCode   --�Լ�  
	  union all  
	      select M.Code        
	      from hr_employee M        
	      join hr_employee Dn on M.Boss =Dn.code      
	      where M.Boss =  (select empid from sys_user where loginid=@CurrentUserLoginID )  --����  

exec Pr_GetSubordinate '0001'
	  
	   */

	insert into #TmpGatheringEmp  
	exec Pr_GetSubordinate @F_EmpCode
end  
    
  
  
     
    
    
set @EndDate=@EndDate+1                                
                                
select c.*,0.00 as MIncrease,0.00 as MSubtract                                
  into #Tmp                                
    from crm_Client c                                
      where name=@ClassId or OldNickName like '%'+@ClassId+'%' or NickName like '%'+@ClassId+'%' or Tel like '%'+@ClassId+'%'                                
                                
--select * from crm_Client              
--select * from crm_clientclass                       
--if @CltType='' or @CltType='ȫ��'                      
--select * into crm_Clientbackup20061229  From hzjb03a.dbo.crm_Client where classid <>'01'                      
                      
if @CltType='���ͻ�'--01                      
delete #Tmp where classid <>'01'                      
                      
if @CltType='����Ӧ��'--02                      
delete #Tmp where classid <>'02'                      
                      
if @CltType='����ͻ�'--06                      
delete #Tmp where classid <>'06'                      
                      
if @CltType='ͬ��'--03  ,04                      
delete #Tmp where classid <>'03' and classid <>'04'                      
                            
                   
declare @Empid varchar(20)                   
                  
select @Empid =Empid  from sys_user where LoginId=@LoginId                  
      
                            
select * into #c from #tmp                            
where  gatheringemp in   (select code from #TmpGatheringEmp)         --���пͻ�  Fn_GetValideClt     --Fn_GetValideCltAccount ȥ�������տ�      
 order by code desc           
        
        
        
drop table #TmpGatheringEmp        
drop table #tmp                            
                            
                            
select ClientId,GetFund as xFund,InvoiceDate,IsChk,ChkTime ,billtime into #f from sl_invoice where ClientId in (select Code from #c)                                
union all                                
select ClientId,-PayFund,InvoiceDate,FnIsChk,FnChkTime ,billtime from sl_invoice where ClientId in (select Code from #c)                                
union all                                
select m.ClientId,-d.RmnQty*d.Price,d.ClsDate,1,d.ClsDate ,billtime from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1 and d.ClsDate is not null and ClientId in (select Code from #c)                                
union all                                
select ClientId,-GetFund,ReturnDate,IsChk,ChkTime,billtime from sl_return where ClientId in (select Code from #c)                                
union all                                
select ClientId,-GetFund,ArriveDate,IsChk,ChkTime ,billtime from ph_arrive where ClientId in (select Code from #c)                                
union all                                
select ClientId,GetFund,ReturnDate,IsChk,ChkTime,billtime  from ph_return where ClientId in (select Code from #c)                           
union all                                
select ClientId,PayFund,PaymentDate,IsChk,ChkTime ,billtime from fn_payment where ClientId in (select Code from #c) --and ItemId not in ('0160000','0170000')                                
union all                                
select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from fn_receiver where ClientId in (select Code from #c)-- and ItemId not in ('0160000','0170000')  2006-12-29�ָ��ɶ����                              
union all                                
select ClientId,PayFund,InDate,IsChk,ChkTime,billtime  from fn_shldin where ClientId in (select Code from #c)                                 
union all                                
select ClientId,-PayFund,OutDate,IsChk,ChkTime,billtime  from fn_shldout where ClientId in (select Code from #c)                                 
union all                                
select InId,PayFund,TrnsfrDate,IsChk,ChkTime,billtime from fn_clntransfer where InId in (select Code from #c)                                 
union all                                
select OutId,-PayFund,TrnsfrDate,IsChk,ChkTime,billtime  from fn_clntransfer where OutId in (select Code from #c)                                 
union all                                
select ClientId,WareFund,OutDate,IsChk,ChkTime,billtime  from wh_out where ClientId in (select Code from #c) and (OutTypeId='X08' or OutTypeId='X09')                                 
union all                                
select ClientId,-WareFund,InDate,IsChk,ChkTime,billtime  from wh_in where ClientId in (select Code from #c) and (InTypeId='I08' or InTypeId='I09')                                 
union all                                
select Code,Balance,null,1,null,null from crm_client where Code in (select Code from #c)                                
                                
if @DateType='����'                                 
  delete from #f where InvoiceDate>=@EndDate                                
if @DateType='���ʱ��'                                  
  delete from #f where ChkTime>=@EndDate                                
if @DateType='�Ƶ�ʱ��'                                  
  delete from #f where billtime >=@EndDate                                
                              
                                
select *,(select sum(xFund) from #f where ClientId=Code and IsChk=1) as ChkFund,(select sum(xFund) from #f where ClientId=Code) as rpRemain into # from #c     order by    ChkFund  desc    ,rpRemain desc                     
                                
select (select name from hr_employee where code =w.gatheringEmp)  as GatheringEmpName ,  
        gatheringEmp, Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,Url,Email,Note,Demand,Products,IsPub,Balance,AddEmpId,MIncrease,MSubtract,isnull(ChkFund,0)ChkFund,isnull(rpRemain ,0)  rpRemain           
  from #  as W                              
union all                                
select null,null,null,'�ϼ�',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,sum(ChkFund),sum(rpRemain) from #                                
           
  
     
drop table #                                
drop table #c                                
drop table #f                              
  
   
                              
       
    
