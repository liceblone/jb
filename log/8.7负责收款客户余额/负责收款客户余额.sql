ALTER               PROCEDURE [dbo].[fn_client_fund_Gathering]                                       
                 @ClassId     varchar(50),                                      
                 @EndDate     datetime,                                   
                 @DateType    varchar(20)='制单时间'   ,                                  
                 @loginID     varchar(20)      ,                            
                 @CltType     Varchar(20) ='纯客户'      ,  
        
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
set @DateType ='制单时间'           
set @loginID  ='0001'        
set @CltType ='纯客户'        
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
      where M.Boss =  (select empid from sys_user where loginid=@CurrentUserLoginID )   --手下  
   union all  
      select M.Code        
      from hr_employee M        
      where M.Code =  (select empid from sys_user where loginid=@CurrentUserLoginID )  --自己  
end  
else  
begin  
	/*
	      insert into #TmpGatheringEmp  
	      select M.Code        
	      from hr_employee M  where code=@F_EmpCode or name=@F_EmpCode   --自己  
	  union all  
	      select M.Code        
	      from hr_employee M        
	      join hr_employee Dn on M.Boss =Dn.code      
	      where M.Boss =  (select empid from sys_user where loginid=@CurrentUserLoginID )  --手下  

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
--if @CltType='' or @CltType='全部'                      
--select * into crm_Clientbackup20061229  From hzjb03a.dbo.crm_Client where classid <>'01'                      
                      
if @CltType='纯客户'--01                      
delete #Tmp where classid <>'01'                      
                      
if @CltType='纯供应商'--02                      
delete #Tmp where classid <>'02'                      
                      
if @CltType='特殊客户'--06                      
delete #Tmp where classid <>'06'                      
                      
if @CltType='同行'--03  ,04                      
delete #Tmp where classid <>'03' and classid <>'04'                      
                            
                   
declare @Empid varchar(20)                   
                  
select @Empid =Empid  from sys_user where LoginId=@LoginId                  
      
                            
select * into #c from #tmp                            
where  gatheringemp in   (select code from #TmpGatheringEmp)         --所有客户  Fn_GetValideClt     --Fn_GetValideCltAccount 去掉负责收款      
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
select ClientId,-PayFund,ReceiverDate,IsChk,ChkTime,billtime  from fn_receiver where ClientId in (select Code from #c)-- and ItemId not in ('0160000','0170000')  2006-12-29恢复股东借款                              
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
                                
if @DateType='日期'                                 
  delete from #f where InvoiceDate>=@EndDate                                
if @DateType='审核时间'                                  
  delete from #f where ChkTime>=@EndDate                                
if @DateType='制单时间'                                  
  delete from #f where billtime >=@EndDate                                
                              
                                
select *,(select sum(xFund) from #f where ClientId=Code and IsChk=1) as ChkFund,(select sum(xFund) from #f where ClientId=Code) as rpRemain into # from #c     order by    ChkFund  desc    ,rpRemain desc                     
                                
select (select name from hr_employee where code =w.gatheringEmp)  as GatheringEmpName ,  
        gatheringEmp, Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,Url,Email,Note,Demand,Products,IsPub,Balance,AddEmpId,MIncrease,MSubtract,isnull(ChkFund,0)ChkFund,isnull(rpRemain ,0)  rpRemain           
  from #  as W                              
union all                                
select null,null,null,'合计',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,sum(ChkFund),sum(rpRemain) from #                                
           
  
     
drop table #                                
drop table #c                                
drop table #f                              
  
   
                              
       
    
