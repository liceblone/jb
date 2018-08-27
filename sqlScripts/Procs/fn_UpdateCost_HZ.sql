alter     PROCEDURE [dbo].[fn_UpdateCost]                               
                 @BillType varchar(20),                              
                 @BillCode varchar(20)                              
AS                              
                              
--v2006-7-28                          
    /*             
declare    @BillType varchar(20)                        
declare    @BillCode varchar(20)                          
                        
set @BillType ='ph_arrive'                        
set    @BillCode ='pa00033401'                        
    */                           
                        -- select * from wh_inout where Code in ('i01', 'i08','i09') 
                        
--select WareId,Price,Qty  into #wr from wh_indl where 1=2                    
--  alter table #wr add iStock decimal(19,5)  default 0               

              
create table #wr              
(WareId int ,              
Price   decimal(19,5),              
Qty     int ,              
iStock  decimal(19,0)  )              
              
   -- select *From #wr              
              

declare @MonthEnd smalldatetime
select  @MonthEnd = MAX(fmonth) from ERPUserData.dbo.TInvCostAcctMonthEndClose where FIsClosed =1

   --12/15/2012   d.Price-d.Price*m.TaxRate--->  d.Price/(100*m.TaxRate)                    
if @BillType='ph_arrive' begin      
  insert into #wr(WareId )                               
    select d.WareId 
    from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code where   code=@BillCode 
end                                    
else if @BillType='wh_in' begin                         
    declare @inouttype varchar(20)                    
                    
    select @inouttype =intypeid From wh_in where code=@BillCode                     
    if @inouttype='I08'                    
    insert into #wr(WareId )                              
       select WareId 
       from wh_indl D join wh_in m on m.code=d.inid where InId=@BillCode  and         intypeid='I08' and code=@BillCode 
                    
    if @inouttype='I09'                    
    insert into #wr(WareId )      select WareId  
       from wh_indl D join wh_in m on m.code=d.inid where InId=@BillCode  and    intypeid='I09' and code=@BillCode                     
end                            
     --    print 1                         

 

select'his'as code, FInvCode as wareid , SUM (FStorage) as Qty, SUM(famt) as FAmt  into #his  
	from ERPUserData.dbo.TMtrLStorageHis his join #wr wr on his.FInvCode =wr.WareId
	where  FMonth = @MonthEnd and FStorage>0  and FAvgPrice>0 group by FInvCode
union all
select  m.Code, d.WareId,  d.qty    ,   d.qty*   d.Price/(1+isnull( m.TaxRate,0))  as FAmt                          
	from wh_in m inner join wh_indl d  on m.Code=d.InId
	join #wr wr on d.WareId =wr.WareId
	where m.InTypeId  in ('I08','I09')  and m.IsChk=1 
	and m.ChkTime>=@MonthEnd            
union all
select m.Code, d.WareId   ,d.Qty ,d.Qty * d.Price/(1+isnull(m.TaxRate,0)) as FAmt
	from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code 
	join #wr wr on d.WareId =wr.WareId
	where m.IsChk =1 and m.ChkTime>=@MonthEnd                           

                 
                     
          
--  select  * ,  FAMT /  Qty  from #his where id=35983                    
                    
--当前成本价为0时用最新进价作为成本价                        
update wr_ware set Cost= isnull(price,0) where Id in (select WareId from #wr)      and isnull(cost,0)<=0                              
--否则计算平均成本价  (本次金额 +上次数量*上次平均成本价  )/总库存                        
--update wr_ware set Cost= isnull( (   select case when iStock-qty>0 then (Price*Qty+Cost*(iStock-qty))/(iStock)else Price end  from #wr where Id=WareId),Cost)         
--where Id in (select WareId from #wr)      and isnull(cost,0)<>0                        


update wr_ware set Cost = his.fAvgPrice
from wr_ware wr
 join ( select wareid , SUM(FAMT)/SUM(Qty ) as favgprice from #his
            where  QTY >0 group by wareid ) as His on wr.id =his.wareid
                  
insert into   TCostHistory (FinvCode, FCost,FBillCode )
select wareid , SUM(FAMT)/SUM(Qty ) as favgprice ,@BillCode from #his
            where  QTY >0 group by wareid
                
--select     (3.6*1000+1.8*1000)/2000                    
                              
drop table #wr 
drop table #his    