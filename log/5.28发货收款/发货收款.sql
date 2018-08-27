alter   proc Sp_Sum_Sl_invoice_RecOpn        
@Type    varchar(20)='',        
@ClientId varchar(20)='',      
@Clttype  varchar(20)='',      
@RegionId  varchar(20)='',    
@FatherID varchar(20)='',    
@GatheringEmp varchar(20)=''     
     
as        
  
--stra,clientid,classid,regionid,fatherid,F_EMpCode  
  
-- Sp_Sum_Sl_invoice_RecOpn '','','','','',''  
/*  
declare @Type    varchar(20),        
@ClientId varchar(20),      
@RegionId  varchar(20),    
@FatherID varchar(20),    
@GatheringEmp varchar(20) ,    
@Clttype  varchar(20)     
set @Type   =''    
set @ClientId =''    
set @RegionId =''    
set @FatherID =''    
set @GatheringEmp =''    
set @Clttype=''    
  */    
select code  --,RegionId,FatherID,GatheringEmp     
  into #c     
from  crm_client     
where code         like isnull(@ClientId,'')+'%'    
and   isnull( RegionId,'')     like isnull(@RegionId,'')+'%'    
and   isnull( FatherID,'')     like isnull(@FatherID,'')+'%'    
and   isnull( RegionId,'')     like isnull(@RegionId,'')+'%'    
and   isnull( GatheringEmp,'') like isnull(@GatheringEmp,'')+'%'    
and   isnull( ClassID ,'')      like isnull(@Clttype,'')+'%'    
    
--select *From crm_client    
    
create table #fitem
(    
clientid varchar(20),    
Balance  decimal(19,5),    
fDate    smalldatetime,    
ischk    bit,    
Chktime  smalldatetime,    
Billtime smalldatetime    
)    
    
DECLARE @enddate smalldatetime    
set     @enddate=getdate()    
insert into #fitem exec sl_invoice_rec_bal @ClientId , @RegionId ,@FatherID ,@GatheringEmp ,@enddate    
    

create table #f 
(    
clientid varchar(20),    
Balance  decimal(19,5)   
)    
     
insert into #f
select clientid,sum(isnull(Balance,0)) as Balance  From #fitem  where ischk=1  group by clientid

drop table #fitem

--drop table #f
 
--select * From #f where clientid='hz000513'and  ischk=1 

--select * From #fitem where clientid='hz000513' and  ischk=1 
 

 -- drop table #Sl    
    
create table #Sl    
(    
ClientID varchar(20),    
xFund decimal(19,5),    
Chktime smalldatetime,    
Amt     decimal(19,5),   
GatheringDate smalldatetime,   
Note    varchar(200)    
)    
    
insert into #Sl(ClientID,xFund ,Chktime,GatheringDate)    
select ClientId, (GetFund) as xFund, convert(varchar(10),ChkTime ,121 ) as  ChkTime ,convert(varchar(10),GatheringData ,121 )  as GatheringDate    
     
       from [sl_invoice]     
       where ClientId in (select Code from #c) and ischk=1     
union all      
select ClientId, (PayFund),   convert(varchar(10),ChkTime ,121 ) as  ChkTime      , convert(varchar(10),ChkTime ,121 )  
       from [fn_shldin]    
        where ClientId in (select Code from #c)  and ischk=1               
    
union all        
select InId,PayFund,  convert(varchar(10),ChkTime ,121 ) as  ChkTime  ,convert(varchar(10),ChkTime ,121 ) as  ChkTime  
         from [fn_clntransfer]     
         where InId in (select Code from #c)  and IsChk=1     order by  ClientId      ,ChkTime desc                                  
     
     
    
    
    
--     update #Sl set Amt=0,Note=''    
-- select *  from #f sl_invoice #f where clientid='HZ000002'    
    
          
--declare @clientid varchar(20)  
  
declare @Balance decimal(19,5)     
  set @Balance=0  
declare p cursor for      
           select   clientid ,Balance from #f where Balance<>0 
       open p      
       fetch next from p into @clientid ,@Balance    
       while @@FETCH_STATUS = 0      
       begin      
            print  @Balance    
            update #Sl set Amt=@Balance,@Balance=@Balance-xfund,Note=@Balance where clientid=@clientid      
    
         fetch next from p into  @clientid ,@Balance    
       end      
       close p      
       deallocate p      
     
    
    
-- select *From #sl   order by ClientID     
     
     
  select ClientID,-min(abs(amt))as amt     
into #SLtmp    
  From #sl where amt<=0   group by  ClientID    order by ClientID    
--select *from #SLtmp    
    
select A.*     
,(select count(*) from #sl where   chktime>=A.chktime and clientid=b.clientid)as cnt    
  into #fnl     
From #sl A join #SLtmp B On a.clientid=b.clientid and A.amt= b.amt order by A.ClientID    
    
    
--select *From #fnl    
--select *From #sl   order by ClientID     
    
select A.*,datediff(d,B.GatheringDate,getdate())as MaxDay,b.cnt as BillCount ,    
clt.name ,clt.code,clt.linkMan,clt.tel,clt.fax,A.balance as rpRemain,emp.name as GatheringEmpName    
     
 into #Tshow  
From #f  A    
left join #fnl  B on A.clientid=b.clientid     
left join crm_client clt on a.clientid=clt.code  and a.clientid=clt.code  
left join hr_employee  emp  on emp.code =clt.gatheringEMp    
where A.balance>0    
order by  cnt,A.clientid    
    
    
 if   @Type='µ½ÆÚ'  
select *From #Tshow where MaxDay>=0 order by  MaxDay desc  
else  
select *From #Tshow where MaxDay<0 order by MaxDay desc  
--select *From crm_client      
     
    
drop table #Tshow  
drop table #fnl    
drop table #SLtmp    
drop table #Sl    
drop table #c    
drop table #f    
    
  
