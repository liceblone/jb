
alter  proc SP_LargessQuery            
@ClientID varchar(50),@begindate smalldatetime,@enddate smalldatetime,@storageid varchar(10)      ,
@InOutType varchar(20)  ,    
    
@classid  varchar(50),@partno varchar(50),@brand varchar(50),@pack varchar(50)    
as            
begin            
--select * from wh_out t1             
--select * from crm_Client            
 /*        
declare @ClientID varchar(50),@begindate smalldatetime,@enddate smalldatetime,@storageid varchar(10)         ,@InOutType varchar(20)  ,    
    
@classid  varchar(50),@partno varchar(50),@brand varchar(50),@pack varchar(50)    
   
set @ClientID=''          
set @begindate='2008-9-1'          
set @enddate='2008-9-10'          
set  @storageid='01'          
set @classid  =''    
set @partno =''    
set @brand =''    
set @pack=''    
    
      
select top 1 * from wh_outdl     
select top 1 * from wh_out     
select top 1 *from wr_ware     
*/        
  
select       
' ' as billid,' ' as billcode,' ' as Code,' ' as OutTypeId, WhId,xdate as OutDate,' ' as HandManId,' ' as BillManId,' ' as BillTime,' ' as ChkManId,  
' ' as ChkTime,' ' as Note,' ' as ClientId,' ' as Validate,' ' as IsChk,' ' as IsDepose,' ' as IsClose,null as WareFund,' ' as LnkBlCd,' ' as ClientName,  
' ' as IsFirst,' ' as IsInvoice,' ' as IsOutBill,' ' as name,  wareid,  partno, brand, ' ' as  pack,  qty,null as price,null as amt ,  
case when qty<0 then 'x99' else 'i99' end as outtypeidEX into #regulate  
  
from wh_regulate where @InOutType in ('x99','i99')    
and  wareid in (select wareid from wr_ware where classid  like isnull(@classid,'')+'%')    
and  partno like isnull(@partno,'')+'%'    
and  brand  like isnull(@brand,'')+'%'    
 and  whid like isnull(@storageid  ,'')+'%'    
 and ( xdate>=@begindate and  xdate<=@enddate )   
  
select *   into #TPresentOut   
       from #regulate    
 union all   
select 22 as billid,t1.code as billcode ,
t1.Code,t1.OutTypeId,t1.WhId,t1.OutDate,t1.HandManId,
t1.BillManId,t1.BillTime,t1.ChkManId,t1.ChkTime,t1.Note,t1.ClientId,
t1.Validate,t1.IsChk,t1.IsDepose,t1.IsClose,t1.WareFund,t1.LnkBlCd,
t1.ClientName,t1.IsFirst,t1.IsInvoice,t1.IsOutBill,
t3.name               ,DL.wareid,    dl.partno,dl.brand,dl.pack,dl.qty,dl.price,dl.qty*dl.price as amt ,' '     
from  wh_out    t1        
 join  wh_outdl  DL  on   t1.code=dl.outid      
join  wh_warehouse t3 on t1.whid=t3.code            
where t1.outtypeid like isnull(@InOutType,'')+'%'  and t1.clientid  like '%'+@ClientID+'%'            
and (t1.Billtime>=@begindate and t1.Billtime<=@enddate )            
and t1.whid =@storageid          
and dl.wareid in (select wareid from wr_ware where classid  like isnull(@classid,'')+'%')    
and dl.partno like isnull(@partno,'')+'%'    
and dl.brand  like isnull(@brand,'')+'%'    
and dl.pack   like isnull(@pack,'')+'%'    
  
  
-- select top 1 * from wh_regulate --where WareId in (select Id from #wr)     
     
          
--select  'null as '+name+',' ,*From syscolumns where id=object_id('TT') order by colid  
      
  
  
select * from #TPresentOut          
union all          
select           
null,null,null,null,null,null,null,null,null,null,null,null          
,null,null,null,null,null,sum(warefund),null,null,null,null,null,null,null,    null,null,null,null,null,null    ,null  
from #TPresentOut            
          
          
          
drop table #regulate  
drop table #TPresentOut          
end            