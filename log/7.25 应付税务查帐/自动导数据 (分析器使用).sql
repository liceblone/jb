
--delete  jbhzTaxUdata.dbo.sl_invoice
delete jbhzTaxUdata.dbo.sl_invoicedl

---jbhzTaxUdata    jbhzuserdata

insert into    jbhzTaxUdata.dbo.sl_invoice
select *From   jbhzuserdata.dbo.sl_invoice 
where istax=1   and ischk=1
and code not in (select code from jbhzTaxUdata.dbo.sl_invoice)
 
drop table jbHzTaxUdata.dbo.sl_invoicedl 
--sl_invoiceDL
select  * into jbHzTaxUdata.dbo.sl_invoicedl  From   jbhzuserdata.dbo.sl_invoicedl where invoiceid in (select code from jbHzTaxUdata.dbo.sl_invoice)
--client 
insert into jbHzTaxUdata.dbo.crm_client    
select Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,
LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,
Url,Email,Note,Demand,Products,IsPub,balance,AddEmpId, IsUse,
CreditLine,mon_cls_entry,KeyWords,Cls_Entry_Months,GatheringEmp,OldNickName,Issuspect,SuspectNote,debt
 From   jbhzuserdata.dbo.crm_client   where Code not in (select code from jbHzTaxUdata.dbo.crm_client)
 

--select *from crm_client 

--select * From jbhzTaxUdata.dbo.sl_invoice



 ---jbWzTaxUdata    jbwzuserdata
--delete  jbWzTaxUdata.dbo.sl_invoice
delete jbWzTaxUdata.dbo.sl_invoicedl


insert into    jbwzTaxUdata.dbo.sl_invoice
select *From   jbwzuserdata.dbo.sl_invoice 
where istax=1   and ischk=1
and code not in (select code from jbwzTaxUdata.dbo.sl_invoice)
 
drop table jbwzTaxUdata.dbo.sl_invoicedl 
 --sl_invoiceDL
select  * into jbwzTaxUdata.dbo.sl_invoicedl  From   jbwzuserdata.dbo.sl_invoicedl where invoiceid in (select code from jbwzTaxUdata.dbo.sl_invoice)
--client 
insert into jbwzTaxUdata.dbo.crm_client    
select Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,
LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,
Url,Email,Note,Demand,Products,IsPub,balance,AddEmpId, IsUse,
CreditLine,mon_cls_entry,KeyWords,Cls_Entry_Months,GatheringEmp,OldNickName,Issuspect,SuspectNote,debt
 From   jbwzuserdata.dbo.crm_client   where Code not in (select code from jbwzTaxUdata.dbo.crm_client)


 ---jbBjTaxUdata    jbBjuserdata
--delete  jbBjTaxUdata.dbo.sl_invoice
delete jbBjTaxUdata.dbo.sl_invoicedl

insert into    jbBjTaxUdata.dbo.sl_invoice
select *From   jbBjuserdata.dbo.sl_invoice 
where istax=1  and ischk=1
and code not in (select code from jbBjTaxUdata.dbo.sl_invoice)
 
drop table jbBjTaxUdata.dbo.sl_invoicedl 
 
select  * into jbBjTaxUdata.dbo.sl_invoicedl  From   jbBjuserdata.dbo.sl_invoicedl where invoiceid in (select code from jbBjTaxUdata.dbo.sl_invoice)
--client 
insert into jbBjTaxUdata.dbo.crm_client    
select Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,
LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,
Url,Email,Note,Demand,Products,IsPub,balance,AddEmpId, IsUse,
CreditLine,mon_cls_entry,KeyWords,Cls_Entry_Months,GatheringEmp,OldNickName,Issuspect,SuspectNote,debt
 From   jbBjuserdata.dbo.crm_client   where Code not in (select code from jbBjTaxUdata.dbo.crm_client)



 ---jbYqTaxUdata    jbYquserdata
--delete  jbYqTaxUdata.dbo.sl_invoice
delete jbYqTaxUdata.dbo.sl_invoicedl

insert into    jbYqTaxUdata.dbo.sl_invoice
select *From   jbYquserdata.dbo.sl_invoice 
where istax=1   and ischk=1
and code not in (select code from jbYqTaxUdata.dbo.sl_invoice)
 
drop table jbYqTaxUdata.dbo.sl_invoicedl 
 
select  * into jbYqTaxUdata.dbo.sl_invoicedl  From   jbYquserdata.dbo.sl_invoicedl where invoiceid in (select code from jbYqTaxUdata.dbo.sl_invoice)
--client 
insert into jbYqTaxUdata.dbo.crm_client    
select Code,Name,NickName,ClassId,FatherId,RegionId,TaxId,
LawMan,Bank,BankId,LinkMan,Tel,Fax,Addr,Zip,Mobile,BeepPager,
Url,Email,Note,Demand,Products,IsPub,balance,AddEmpId, IsUse,
CreditLine,mon_cls_entry,KeyWords,Cls_Entry_Months,GatheringEmp,OldNickName,Issuspect,SuspectNote,debt
 From   jbYquserdata.dbo.crm_client   where Code not in (select code from jbYqTaxUdata.dbo.crm_client)
