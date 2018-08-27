drop PROCEDURE [dbo].[wh_StokDifferViewer]                 
go
CREATE         PROCEDURE [dbo].[wh_StokDifferViewer]                 
    @BeginTime smalldatetime,                                    
    @EndTime smalldatetime ,                                     
    @StorageID varchar(20),                                      
    @Model varchar(100)  ,                                      
    @UseWhichDate varchar(150),  -- 实际库存，可用库存             
    @classid varchar(20)   ,
    @PartNo varchar(20)
as                                                               
                              
            
       /*                               
declare  @BeginTime smalldatetime                                                              
declare  @EndTime smalldatetime                                                               
declare  @StorageID varchar(20)                                                                
declare  @Model varchar(100)                                                               
declare  @UseWhichDate varchar(150)                                                              
declare  @classId varchar(100)                                                              
declare  @partNo varchar(100)                                                              
                                                            
set @BeginTime='2009-10-6'                                                              
set @EndTime='2010-1-10'                                                           
set @StorageID='01' --仓库号                                                              
set @Model='电感'  --型号                                                              
set @UseWhichDate='日期'                                                              
set @classId=''                                                            
set @partNo=''   --规格                                                         
                                                             
                                                           
-- select *From wr_Ware where id=42369             
            
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.*                                                               
from wr_ware w                                                               
inner join wr_class c on w.ClassId=c.Code  -- where id =37341                                    
--where id=42369            
            
 where  w.Model  like '%'+isnull('RT14 1/4W','')+'%'            
 or     w.PartNo like '%'+isnull('RT14 1/4W','')+'%'                
            
               
*/                                                            
                       
                     
set @EndTime=dateadd(day,1,@EndTime)                
                                 
--drop table   #wr                                                    
select IsNull(w.PriceRate,c.PriceRate) as myRate,w.*                                                               
into #wr                                                               
from wr_ware w                                                               
inner join wr_class c on w.ClassId=c.Code  -- where id =37341                                    
--where id=42369            
            
 where  w.Model  like '%'+isnull(@Model,'')+'%'            
 and    w.PartNo like '%'+isnull(@PartNo,'')+'%'                                                               
 and w.ClassId  like IsNull(@ClassId,'')+'%'                                                               
order by w.PartNo,w.Brand,w.Pack                                                                
                                                              
  -- select *from #wr    --     where model='ccxx'                        
                              
--drop table #AllTmp                            
                                                 
 select  --top 1                             
 9 as BillId,'采购到货入库' as billtype,m.Code,m.WhId,d.WareId,                            
 d.Qty as OriQty,d.Qty as StkInQty,0 as StkOutQty ,                            
 m.IsChk,m.billTime,m.ChkTime  ,  m.ArriveDate as xDate                                                         
 into #AllTmp                                                               
 from ph_arrive m            --采购到货入库                            
 inner join ph_arrivedl d on m.Code=d.ArriveId                                                               
 where d.WareId in (select Id from #wr)  and WhId=@StorageID                                                              
                            
                                                                          
 union all                 
                            
 select --top 1                             
 13 as BillId,'采购退货出库' as Billtype,m.Code,m.WhId,d.WareId,-d.Qty as OriQty , 0 as StkInQty,d.Qty as StkOutQty ,  m.IsChk ,                                                    
 m.billTime,m.ChkTime   ,m.ReturnDate                                                    
 from ph_return m                       --采购退货出库                                        
 inner join ph_returndl d on m.Code=d.ReturnId                                                               
 where d.WareId in (select Id from #wr)    and WhId=@StorageID                                                                 
                                                                          
 union all                                 
                          
               
select  --top 1                             
 19 as BillId,'销售发货未审' as Billtype,m.Code, WhId,d.WareId,-d.Qty as OriQty ,0 as StkInQty,d.Qty as StkOutQty, m.IsChk ,                              
 m.billTime,m.ChkTime  ,    m.InvoiceDate                            
 from sl_invoice m  --'销售发货未审 '                            
 inner join sl_invoicedl d on m.Code=d.InvoiceId                             
 where isnull(m.IsChk,0)<>1 and d.WareId in (select Id from #wr)    and WhId=@StorageID                                    
                                    
/*                                                                
 select 3 as type,m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0) as OriQty  ,0 as StkInQty , d.Qty-IsNull(d.RmnQty,0) as StkOutQty ,m.IsChk ,                                                    
m.billTime,m.ChkTime  ,m.InvoiceDate                                                  
  from sl_invoice m                                                               
  inner join sl_invoicedl d on m.Code=d.InvoiceId                                                               
  where d.WareId in (select Id from #wr)      and WhId=@StorageID                                                                                 
*/                                                
                                   
 union all                                        
select --top 1                            
 19 as BillId ,'销售发货出库' as Billtype,m.LnkBlCd as Code, WhId,d.WareId,-d.Qty as OriQty ,0 as StkInQty,d.Qty as StkOutQty, m.IsChk ,                              
-- m.billTime,          
(select  billTime from  sl_invoice   where Code=m.LnkBlCd) as billTime ,          
(select  ChkTime  from  sl_invoice   where Code=m.LnkBlCd) as ChkTime ,       
(select  InvoiceDate from  sl_invoice   where Code=m.LnkBlCd) as InvoiceDate        
--m.ChkTime  ,    m.OutDate         
      
--select top 1 *From sl_invoice      
                         
 from wh_out m                             
 inner join wh_outdl d on m.Code=d.OutId --销售发货出库                            
 where m.LnkBlCd<>'' and d.WareId in (select Id from #wr) and WhId=@StorageID and IsFirst=1                                      
                            
union all                            
                            
select --top 1                             
  19 as BillId ,'销售补货出库' as Billtype ,m.LnkBlCd as Code, WhId,d.WareId,-d.Qty as OriQty ,0 as StkInQty,d.Qty as StkOutQty, m.IsChk ,                              
 m.billTime,m.ChkTime  ,    m.OutDate                             
 from wh_out m                             
 inner join wh_outdl d on m.Code=d.OutId --销售补货出库                            
 where m.LnkBlCd<>''and d.WareId in (select Id from #wr)and m.WhId=@StorageID and m.LnkBlCd<>'' and IsFirst=0                           
                                
                            
                            
 union all                                                               
 select  --top 1                             
 20 as BillId ,'销售退货入库' as Billtype ,                            
 m.Code,m.WhId,d.WareId,d.Qty as OriQty ,d.Qty  as StkInQty,0 as StkOutQty ,m.IsChk ,                                                    
 m.billTime,m.ChkTime   ,m.ReturnDate                                                           
 from sl_return m                                                               
 inner join sl_returndl d on m.Code=d.ReturnId      -- 销售退货入库                                   
 where d.WareId in (select Id from #wr)   and WhId=@StorageID                                                                       
                                                        
 union all                                          
 select --top 1                             
 3 as BillId ,'零售出库' as Billtype ,                            
 m.Code,m.WhId,d.WareId,-d.Qty as OriQty,0  as StkInQty,d.Qty as StkOutQty  , m.IsChk ,                                                    
 m.billTime,m.ChkTime    ,m.RetailDate                                                          
 from sl_retail m                                                               
 inner join sl_retaildl d on m.Code=d.RetailId      --零售出库                                                        
 where d.WareId in (select Id from #wr)    and WhId=@StorageID                                                               
            
    
            
 union all                                                               
select --top 1                             
 23 as BillId ,'调拨入库'+m.OutWhId as Billtype ,                            
 m.Code,m.InWhId,d.WareId,d.Qty as OriQty,d.Qty   as StkInQty,0 as StkOutQty ,m.IsChk ,                                                    
 m.billTime,m.ChkTime  ,m.MoveDate                                                            
 from wh_move m                                                               
 inner join wh_movedl d on m.Code=d.MoveId              --调拨入库                         
 where d.WareId in (select Id from #wr)  and InWhId=@StorageID                                                               
 union all                 
                                                                     
                                                           
 select --top 1                          
 23 as BillId ,'调拨出库'+m.InWhId as Billtype ,                            
 m.Code,m.OutWhId,d.WareId,-d.Qty as OriQty,0  as StkInQty,d.Qty as StkOutQty ,m.IsChk ,                                                    
 m.billTime,m.ChkTime  ,m.MoveDate                                                            
 from wh_move m                                                               
 inner join wh_movedl d on m.Code=d.MoveId            --调拨出库                                                   
 where d.WareId in (select Id from #wr) and OutWhId=@StorageID                                                       
/*                   
              
select 21, '调拨入库'+m.WhId as Billtype ,                
 m.Code,m.WhId,d.WareId,d.Qty as OriQty,d.Qty   as StkInQty,0 as StkOutQty ,m.IsChk ,              
 m.billTime,m.ChkTime  ,m.inDate                
 from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02')  and  d.WareId in (select Id from #wr)  and WhId=@StorageID                 
              
union all                          
select 22,'调拨出库'+m.WhId as Billtype ,               
      m.Code,m.WhId,d.WareId,-d.Qty as OriQty,0  as StkInQty,d.Qty as StkOutQty ,m.IsChk ,               
 m.billTime,m.ChkTime  ,m.outDate                                                    
from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02')  and  d.WareId in (select Id from #wr)  and WhId=@StorageID                 
   */                    
                                   
union all                                                              
 select --top 1                             
 21 as BillId ,t.WhName+' '+IsNull(m.ClientName,'') Billtype ,                            
 m.Code,m.WhId,d.WareId,d.Qty as OriQty,d.Qty  as StkInQty,0 as StkOutQty  ,m.IsChk ,                                      
 m.billTime,m.ChkTime  ,m.InDate                                                            
 from wh_in m                             
 inner join wh_indl d on m.Code=d.InId                             
 left outer join wh_inout t on m.InTypeId=t.code                             
 where d.WareId in (select Id from #wr) and t.sys=0 and m.WhId=@StorageID                                 
                               
                     
              
                                   
                              
 union all                                                              
select --top 1                             
 22 as BillId ,t.WhName+' '+IsNull(m.ClientName,'') Billtype ,                            
 m.Code,m.WhId,d.WareId,-d.Qty as OriQty,0  as StkInQty,d.Qty  as StkOutQty ,m.IsChk ,                   
 m.billTime,m.ChkTime   ,m.OutDate                                                           
 from wh_out m                                                               
 inner join wh_outdl d on m.Code=d.OutId                                                               
 left outer join wh_inout t on m.OutTypeId=t.code                             
 where d.WareId in (select Id from #wr) and t.sys=0 and m.WhId=@StorageID                                                      
                             
                                   
                                                                                        
 union all                                                              
select  --top 1                             
 -1,'调整',                            
 '',WhId,WareId,Qty as OriQty,                                                    
 case  when qty>0 then qty else 0 end as StkInQty ,                                                    
 case  when qty<0 then -qty else 0 end as StkOutQty  ,                                                    
 1   as IsChk ,xdate as billTime,xdate as ChkTime   ,xDate                                                         
 from wh_regulate                             
 where WareId in   (select Id from #wr)    and WhId=@StorageID                                                             
                                                               
                                                          
                                                            
                                                              
                                                    
                                                             
                                           
                                                            
                                           
                                                       
                             
        --  select *from #AllTmp    where wareid=40593                        
                        
                        
                         
/*                          
declare  @BeginTime smalldatetime                                                              
declare  @EndTime smalldatetime                        
set @BeginTime='2006-7-11'                                                              
set @EndTime='2006-7-11'                          
*/                            
                      
declare @oriqty int                                                                          
                                                 
                                            
if rtrim(ltrim(@UseWhichDate))='制单日期'                                                               
begin                                                                              
                         
 select wareid, sum(isnull (oriqty,0)) as oriqty                                  
 into #semTmpOri                                                     
 from #AllTmp where billTime <@BeginTime --'2006-7-11'   --'2005-5-19' -- BillTime<@BeginTime                                                    
 group by wareid                               
                         
 select distinct wareid into #allware from #AllTmp                        
                         
 select t1.wareid,isnull(t2.oriqty,0 )as oriqty  into #TmpOri                        
 from #allware t1                          
 left join  #semTmpOri t2 on t1.wareid=t2.wareid                         
                        
                                                                            
   select wareid, sum(isnull(StkInQty,0))as TakInCnt ,                                                    
           sum(isnull(StkOutQty,0)) as  TakOutCnt ,                                                     
           sum(isnull(StkInQty,0))-sum(isnull(StkOutQty,0)) as DiffCnt                                                     
    into  #DuTmp            
   from #AllTmp where billTime>=@BeginTime   --   BillTime>=@BeginTime                                                    
             and  billTime <=@EndTime-- BillTime <=@EndTime                                                    
   group by wareid                           
                                                 
                          
   select t1.wareID ,t3.Model,   t3.origin,                                                     
   t3.PartNo as specification ,t3.Brand,t3.pack as encapsulation ,t3.Unit ,                                       
   t1.oriqty as StrOriCnt ,t2.TakInCnt,t2.TakOutCnt,t2.DiffCnt,t1.oriqty+t2.diffcnt as remainder,'' as remark                                                    
   from #TmpOri t1                                                     
   join #DuTmp t2 on t1.wareid=t2.wareid                                                    
   join #wr     t3 on t1.wareId=t3.Id   and t2.wareId=t3.Id                                                     
   where   t3.Model is not null   and (t2.TakInCnt<>0 or t2.TakOutCnt <>0 )  --没做出入库的不显示                                                   
                                                  
    drop table #semTmpOri                                 
    drop table #allware                              
    drop table #TmpOri                                                    
    drop table  #DuTmp                                              
                                              
end           
        
                                                         
if rtrim(ltrim(@UseWhichDate))='审核日期'                                                               
begin                                                                                                            
                                                    
 select wareid, sum(isnull (oriqty,0)) as oriqty                                                     
 into #semTmpOri2                                                     
 from #AllTmp where ChkTime <@BeginTime --'2006-7-11'   --'2005-5-19' -- BillTime<@BeginTime                                                    
 group by wareid                               
                         
 select distinct wareid into #allware2 from #AllTmp                        
                         
 select t1.wareid,isnull(t2.oriqty,0 )as oriqty  into #TmpOri2                        
 from #allware2 t1                          
 left join  #semTmpOri2 t2 on t1.wareid=t2.wareid                         
                        
                                                     
                                      
  select wareid, sum(isnull(StkInQty,0))as TakInCnt ,                                                    
          sum(isnull(StkOutQty,0)) as  TakOutCnt ,                                                     
          sum(isnull(StkInQty,0))-sum(isnull(StkOutQty,0)) as DiffCnt                                                     
   into  #DuTmp2     
  from #AllTmp where ChkTime>=@BeginTime             and  ChkTime <=@EndTime                                                    
  group by wareid                                                    
                                                      
                                                     
  select t1.wareID ,t3.Model, t3.origin,                                                
  t3.PartNo as specification ,t3.Brand,t3.pack as encapsulation ,t3.Unit ,                                                    
  t1.oriqty as StrOriCnt ,t2.TakInCnt,t2.TakOutCnt,t2.DiffCnt,t1.oriqty+t2.diffcnt as remainder,'' as remark                                                    
  from #TmpOri2 t1                                                     
  left join #DuTmp2 t2 on t1.wareid=t2.wareid                                                    
  left join #wr     t3 on t1.wareId=t3.Id   and t2.wareId=t3.Id                      
  where   t3.Model is not null  and (t2.TakInCnt<>0 or t2.TakOutCnt <>0 ) --没做出入库的不显示                                             
                                            
                          
 drop table #semTmpOri2                                 
 drop table #allware2                                          
 drop table #TmpOri2                            
 drop table  #DuTmp2                                                        
                                                              
end               
        
        
        
                                                         
if rtrim(ltrim(@UseWhichDate))='日期'                                                               
begin                                                                                                            
                                                    
 select wareid, sum(isnull (oriqty,0)) as oriqty                                                     
 into #semTmpOri3                                                    
 from #AllTmp where xDate <@BeginTime --'2006-7-11'   --'2005-5-19' -- BillTime<@BeginTime                                                    
 group by wareid                               
                         
 select distinct wareid into #allware3 from #AllTmp                        
                         
 select t1.wareid,isnull(t2.oriqty,0 )as oriqty  into #TmpOri3                        
 from #allware3 t1                          
 left join  #semTmpOri3 t2 on t1.wareid=t2.wareid                         
                        
                                                     
                                      
  select wareid, sum(isnull(StkInQty,0))as TakInCnt ,                                                    
          sum(isnull(StkOutQty,0)) as  TakOutCnt ,                                                     
          sum(isnull(StkInQty,0))-sum(isnull(StkOutQty,0)) as DiffCnt                                                     
   into  #DuTmp3                                                     
  from #AllTmp where xDate>=@BeginTime           and  xDate <=@EndTime                                                    
  group by wareid                                                    
                                                      
                                                     
  select t1.wareID ,t3.Model, t3.origin,                                                
  t3.PartNo as specification ,t3.Brand,t3.pack as encapsulation ,t3.Unit ,                                              
  t1.oriqty as StrOriCnt ,t2.TakInCnt,t2.TakOutCnt,t2.DiffCnt,t1.oriqty+t2.diffcnt as remainder,'' as remark                                                    
  from #TmpOri3 t1                                                     
  left join #DuTmp3 t2 on t1.wareid=t2.wareid                                                    
  left join #wr     t3 on t1.wareId=t3.Id   and t2.wareId=t3.Id                      
  where   t3.Model is not null  and (t2.TakInCnt<>0 or t2.TakOutCnt <>0 ) --没做出入库的不显示                                             
                                            
                 
 drop table #semTmpOri3                                 
 drop table #allware3                                          
 drop table #TmpOri3                                                    
 drop table  #DuTmp3                                                        
                                                              
end              
                                                     
drop table #wr                                                      
drop table #AllTmp                                               
                                                            
              
            
            
            
          
          
        
      
    
  
