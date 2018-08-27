select top 10000  warefund,* from wh_out where   year(outdate)=2009   and warefund<1

 wh_out where warefund=0



select  top 1000   qty*price,outid ,qty,price,* from wh_outdl where outid in (select code from wh_out where year(outdate)=2009 )   --warefund=0)


select    sum(qty*price)as warefund,outid  into #tmp  from wh_outdl where   outid in (select code from wh_out where year(outdate)=2009 )     group by outid 

select *from #tmp

select warefund,* from wh_out where warefund=0


wh_out
   select A.warefund,b.warefund ,*
from wh_out	   A
join Wh_out090507  B on A.code=B.code
where A.warefund<> b.warefund


select * into Wh_out090507 from wh_out


update wh_out set warefund=B.WareFund
--   select A.warefund,b.warefund ,*
from wh_out 	A
join #tmp 	B on A.code=B.outid
where A.warefund<> b.warefund


wz34800.8000	34888.40000	OT00095880

drop table #tmp
