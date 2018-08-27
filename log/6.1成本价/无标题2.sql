                               
select wareid,qty,price  from ph_arrivedl
union all   
select wareid,qty,price  from sl_returndl
union all   
select wareid,qty,price from sl_invoicedl
union all             
select wareid,qty,price  from ph_returndl
union all    
select wareid,qty,price  from wh_outdl where outid in (select code from wh_out  where OutTypeId='X08' or OutTypeId='X09')
union all                                  
select wareid,qty,price   from wh_indl where   inid in (select code from wh_in   where InTypeId='I08' or InTypeId='I09')                                   
 


sp_helptext wh_out_chk1

select *from wh_indl
select *from sl_invoicedl

select * from sl_returndl
sp_helptext wh_in_chk1


CREATE   PROCEDURE [dbo].[wh_in_chk1]             
                 @InId varchar(20),            
                 @HandManId varchar(20)            
AS            
--2006-7-28同行入库加税率          
          
 declare @InOut varchar(20),@IsChk bit,@IsClose bit,@ChkManId varchar(50),@BillId varchar(20),@ClientId varchar(20),@InTypeId varchar(20) ,@TaxRate money           
 set @BillId=21            
 select @InOut=InTypeId,@IsChk=IsChk,@IsClose=IsClose,@ChkManId=ChkManId,@ClientId=ClientId,@InTypeId=InTypeId from wh_in where Code=@InId and IsChk=0            
 if @@rowcount<>1            
   Raiserror('系统找不到该入库单,数据可能已被其它操作员删除或已审核,请[-刷新-]验证!',16,1)            
 else            
 begin            
    begin tran            
                
  
  
      select  @TaxRate=MoneyX from sys_parameters where Id=6  --2006-7-28 去掉   TaxRate=@TaxRate,      
      update wh_in set IsChk=1,ChkManId=@HandManId,ChkTime=IsNull(ChkTime,GetDate()) where Code=@InId     
  
  
      if exists(select ChkTime,billtime,* from         wh_in where ChkTime<billtime)  
      begin  
           raiserror('审核时间有误！',16,1)            
           return(0)      
      end  
  
 if @InOut='I08' or    @InOut='I09'       
      exec fn_UpdateCost 'wh_in',@InId      
    
 update wr_ware set IsUse=1 from wr_ware T1 join wh_inDl T2 on T1.id=t2.wareid   where InId=@InId     
--开户雇用标志            
      
    commit            
    if @@error=0            
       return(1)            
    rollback            
    raiserror('事务提交失败,操作无效!',16,1)            
    return(0)            
 end            
Return 1          
    

sp_helptext fn_UpdateCost
  

CREATE    PROCEDURE [dbo].[fn_UpdateCost]                     
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
    
              
if @BillType='ph_arrive' begin                    
  insert into #wr(WareId,Price,Qty)                     
    select d.WareId,d.Price-d.Price*m.TaxRate as Price,d.Qty from ph_arrivedl d inner join ph_arrive m on d.ArriveId=m.Code where d.ArriveId=@BillCode                    
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
update wr_ware set Cost= isnull( (   select (Price*Qty+Cost*(iStock-qty))/(iStock)  from #wr where Id=WareId),Cost) where Id in (select WareId from #wr)      and isnull(cost,0)<>0              
              
if @@rowcount=0         
update wr_ware set cost =B.Price from wr_ware A,#wr B where A.id=B.wareid         
--select     (3.6*1000+1.8*1000)/2000          
                    
drop table #wr                    
drop table #a                  
      
      
    
  
  

