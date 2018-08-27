-- select *from T506 where f02=20 and f01 in (589,98)



update T506 set f07=12 where f02=20 and f01=98

update T506 set f12=571 where f02=20  and f01 in ( 98)
update T506 set f12=533 where f02=20  and f01 in (589)



--2010-9-22
update T506 set f12=511 where f02=20  and f01 in ( 98)
update T506 set f12=473 where f02=20  and f01 in (589)


--- select r.*,f.F02 as F99 ,f.F09 from T506 r left outer join T102 f on r.F16=f.F01 where r.F02=20  and r.F18=1 order by r.f13

 