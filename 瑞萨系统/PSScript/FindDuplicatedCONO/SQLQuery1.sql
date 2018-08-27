			   select * from sysobjects where name like '%pur%'
			   
select * from TPurchaseOrder where	fcontractNo='HX8A92'

select fcontractNo, fpurchdate, * from TPurchaseOrder
where	 fcontractNo in (
select fcontractNo from TPurchaseOrder 
group by fcontractNo	   having count(*)>1
)
and fpurchdate >'2017-1-1'   and fvendorcode  is null -- and fcreateemp ='000'
order by	fcreateemp ,fcontractNo,  fcreatetime desc


select m.fcontractNo, m.fpurchdate, m.fcreatetime, dl.finqty -- m.* ,dl.*  
-- delete m
from TPurchaseOrder  m	join  TPurchaseOrdDL dl on m.FpurchOrdCode =  dl.FpurchOrdCode
where	 m.fcontractNo in (
select fcontractNo from TPurchaseOrder 
group by fcontractNo	   having count(*)>1
)
and m.fpurchdate >'2017-1-1'  and  dl.finqty  is null  --   and fvendorcode  is null -- and fcreateemp ='000'
order by	m.fcontractNo ,  dl.finqty   ,   m.fcreateemp , m.fcreatetime desc




						 

select m.fcontractNo, m.fpurchdate, m.fcreatetime, dl.finqty  , m.* ,dl.*  
from TPurchaseOrder  m	join  TPurchaseOrdDL dl on m.FpurchOrdCode =  dl.FpurchOrdCode
where	 m.fcontractNo in (
select fcontractNo from TPurchaseOrder 
group by fcontractNo	   having count(*)>1
)
  -- and dl.finqty  is null  --   and fvendorcode  is null -- and fcreateemp ='000'
order by	m.fcontractNo ,  dl.finqty
