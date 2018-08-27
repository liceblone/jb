/*select * from crm_client where nickname='xsh'    
    
InvoiceInput_UnCom 'HZ000513'    
*/    
    
alter     proc InvoiceInput_UnCom                                         
@ClientID varchar(20)                                                                
--,@filter   VarChar(10)                                                                
as                                                                
                                                                
  /*                    select * From crm_client    where nickname like '%xdy%'                                  
 declare      @ClientID varchar(20)                                                  
 set        @ClientID   ='HZ000513'     
     */                                              
   --     select *from sl_invoice                                         
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
where M.IsTax=1   and M.ClientID=@ClientID    and D.Qty<>isnull(D.InvQty,0)    -- and M.IsChk=1              
                                                                
                                                                
union all                                                                
                                                                
select   --top  2                                              
1 as pk, 'sl_returnDL' as TableName, '销售退货'as BillNote,D.ReturnId,                        
 1 as Billtype,  20 as billid,                                                         
D.dlId,D.WareId,D.PartNo, D.Brand,D.Pack,-D.Qty,D.Price,                                                      
-D.Qty*D.Price as WareFund ,0 as TaxAmt,-D.Qty*D.Price as amt, 0 as AdjustFund ,  isnull( m.taxrate,0),                                                  
D.Cost,D.FpID ,null, case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                      
'退货: '+convert(varchar(20),-D.Qty*D.Price )          ,                            
M.ReturnDate,M.Billtime  ,-D.Qty                                    
from sl_returnDL D                                                                
join sl_return   M on M.code=D.ReturnId                                                                
where M.IsTax=1  and M.ClientID=@ClientID          and FpID is null    --and M.IsChk=1                                                
                                                      
union all                                                                
                                                                
select  --top  2                                              
1 as pk, 'fn_shldin' as TableName,                                    
 '应收税金 '  +convert(varchar(10),T1.PayFund )-- +' 税率:'+convert(varchar(10),taxrate/100 ) +' 应开金额:'+convert(varchar(10),100*T1.PayFund/taxrate )                           
 as BillNote,             T1.Code,                                              
   0 as BillType, 36 as billid,                                
ItemID,null,T2.Name, null,null,convert(decimal(15,2),100*T1.PayFund/taxrate )as TaxAmt ,1  ,                                                       
0,convert(decimal(15,2),100*T1.PayFund/taxrate )as TaxAmt ,convert(decimal(15,2),100*T1.PayFund/taxrate ) as amt, 0 as AdjustFund ,  taxrate/100 as TaxRate ,            
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                     
  '税金: '+convert(varchar(20),convert(decimal(15,2),100*T1.PayFund/taxrate ) )          ,                            
T1.InDate,T1.BillTime          ,      (100*T1.PayFund/taxrate)-isnull(InvQty,0) as RmnInvQty                  
from fn_shldin T1                                                                 
join fn_item   T2 on t1.itemid=t2.code                                                                
where   T2.code='011201'  and  ClientID=@ClientID  and isnull(TaxRate,0)<>0 and  (100*T1.PayFund/taxrate)<>isnull(InvQty,0)   --  and IsChk=1              
--select * from fn_item   select top 1 * from fn_shldin  where itemid='011201'                                                            
                                                   
union all                                                                
                                                             
select  --top  2                                              
1 as pk, 'fn_shldin' as TableName,                                
 '应收单 ' -- +convert(varchar(10),T1.PayFund )                            
as BillNote,           T1.Code,                                              
 0 as BillType, 36 as billid,                          
ItemID,null, '应收 '+T2.Name, null,null,convert(decimal(15,2),T1.PayFund ) ,1  ,                                                       
0,0 TaxAmt ,convert(decimal(15,2),T1.PayFund ) as amt, 0 as AdjustFund ,  0 as TaxRate ,                                                   
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                     
  '应收 '+T2.Name,                             
T1.InDate,T1.BillTime ,                  
PayFund-isnull(InvQty,0)   as RmnInvQty                             
from fn_shldin T1                                                                 
join fn_item   T2 on t1.itemid=t2.code                                                                
where     T2.code in ('0100','011202','015001','015002' ,'015003','0180') and  T1.istax=1                   
     and  ClientID=@ClientID    and PayFund<>isnull(InvQty,0)     --and IsChk=1                                                      
--select * from fn_item   select * from fn_shldin  where itemid='011201'        
                                                            
union all                                                                
                 
                                                    
select  --top  2                                              
1 as pk, 'fn_shldin' as TableName,                                
 '应收单 ' -- +convert(varchar(10),T1.PayFund )                            
as BillNote,           T1.Code,                                              
 0 as BillType, 36 as billid,                          
ItemID,null, '应收 '+T2.Name, null,null,convert(decimal(15,2),T1.PayFund ) ,1  ,                                                       
0,0 TaxAmt ,convert(decimal(15,2),T1.PayFund ) as amt, 0 as AdjustFund ,  0 as TaxRate ,                                                   
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                     
  '应收 发票调整',                             
T1.InDate,T1.BillTime ,                  
PayFund-isnull(InvQty,0)   as RmnInvQty                             
from fn_shldin T1                   
join fn_item   T2 on t1.itemid=t2.code                                                                
where     T2.code in ('0180')         
     and  ClientID=@ClientID    and PayFund<>isnull(InvQty,0)     --and IsChk=1                                          
--select * from fn_item   select * from fn_shldin  where itemid='011201'        
                                                                
union all                                                
select  --top  2           
1 as pk, 'fn_shldout' as TableName, '应付单'as BillNote, T1.Code,                                              
 0 as Billtype, 37 as billid,                           
ItemID,null,'应付 '+T2.Name, null,null,-T1.PayFund  ,1  ,                                                                
0,0 as  TaxAmt ,-T1.PayFund as amt,  -T1.PayFund  as AdjustFund , 0 as TaxRate ,                                                      
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input ,                                      
'应付 '+T2.Name,                           
T1.OutDate,T1.BillTime    ,-T1.PayFund                                  
from fn_shldout T1                                                                 
join fn_item   T2 on t1.itemid=t2.code                                                 
where  IsTax=1 and T2.code in ('0100')  and  ClientID=@ClientID      and FpID is null     --and IsChk=1                       
                       
union all                                                
select  --top  2                                              
1 as pk, 'fn_shldout' as TableName, '应付单'as BillNote, T1.Code,                                              
 0 as Billtype, 37 as billid,                           
ItemID,null,'应付 '+T2.Name, null,null,-T1.PayFund  ,1  ,                                                                
0,0 as  TaxAmt ,-T1.PayFund as amt,  -T1.PayFund  as AdjustFund , 0 as TaxRate ,                                                      
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input ,                                      
'应付 发票调整',                           
T1.OutDate,T1.BillTime    ,-T1.PayFund                                  
from fn_shldout T1                                                                 
join fn_item   T2 on t1.itemid=t2.code                                                 
where  T2.code in ('0180')  and  ClientID=@ClientID      and FpID is null     --and IsChk=1                       
               
--select *From fn_item        
union all                                                                
                                                                
select  --top  2                                              
1 as pk, 'fn_shldout' as TableName,                                    
 '退税金 '  +convert(varchar(10),T1.PayFund )-- +' 税率:'+convert(varchar(10),taxrate/100 ) +' 应开金额:'+convert(varchar(10),100*T1.PayFund/taxrate )                           
 as BillNote,             T1.Code,                                              
  0 as BillType, 37 as billid,                         
ItemID,null,T2.Name, null,null,(-100*T1.PayFund/taxrate ) ,1  ,                                                       
0,convert(decimal(15,2),-100*T1.PayFund/taxrate )as TaxAmt ,convert(decimal(15,2),-100*T1.PayFund/taxrate ) as amt, 0 as AdjustFund ,  taxrate/100 as TaxRate ,                                                   
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                  
  '税金: '+convert(varchar(20),convert(decimal(15,2),-100*T1.PayFund/taxrate ) )          ,                            
T1.OutDate,T1.BillTime   ,(-100*T1.PayFund/taxrate )                         
from fn_shldout T1                                                
join fn_item    T2 on t1.itemid=t2.code                                                                
where   T2.code='011201'  and  ClientID=@ClientID   and IsReturnTaxAmt=1 and isnull(TaxRate,0)<>0    and FpID is null --  and IsChk=1             
                                                  
-- select top  1 * from fn_shldout                                                           
                      
                                 
--UPDATE #TmpInvoice SET FntClr='Clred' where FpID is not null                                                                
/*                                         
if @filter='已开票'                                                                
begin                                                                
 select *from #TmpInvoice where  FpID is not null                                                 
end                                                                
if @filter='未开票'                                                                
begin                    
 select *from #TmpInvoice where  FpID is  null                                                                
end                                        
*/                                                                
declare @i int                                                        
set @i=0                                                        
update #TmpInvoice set @i=@i+pk, pk=@i                                                        
                                    
declare  @OwnInvQty  decimal(19,2)                
                                    
select @OwnInvQty= isnull(sum(isnull(amt,0) ),0) from #TmpInvoice                    
                
 if exists(select *,@OwnInvQty as OwnInvQty from #TmpInvoice   where rmninvqty>qty or (rmninvqty<0 and qty>0))    
 begin    
select  '有记录未开金额不对' as billnote  -- where rmninvqty<=qty    -- order by     billtime         
           
    
 return 0    
 end    
select *,@OwnInvQty as OwnInvQty from #TmpInvoice  -- where rmninvqty<=qty    -- order by     billtime         
           
/*          
select * from #TmpInvoice  where rmninvqty>qty or rmninvqty<0   
   select sum(amt) from #TmpInvoice          
union all                                         
select max(pk)+1 pk,null TableName,'欠票合计',null code,null Billtype,null billid,null dlId,null WareId,null PartNo,null Brand,                
null Pack,isnull(sum(isnull(amt,0) ),0) Qty,1 Price,null WareFund,null TaxAmt,isnull(sum(isnull(amt,0) ),0),null AdjustFund,null taxrate,null Cost,null FpID,null AccountItemID,                
null FntClr,-1 Input,'' Note,null FDate,getdate() Billtime,null RmnInvQty from #TmpInvoice                     
 order by     billtime ,code                                                                          
*/                                               
drop table #TmpInvoice                                                                 
                                        
        
        
      
    
  
