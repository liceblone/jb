	   drop table #MaxPrice	  drop table #MinPrice

select wareid, min(price ) as MinPrice  
into #Min
from ph_arrivedl group by wareid	 
union
select dl.wareid , min(dl.price ) from wh_in M join wh_indl dl on M.Code=Dl.InID   where inTypeID in ('I08' , 'I09')   
 group by wareid

select wareid, min(MinPrice ) as MinPrice  
into #MinPrice		 from #Min	 group by wareid



select wareid, max(price ) as MaxPrice 
into #Max
from ph_arrivedl	  group by wareid
union
select dl.wareid , max(dl.price ) from wh_in M join wh_indl dl on M.Code=Dl.InID   where inTypeID in ('I08' , 'I09')   
 group by wareid
 
select wareid, min(MaxPrice ) as MaxPrice  
into #MaxPrice		 from #Max	 group by wareid

select * from #MinPrice where wareid=   48768
 
	-- drop table #TLessCost
select	   MinPrice.MinPrice , MaxPrice.MaxPrice ,	wr.price, wr.Cost   ,wr.CreateDatatime
, 100*(MinPrice.MinPrice- wr.Cost)/Cost	 as LastPercent	  
,dbo.Fn_GetLatestDate(wr.id) as LatestDate , dbo.Fn_GetIoCount(id,getdate())as IoCount
,wr.id,Wr.partNo,wr.Brand
into #TLessCost	  --- select *
from wr_ware wr
left join #MinPrice  MinPrice on MinPrice.wareid =wr.id
left join #MaxPrice  MaxPrice on wr.id=MaxPrice.wareid and  MinPrice.wareid =MaxPrice.wareid -- and 
where Cost<MinPrice	 and Cost>0   
order by  100*(MinPrice.MinPrice- wr.Cost)/Cost	 desc

--or Cost>MaxPrice
select min( price ) as Price,wareid ,count(1) as SLCount into #TSLitem from   sl_invoicedl
group by wareid

select * from #MaxPrice where wareid=48768

select  item.*   , cost.* 
from #TLessCost	cost
join #TSLitem	item on cost.id = item.wareid
where cost.LatestDate> convert(varchar(19),getdate()-720,121)        
            
--select * from #Show  
          
select  item.*   , cost.* 
from #TLessCost	cost
join #TSLitem	item on cost.id = item.wareid
where cost.LatestDate> convert(varchar(19),getdate()-720,121)
and item.Price<Cost.MinPrice    and item.Price<cost.Price    
order by cost.LastPercent desc
          
          
go
                
               