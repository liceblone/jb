采购询价

SP_Clt_ph_quote  --3699   688    只做修改


供应商报价
SP_Clt_ph_quote  --3700   688    只做修改


采购订单
GetLkpClient_IsUse --3701  349                   --  使用  4989       725   GetLkpClient_Bill
ClientId,ClientName,BillTo,ToFax    --采购订单
Code,Name,LinkMan,Fax


ClientId,ClientName,LinkMan,LinkTel,LinkFax,DeliverAddr,gatheringemp
Code,Name,LinkMan,Tel,Fax,Addr,gatheringemp

客户资料
Name
3
--Grid 725



供应商发货通知          --3702  349
GetLkpClient_IsUse
ClientId,ClientName,LinkMan,LinkTel
Code,Name,LinkMan,Tel



采购到货              --3704   349
GetLkpClient_IsUse
ClientId,ClientName
Code,Name

采购退货                --3714   349
GetLkpClient_IsUse  
ClientId,ClientName,BillTo,Fax
Code,Name,LinkMan,Fax




销售报价单              --3712   689   只做修改
SP_Clt_Sl_Quote


销售订单                 --3711   349
GetLkpClient_IsUse
Code,Name,LinkMan,Tel,Fax,Addr,gatheringemp
Code,Name,LinkMan,Tel,Fax,Addr,gatheringemp




发货单                    --3697  349
GetLkpClient_IsUse
ClientId,ClientName,LinkMan,LinkTel,LinkFax,DeliverAddr,gatheringemp

Code,Name,LinkMan,Tel,Fax,Addr,gatheringemp


销售退货单             --3713    349
GetLkpClient_IsUse
ClientId,ClientName,LinkMan,LinkTel,LinkFax,Address
Code,Name,LinkMan,Tel,Fax,Addr



入库单                      --4176    349
GetLkpClient_IsUse
--ClientId,ClientName
Code,Name



出库单                         --4123   349
GetLkpClient_IsUse
ClientId,ClientName
Code,Name




收款单                          --3697     349
GetLkpClient_IsUse
ClientId,ClientName,LinkMan,LinkTel,LinkFax,DeliverAddr,gatheringemp
Code,Name,LinkMan,Tel,Fax,Addr,gatheringemp


付款单                  -- 3982  349
GetLkpClient_IsUse
ClientId,ClientName,PayMan
Code,Name,LinkMan

应收单                   --4137  349
GetLkpClient_IsUse
ClientId,ClientName
Code,Name


应付单                  --4150  349
GetLkpClient_IsUse
ClientId,ClientName
Code,Name



客户转帐单            --        inname   4232  --349   outName 4233 349
GetLkpClient_IsUse    -- new   inname   4992    725       outname 4991  725


发货预录入
GetLkpClient_IsUse


客户余额表
GetLkpClient_IsUse


sp_helptext GetLkpClient_IsUse


alter  proc GetLkpClient_IsUse   
--查询数据用这个程序 09.07.12
                 @LoginId varchar(50)                  
                  
AS                  
          --'0021' 
--declare  @LoginId varchar(50)             
--set @LoginId ='0007'          
          
declare @IsAdmin bit,@EmpId varchar(20),@i int                  
set @IsAdmin=0                  
select @IsAdmin=IsAdmin,@EmpId=EmpId from sys_user where LoginId=@LoginId                  
  if isnull(@IsAdmin,0)=0                  
  begin               
   /*   */     
     select A.*  --,B.name as GatheringEmpName          
       from crm_client A  --left join  hr_employee B  on A.GatheringEmp=b.code                
      where (IsPub=1 or                
      A.code    in (select ClientId from   crm_clientemp where empid=@EmpId) or              
      A.code    in (select clientid from sl_empclient where empid=@EmpId) or                
      A.ClassID in (select ClassCode From  Crm_ActorClientClass where Actorid in  (select GroupID from  sys_groupuser  where UserID=@EmpId)   )                  
        )and classid <>'05'        
      order by A.code                          
       
    -- select A.*  from crm_client A      where Code in ( select Code  from dbo.Fn_GetValideClt (@EmpId)) and isUse=1           order by Code  
  end                
  else                  
     select  A.*,B.name as GatheringEmpName from crm_client   A           
             left  join hr_employee  B on A.GatheringEmp=b.code order by A.code                  
                  


GetLkpClient_Bill 'KEH'


create   proc GetLkpClient_Bill 
--查询数据用这个程序GetLkpClient_IsUse  09.07.12
--打单客户GetLkpClient_Bill   不含潜在客户  classid<>05 and isuse=1
                 @LoginId varchar(50)                  
                  
AS                  
          --'0021' 
--declare  @LoginId varchar(50)             
--set @LoginId ='0007'          
          
declare @IsAdmin bit,@EmpId varchar(20),@i int                  
set @IsAdmin=0                  
select @IsAdmin=IsAdmin,@EmpId=EmpId from sys_user where LoginId=@LoginId                  
  if isnull(@IsAdmin,0)=0                  
  begin               
   /*   */     
     select A.*  --,B.name as GatheringEmpName          
       from crm_client A  --left join  hr_employee B  on A.GatheringEmp=b.code                
      where (IsPub=1 or                
      A.code    in (select ClientId from   crm_clientemp where empid=@EmpId) or              
      A.code    in (select clientid from sl_empclient where empid=@EmpId) or                
      A.ClassID in (select ClassCode From  Crm_ActorClientClass where Actorid in  (select GroupID from  sys_groupuser  where UserID=@EmpId)   )                  
        )and classid <>'05'      and isUse=1  
      order by A.code                          
       
    -- select A.*  from crm_client A      where Code in ( select Code  from dbo.Fn_GetValideClt (@EmpId)) and isUse=1           order by Code  
  end                
  else                  
     select  A.*,B.name as GatheringEmpName from crm_client   A           
             left  join hr_employee  B on A.GatheringEmp=b.code  where A.isUse=1  order by A.code           





sp_helptext SP_Clt_Sl_Quote


sp_helptext Fn_GetValideClt

CREATE   function Fn_GetValideClt      
(@EmpId varchar(20) )      
 returns table       
as      
    -----所有客户，，，，  
return (      
      
select Code ,GatheringEmp,[Name]  from    crm_client A        
 where (     GatheringEmp=@EmpId          
         or  IsPub=1       
         or  A.code     in (select ClientId from   crm_clientemp where empid=@EmpId)       
         or  A.code     in (select clientid from sl_empclient where empid=@EmpId)       
         or  A.ClassID  in (select ClassCode From  Crm_ActorClientClass where Actorid in  (select GroupID from  sys_groupuser  where UserID=@EmpId)  )      
                       
         )  
     and classid <>'05' --     order by Code  
)      
  

sp_helptext GetLkpClient
CREATE       PROCEDURE [dbo].[GetLkpClient]               
                 @LoginId varchar(50)              
              
AS              
      
--declare  @LoginId varchar(50)         
--set @LoginId ='0007'      
      
declare @IsAdmin bit,@EmpId varchar(20),@i int              
set @IsAdmin=0              
select @IsAdmin=IsAdmin,@EmpId=EmpId from sys_user where LoginId=@LoginId              
  if @IsAdmin=0              
  begin           
   /*  
     select A.*  --,B.name as GatheringEmpName      
       from crm_client A  --left join  hr_employee B  on A.GatheringEmp=b.code            
      where (IsPub=1 or            
      A.code    in (select ClientId from   crm_clientemp where empid=@EmpId) or          
      A.code    in (select clientid from sl_empclient where empid=@EmpId) or            
      A.ClassID in (select ClassCode From  Crm_ActorClientClass where Actorid in  (select GroupID from  sys_groupuser  where UserID=@EmpId)   )              
        )and classid <>'05'    
      order by A.code                      
   */  
     select A.*  from crm_client A      where Code in ( select Code  from dbo.Fn_GetValideClt (@EmpId))  
  end            
  else              
     select A.*,B.name as GatheringEmpName from crm_client   A       
             left  join hr_employee  B on A.GatheringEmp=b.code order by A.code              
              
        




 alter Proc SP_Clt_Sl_Quote  
@LoginId varchar(50)  
as  
--09.07.12
--加入限制 不需要停用客户    报价要含 潜在客户  潜在供应商
begin  
  
drop table #TmpClient  
  
create table #TmpClient  
(Code  varchar(50),  
[Name]varchar(50),  
NickName varchar(50),  
ClassId varchar(50),  
FatherId varchar(50),  
RegionId varchar(50),  
TaxId varchar(50),  
LawMan varchar(50),  
Bank varchar(50),  
BankId varchar(50),  
LinkMan varchar(50),  
Tel varchar(50),  
Fax varchar(50),  
Addr varchar(200),  
Zip varchar(50),  
Mobile varchar(50),  
BeepPager varchar(50),  
Url varchar(50),  
Email varchar(200),  
Note varchar(50),  
Demand varchar(200),  
Products varchar(200),  
IsPub bit,  
Balance money,  
AddEmpId varchar(50),  
F_ID int,  
IsUse bit ,  
CreditLine decimal(19,3),  
mon_cls_entry  int,  
KeyWords  varchar(50),  
Cls_Entry_Months  int,  
GatheringEmp  varchar(50),  
OldNickName varchar(40)  
)       
    insert into #TmpClient   
exec  GetLkpClient @LoginId  
  
select *From #TmpClient   where isuse=1  
union all   
select *From crm_client    where isuse=1 and (classid='05' or classid='07')  and AddEmpId =@LoginId      
  
end  
  
  
  




insert into t505
select 
725,F23,F04,F05,F06,F07,F08,F09,
F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,
F20,F21,F22,F03,F24,F25,F26,F27
from t505 where f02=349

