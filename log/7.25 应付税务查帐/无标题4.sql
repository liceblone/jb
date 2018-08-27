select * from sys_filiale

select * from sys_tab

select * from wh_warehouse
 



alter table sys_filiale add BforTax bit


select *  from sys_filiale


insert into sys_filiale (Code,Name,Tabid,IsUse,BforTax  )
select 5,'浙江晶贝电子科技有限公司',5,1,1

insert into sys_filiale (Code,Name,Tabid,IsUse,BforTax  )
select 6,'温州市晶贝电子科技有限公司',6,1,1

insert into sys_filiale (Code,Name,Tabid,IsUse,BforTax  )
select 7,'浙江晶贝电子科技有限公司柳市经营部',7,1,1

insert into sys_filiale (Code,Name,Tabid,IsUse,BforTax  )
select 8,'北京晶贝电子科技有限公司',8,1,1

select Code,Name,Tabid,IsUse,BforTax  from sys_filiale




select code,filialeid,name,db,isuse from sys_tab

insert into sys_tab (code,filialeid,name,db,isuse)
select 5,5,'jbHzTaxUdata','jbHzTaxUdata',1
insert into sys_tab (code,filialeid,name,db,isuse)
select 6,6,'jbWzTaxUdata','jbWzTaxUdata',1
insert into sys_tab (code,filialeid,name,db,isuse)
select 7,7,'jbYQTaxUdata','jbYQTaxUdata',1
insert into sys_tab (code,filialeid,name,db,isuse)
select 8,8,'jbBJTaxUdata','jbBJTaxUdata',1


if exists(select *from tempdb..sysobjects where name='##TAccessDataForTax') drop table ##TAccessDataForTax create table ##TAccessDataForTax (  bForTax int )


insert into ##TAccessDataForTax (bForTax ) values(0)
bForTax=0   -- nomally

insert into ##TAccessDataForTax(bForTax ) values(1)
bForTax=1   -- for tax 

if exists(select *from tempdb..sysobjects where name='##TAccessDataForTax') select * from ##TAccessDataForTax  











--清数据

delete        sl_invoicedl
go
delete        sl_invoice
go
delete        sl_returndl
go
delete    sl_return
go
delete      ph_arrivedl
go
delete      ph_arrive
go
delete      ph_returndl
go
delete      ph_return
go
delete      fn_payment
go
delete      fn_receiver
go
delete      fn_shldin
go
delete      fn_shldout
go
delete      fn_clntransfer
go
delete      wh_outdl
go
delete      wh_out
go
delete      wh_indl
go
delete      wh_in
go
delete      sl_retail
go
delete      wh_regulate
go 





 