
alter PROCEDURE [dbo].Pr_PhReturnSLOrdInv
                 @partNo varchar(50),                               
                 @Model varchar(50),                              
                 @WhId varchar(20)    
                --, @FBarCodeList varchar(5000) ='' 
                , @ClientId varchar(20) =''
                                            
AS                              
          --2009.07.12 只显示未被停用的规格     exec GetPickInfo_Use '','','008','931654218101,931654218101,931654218105'    
/*                              
declare                      
                 @partNo varchar(50),                      
                 @Model varchar(50),                      
                 @WhId varchar(20)                      
select @partNo='%%'                    
select @Model='74%'                      
select @WhId='01'                      
select top 20 * from wr_ware          
           
  */            

set @ClientId =REPLACE(@ClientId,'%','')

if @ClientId=''
select '请先选客户' as partno
      
select TOp 100  ord.Code,ord.ClientId,ord.ClientName,dl.InvDate, dl.Qty, dl.RemainQty,ord.IsTax ,dl.PhOrdFID    
,dl.wareid,dl.Price      
into #PhOrd      
 from ph_order ord join ph_orderdl dl on ord.Code = dl.OrderId      
where ord.IsChk=1  and ord.BillTime>'2016-1-1'      
and ISNULL(dl.ArrivedQty,0)>0 
and ord.ClientId = @ClientId 
order by ord.ChkTime desc 
      
                
                 
/*  
select * from ph_orderdl
select distinct  avbar.Qty as FBarCodeQty, IsNull(w.PriceRate,c.PriceRate) as myRate,w.*   into #wr          
from wr_ware w  left  join wr_class c on w.ClassId=c.Code     
join ( select   SUM(bar.Qty) as Qty, bar.wareid from Tbarcode bar join (select distinct f1 from dbo.Fn_SplitStrBySeprator (@FBarCodeList ,',' )) Spliter     
        on bar.fpackageBarcode= spliter.f1 group by  bar.wareid ) as AvBar on w.id= AvBar.Wareid    
union all 
*/    
select  null FBarCodeQty , IsNull(w.PriceRate,c.PriceRate) as myRate,w.*  
  into #wr           
      from wr_ware w           
inner join wr_class c on w.ClassId=c.Code           
where w.isUse=1 and Not exists(select * from #PhOrd)
and w.Model like  @Model   and  w.partno like  @partno     
union all
select  null, IsNull(w.PriceRate,c.PriceRate) as myRate,w.*            
      from wr_ware  w           
inner join wr_class c   on w.ClassId=c.Code  
inner join #PhOrd   ord on ord.WareId =w.id       
where w.isUse=1   
and w.Model like  @Model   and  w.partno like  @partno     
    

                              
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)                              
union all                              
/*                
select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                              
*/                
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') and d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02') and d.WareId in (select Id from #wr)                              
                    
union all                              
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                              
union all                              
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                              
union all                              
select '',WhId,WareId,Qty,1 from wh_regulate where WareId in (select Id from #wr)                              
                       
                    
    --declare      @WhId varchar(20)                      
    --select @WhId='01'                          
                  
select Top 300 w.*,IsNull((select sum(convert(decimal(19,0),Qty)) from #tmp where WareId=w.Id),0) as alStok,                              
           IsNull((select sum(convert(decimal(19,0),Qty)) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok        
      ,w.Price*w.myRate as Fund        
      ,w.id as wareid        
      ,case when w.isdel=1 then 'clred'         else 'clblack' end as fntclr 
      ,isnull(ord.Price,w.price) ImportPrice        
      ,ord.ClientId , ord.ClientName ,ord.Code ,ord.InvDate ,ord.Qty as SLOrdQty,ord.RemainQty ,   ord.Price as SLOrdPrice  ,ord.PhOrdFID                      
      ,case when  ord.IsTax=1 then '含' else null end as IsTax 
  --into #wr_tmp                            
from #wr w 
left join #PhOrd ord on  w.id = ord. wareid
                             
                            
--select * from #wr_tmp order by partno,model,brand,pack, alStok desc ,myStok desc                            
--drop table #wr_tmp                              
drop table #wr                              
drop table #tmp 
drop table #PhOrd

go