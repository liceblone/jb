select --top  2                                                    
1 as pk,  'sl_invoicedl' as TableName,'销售发货'as BillNote , D.InvoiceId as code ,                            
  1 as Billtype, 19 as billid,                                
                                                          
D.dlId,D.WareId,D.PartNo, D.Brand,D.Pack,D.Qty,D.Price,                                                            
D.Qty*D.Price as WareFund ,0 as TaxAmt,D.Qty*D.Price as amt,0 as AdjustFund , m.taxrate,                                                          
D.Cost,D.FpID ,null as AccountItemID,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                            
'货款: '+convert(varchar(20),D.Qty*D.Price ) as Note  ,                                  
M.invoiceDate as FDate ,M.Billtime  ,                        
D.Qty-isnull(D.InvQty,0)     as RmnInvQty                         
                                  
into #TmpInvoice                                                                      
from sl_invoicedl D                                                                      
join sl_invoice   M on M.code=D.InvoiceId                                                                      
where M.IsTax=1   and M.ClientID='HZ000168'        and D.Qty<>isnull(D.InvQty,0)    -- and M.IsChk=1                    
                                  
select * from #TmpInvoice  where  code='si00086602'                    and  Qty<>isnull( InvQty,0)         


select D.Qty,D.InvQty ,D.FpID,D.*
from sl_invoicedl D                                                                      
join sl_invoice   M on M.code=D.InvoiceId                                                                      
where M.IsTax=1   and M.ClientID='HZ000168'     --   and D.Qty<>isnull(D.InvQty,0)    -- and M.IsChk=1                    
and M.code='si00086602'    

select InvoiceId from sl_invoicedl where isnull(invqty,0)<>0 and fpid is null


select top 100 *from  TInvoiceMsgDL where  ItemTableBillcode='si00086602'   



select top 100 *from  TInvoiceMsgDL where ItemTableName='sl_invoicedl'and
  ItemTableBillcode not in (
select InvoiceId from sl_invoicedl where isnull(invqty,0)<>0 and fpid is null)


select * from sl_invoice where code in (
	select InvoiceId from sl_invoicedl where isnull(invqty,0)<>0 and fpid is null
	and InvoiceId not in (
	select   ItemTableBillcode from  TInvoiceMsgDL where ItemTableName='sl_invoicedl'  )
)

	select * from sl_invoicedl where isnull(invqty,0)<>0 and fpid is null
	and InvoiceId not in (
	select   ItemTableBillcode from  TInvoiceMsgDL where ItemTableName='sl_invoicedl'  )


 
select *      from sl_invoicedl where InvoiceId='SI00086602'
update sl_invoicedl set invqty=null where InvoiceId='SI00086602'

	select * from sl_invoicedl where isnull(invqty,0)<>0 and fpid is null
	and InvoiceId not in (
	select   ItemTableBillcode from  TInvoiceMsgDL where ItemTableName='sl_invoicedl' and ItemTableBillcode is null  )