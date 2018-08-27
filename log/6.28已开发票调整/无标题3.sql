
    pk,TableName,    Code,             dlid,wareid,partNo,brand,pack,RmnInvQty,Price,TaxRate,AccountItemID,WareFund,TaxAmt,amt,AdjustFund,RmnInvQty
Frompk,ItemTableName,ItemTableBillCode,Dlid,wareid,partNo,brand,pack,sqty,Price,TaxRate, AccountNo,WareFund,TaxAmt,amt,AdjustFund,qty


          
-- union all

select top 1 * 
  Into T_InvoiceAdjust
 from   #TmpInvoice


delete T_InvoiceAdjust

alter table T_InvoiceAdjust alter column tablename varchar(50)



insert into T_InvoiceAdjust
select top 1
pk,
'发票已开总额调整',
'发票已开总额调整',
'1',
'1',
'1',
'1',
'1',
'发票已开总额调整',
'',
'',
1,
1,
1,
0,
0,
0,

0,
0,
null,
null,
'clblue',
1,
'发票已开总额调整',
getdate(),
getdate(),
1
 from #TmpInvoice



select *from T_InvoiceAdjust


drop table T_InvoiceAdjust
 
        
      