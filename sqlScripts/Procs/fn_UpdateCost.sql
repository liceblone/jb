alter     PROCEDURE [dbo].[fn_UpdateCost]                       
                 @BillType varchar(20),                      
                 @BillCode varchar(20)                      
AS                      
                      
--v2006-7-28                  
 /*               
declare    @BillType varchar(20)                
declare    @BillCode varchar(20)                  
                
set @BillType ='ph_arrive'                
set    @BillCode ='pa00009864'                
*/                
                
--select WareId,Price,Qty  into #wr from wh_indl where 1=2            
--  alter table #wr add iStock decimal(19,5)  default 0       
        
      
create table #wr      
(WareId int ,      
Price   decimal(19,5),      
Qty     int ,      
iStock  int  )      
      
   -- select *From #wr      
      
   --12/15/2012   d.Price-d.Price*m.TaxRate--->  d.Price/(100*m.TaxRate)            
if @BillType='ph_arrive' begin                      
  insert into #wr(WareId,Price,Qty)                       
    select d.WareId,   d.Price/(1+m.TaxRate) as Price,d.Qty from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code where d.ArriveId=@BillCode                      
end                      
else if @BillType='sl_return' begin                      
  insert into #wr(WareId,Price,Qty)                      
    select WareId,Price,Qty from sl_returndl where ReturnId=@BillCode                      
end                      
else if @BillType='wh_in' begin                 
                       
    declare @inouttype varchar(20)            
            
    select @inouttype =intypeid From wh_in where code=@BillCode             
    if @inouttype='I08'            
    insert into #wr(WareId,Price,Qty)                      
       select WareId,d.Price-d.Price*m.TaxRate ,Qty from wh_indl D join wh_in m on m.code=d.inid where InId=@BillCode     and intypeid='I08'            
            
    if @inouttype='I09'            
    insert into #wr(WareId,Price,Qty)                      
       select WareId,d.Price ,Qty from wh_indl D join wh_in m on m.code=d.inid where InId=@BillCode     and intypeid='I09'            
end                   
else begin                      
     return 0             
       --    print 1          
end                      
                 
            
                      
select d.WareId,d.qty into #a                 
from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 where d.WareId in (select WareId from #wr)                      
                
union all                      
select d.WareId,-d.qty from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 where d.WareId in (select WareId from #wr)                      
union all                      
select WareId,Qty from wh_regulate where WareId in (select WareId from #wr)                      
                      
                
--select * From #wr            
--select * From #a            
            
update #wr set iStock=(select sum(isnull(#a.Qty,0)) from #a where #a.WareId=#wr.WareId)  --总量                    
                
                
--  select cost,* from wr_ware where id=35983            
            
--当前成本价为0时用最新进价作为成本价                
update wr_ware set Cost= isnull(price,0) where Id in (select WareId from #wr)      and isnull(cost,0)<=0                      
--否则计算平均成本价  (本次金额 +上次数量*上次平均成本价  )/总库存                
update wr_ware set Cost= isnull( (   select case when iStock>0 then (Price*Qty+Cost*(iStock-qty))/(iStock)else Price end  from #wr where Id=WareId),Cost) 
where Id in (select WareId from #wr)      and isnull(cost,0)<>0                
                
if @@rowcount=0           
update wr_ware set cost =B.Price from wr_ware A,#wr B where A.id=B.wareid           
--select     (3.6*1000+1.8*1000)/2000            
                      
drop table #wr                      
drop table #a                    
        
        
      
    