select * from fn_clntransfer


 


CREATE     proc Sp_InvoiceChk1              
@code varchar(20)            ,  
@Empid varchar(20)   
as              
         /*明细帐里  加开票标志*/    
begin tran         
 if @code<>''         
 begin        
 update TinvoiceMsg set chkmanid=@Empid,IsChk=1,Chktime=GetDate()   where code=@code     
    
--select *From     TinvoiceMsgDL    
         
-- update fn_shldin   set IsChk=1,Chktime=  IsNull(ChkTime,GetDate()) where FpID=@code  and ISchk=0        
-- update fn_shldOut  set IsChk=1,Chktime=IsNull(ChkTime,GetDate())   where FpID=@code  and ISchk=0         
 end          
          
commit tran        
        
if @@error<>0         
begin        
 raiserror('发票审核错误',16,1)        
 rollback           
end        
          


go

CREATE     proc Sp_InvoiceChk0              
@code varchar(20)              
as              
if exists(select 1 from TinvoiceMsg where code=@code and isnull(Ncode,'')<>'')              
begin           
 RAISERROR('该发票已被负发票冲消，不能弃审', 16, 1)          
 return  0          
end          
if exists(select * from TFormalInvoiceM  where PreInvoiceCode=@code  )      
begin           
 RAISERROR('正式发票已开，不能弃审', 16, 1)          
 return  0          
end       
      
update TinvoiceMsg set IsChk=0,chkmanid=null,chktime=null where code=@code              
  return 1          
          


go

sp_helptext sp_addtaxamt

alter proc sp_AddTaxAmt          
@abortstr as   varchar(50) output,                          
@whid as varchar(50),                            
@code as varchar(50)              
               
as                            
                                                         
   /*                      
select *From sl_invoiceDL          
alter table sl_invoiceDL add  InvQty decimal(19,5)          
alter table sl_invoiceDL drop column RmnInvQty           
          
select *From sl_invoiceDLdiscard          
alter table sl_invoiceDLdiscard add InvQty decimal(19,5)          
select *From  TinvoiceMsgDL          
*/          
  if @code=''      
begin      
 set @abortstr='单号不能为空'  
 return 0       
end      
      
begin tran       
  /*    
declare @code as varchar(50)          
set @code='ii00000238'      
*/    
declare @SumInvQty decimal(19,6)              
declare @CurInvQty decimal(19,6)                  
declare @fpID      varchar(20)        
        
        
select itemtablebillcode,dlid into #billCode from TinvoiceMsgDL where code=@Code        
      
      
select  sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode,A.dlid into #slBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode   and A.dlid=b.dlid      
group by B.itemtablebillcode    ,A.dlid         
      
select *From #slBillInvFund      
                
  
  
/*  
if exists(select *  
from sl_invoiceDL A        
join #slBillInvFund    b on A.invoiceid=b.itemtablebillcode and A.dlid =B.dlid  and invqty>= isnull(b.invQty,0) )  
begin  
     set @abortstr='发单明细的开票数不对'  
     return 0  
end  
else*/  
begin  
       
     update sl_invoiceDL set  fpid=@code ,invqty=isnull(b.invQty,0)-- -b.qty        
     --SELECT a.INVQTY,b.QTY        
     from sl_invoiceDL A        
     join #slBillInvFund    b on A.invoiceid=b.itemtablebillcode and A.dlid =B.dlid       
     --where B.code=@code  and Itemtablename='sl_invoicedl'        
end  
             
drop table #slBillInvFund      
      
/*      
select *from   sl_invoiceDL      
 update sl_invoiceDL set FpID=@code  ,InvQty  =isnull(InvQty,0)+M2.qty                    
 from sl_invoiceDL M1 ,TinvoiceMsgDL M2                           
where M1.InvoiceID=M2.ItemTablebillcode and m2.code=@code  and m1.dlid=M2.Dlid and Itemtablename='sl_invoicedl'                       
   */        
  
                     
 update sl_returnDL   set FpID=@code                         
 from sl_returnDL M1 ,TinvoiceMsgDL M2                           
where M1.ReturnID=M2.ItemTablebillcode and m2.code=@code and m1.dlid=M2.Dlid   and Itemtablename='sl_returnDL'                        
                                         
            
--select top 1 * from fn_shldin            
--select top 1 * from fn_shldout                    
--select * from   TinvoiceMsgDL            
                      
 --alter table fn_shldin drop column  RmnInvQty           
--alter table fn_shldin add  InvQty decimal(19,5)          
          
      
      
select sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode into #fnBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode        
group by B.itemtablebillcode        
         
select * from #fnBillInvFund        
      
/*        
update fn_shldin set  invqty= isnull(B.Qty,0)-- -B.Qty        
from fn_shldin A        
join TinvoiceMsgDL    b on A.code=b.itemtablebillcode        
where b.code=@code  and Itemtablename='fn_shldin'       
  */      
  
/*  
if exists(select *  
          from fn_shldin A        
          join #fnBillInvFund    b on A.code=b.itemtablebillcode where   invqty>= isnull(B.invQty,0)   )  
begin  
        set @abortstr='应收单的开票数不对'  
        return 0  
end  
else*/  
begin    
          update fn_shldin set  invqty= isnull(B.invQty,0)-- -B.Qty        
          from fn_shldin A        
          join #fnBillInvFund    b on A.code=b.itemtablebillcode        
end      
  

drop table #fnBillInvFund      
--where b.code=@code  and Itemtablename='fn_shldin'       
      
/*      
 update fn_shldin   set FpID=@code  , InvQty  =isnull(InvQty,0)+M2.qty                  
 from fn_shldin M1 ,TinvoiceMsgDL M2                  
where M1.Code=M2.ItemTablebillcode and m2.code=@code and Itemtablename='fn_shldin'      
      
select * from   fn_shldin           
  */      
          
 update fn_shldout   set FpID=@code                         
 from fn_shldout M1 ,TinvoiceMsgDL M2                  
where M1.Code=M2.ItemTablebillcode and m2.code=@code and Itemtablename='fn_shldout'             
            
 

--new clt transfer    
select sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode into #fnCltTrBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode        
group by B.itemtablebillcode

update fn_clntransfer set  invqty= isnull(B.invQty,0)-- -B.Qty        
from fn_clntransfer A        
join #fnCltTrBillInvFund    b on A.code=b.itemtablebillcode        and A.istax=1
        

  drop table #fnCltTrBillInvFund
  drop table #billCode      


           
commit tran       
return 1                     
      
if @@error <>0       
begin      
rollback      
return 0      
end      
      
      
    
  
      
    
  
go

alter PROCEDURE dbo.SP_InvoiceDlt                    
                 @AbortStr varchar(50) output ,                     
                 @EmpId varchar(20),                    
                 @Code varchar(20)                    
as            
set @AbortStr=''        
if @code=''           
begin        
set @AbortStr='单号空，请先刷新'        
return 0         
end        
        
        
--declare           @Code varchar(20)          
--  set @Code='ii00000195'        
        
declare @SumInvQty decimal(19,6)              
declare @CurInvQty decimal(19,6)                  
declare @fpID      varchar(20)        
        
        
select itemtablebillcode into #billCode from TinvoiceMsgDL where code=@Code        
        
--drop table #billCode        
select *from #billCode        
set @AbortStr=''        
               
  begin tran                
if not exists(select  * From TinvoiceMsg where IsChk=1 and code=@code)                   
begin                  
        
        
        
select  sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode,a.dlid into #slBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode        
group by B.itemtablebillcode   ,a.dlid      
        
select * from #slBillInvFund        
--select * From sl_invoiceDL        
--select * From TinvoiceMsgDL          
      
  
if exists(select * from sl_invoiceDL A        
          join TinvoiceMsgDL    b on A.invoiceid=b.itemtablebillcode and a.dlid    =b.dlid    
          where B.code=@code and a.invQty<b.qty  )  
begin        
           set @AbortStr='弃单出错，销售明细中已开票数量小于 明细数量'        
          -- return 0         
end     
else  
  
          update sl_invoiceDL set  invqty=isnull(a.invQty ,0)-b.qty            
          from sl_invoiceDL A        
          join TinvoiceMsgDL    b on A.invoiceid=b.itemtablebillcode and a.dlid    =b.dlid    
          where B.code=@code        
/*      
update sl_invoiceDL set  invqty=qty -b.invqty        
--SELECT a.INVQTY,b.QTY        
from sl_invoiceDL A        
join #slBillInvFund B     on A.invoiceid=b.itemtablebillcode        
--where B.code=@code        
*/        
update sl_invoiceDL set  fpid=null        
from sl_invoiceDL A        
join TinvoiceMsgDL    b on A.invoiceid=b.itemtablebillcode        
where B.code=@code and isnull(A.invqty,0)=0        
        
select A.* from sl_invoiceDL A        
join TinvoiceMsgDL    b on A.invoiceid=b.itemtablebillcode        
where b.code=@code        
        
drop table #slBillInvFund        
        
        
                
        
 /*          
select case when invqty=b.qty then null else fpid end as Fpid          
          From sl_invoiceDL A        
   join TinvoiceMsgDL B on A.invoiceid=B.itemtableBillcode        
   where B.code='II00000160'        
*/        
                        
        
  update sl_returnDL   set FpID=null                        
  from sl_returnDL M1 ,TinvoiceMsgDL M2                       
 where M1.ReturnID=M2.ItemTablebillcode and m2.code=@code                      
                         
        
         
        
        
select sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode into #fnBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode        
group by B.itemtablebillcode        
        
        
select * from #fnBillInvFund        
        
      
if exists(select * from fn_shldin A        
          join TinvoiceMsgDL    b on A.code=b.itemtablebillcode        
          where b.code=@code  and  A.invqty< B.Qty  )  
begin        
          set @AbortStr='弃单出错，应收单中已开票数量小于 明细数量'        
          --return 0         
end     
else  
          update fn_shldin set  invqty= A.invqty -B.Qty        
          from fn_shldin A        
          join TinvoiceMsgDL    b on A.code=b.itemtablebillcode        
          where b.code=@code        
  
/*        
update fn_shldin set  invqty= payFund-B.invQty        
from fn_shldin A        
join #fnBillInvFund    b on A.code=b.itemtablebillcode        
--where b.code=@code        
*/      
update fn_shldin set  fpid=null        
from fn_shldin A        
join TinvoiceMsgDL    b on A.code=b.itemtablebillcode        
where b.code=@code and isnull(A.invqty,0)=0        
        
drop table #fnBillInvFund        


update fn_shldout  set FpID=null where FpID=@code             
       

--new clt transfer   update  fn_clntransfer set invqty=0 where code='fc00002788'
-- select * From fn_clntransfer where code='fc00002788'
-- select top 20 * from TinvoiceMsgDL where code ='II00004062'  and itemtablebillcode='fc00002788'  and itemtablename ='fn_clntransfer'
select sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode into #fnCltTrBillInvFund        
from TinvoiceMsgDL A        
join #billCode     B on B.itemtablebillcode=A.itemtablebillcode        
group by B.itemtablebillcode

--update fn_clntransfer set  invqty=isnull( (select isnull(B.invQty,0) from #fnCltTrBillInvFund where  code=b.itemtablebillcode  ),payfund)where  A.istax=1      


drop table #fnCltTrBillInvFund


drop table #billCode        
        
         
      
     insert into TinvoiceMsgDisCard                  
      select Code,InvCode,InvDate,InvFund,   WareFund,TaxFund,InvName,ClientID,ClientName,   Note,BillManID,Billtime,IsChk,ChkTime,   ChkManID,@EmpId,getdate()               
  from TinvoiceMsg where code=@code                  
                  
              
     insert into TinvoiceMsgDisCardDL                  
 select FromPK,Code,ItemTableName,ItemTableBillcode,   Dlid,wareid,model,partNo,pack,   Brand,qty,Price,WareFund,Taxamt,   TaxRate,AccountNo,note   from TinvoiceMsgDL where code=@code             
              
                
     delete TinvoiceMsgDL where code=@code                  
     delete TinvoiceMsg where code=@code            
                             
--     delete fn_shldin where FpID=@code               
--     delete fn_shldout where FpID=@code                   
          
        
end                  
  commit tran            
       
if @@error<>0           
begin          
 drop table #slBillInvFund        
 drop table #fnBillInvFund        
 drop table #billCode        
  set @AbortStr='弃单时出现错误!'                    
  rollback           
  return 0         
end      
     
  return 1         


go

/*select * from crm_client where nickname='xsh'      
      
InvoiceInput_UnCom 'HZ000012'      
*/      
      
alter     proc InvoiceInput_UnCom                                           
@ClientID varchar(20)                                                                  
--,@filter   VarChar(10)                                                                  
as                                                                  
                                                                  
      /*              select * From crm_client    where nickname like '%xdy%'                                    
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
 '应收税金 '  +convert(varchar(10),T1.PayFund ) as BillNote,             T1.Code,                                                  
   0 as BillType, 36 as billid,                       
             
ItemID,null,T2.Name, null,null,convert(decimal(15,5),100*T1.PayFund/taxrate )as TaxAmt ,1  ,  
                                                         
0,convert(decimal(15,5),100*T1.PayFund/taxrate )as WareFund ,convert(decimal(15,5),100*T1.PayFund/taxrate ) as amt, 0 as AdjustFund ,  taxrate/100 as TaxRate ,      
          
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                       
  '税金: '+convert(varchar(20),convert(decimal(15,5),100*T1.PayFund/taxrate ) )          ,                              
T1.InDate,T1.BillTime          ,     convert(decimal(15,5), (100*T1.PayFund/taxrate)-isnull(InvQty,0)) as RmnInvQty                    
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
ItemID,null, '应收 '+T2.Name, null,null,convert(decimal(15,5),T1.PayFund ) ,1  ,                                                         
0,0 TaxAmt ,convert(decimal(15,5),T1.PayFund ) as amt, 0 as AdjustFund ,  0 as TaxRate ,                                                     
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                       
  '应收 '+T2.Name,                               
T1.InDate,T1.BillTime ,                  convert(decimal(15,5), PayFund-isnull(InvQty,0))   as RmnInvQty      
                           
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
 0 as BillType, 36 as billid,                          ItemID,null, '应收 '+T2.Name, null,null,convert(decimal(15,5),T1.PayFund ) ,1  ,                                                         
  
0,0 TaxAmt ,convert(decimal(15,5),T1.PayFund ) as amt, 0 as AdjustFund ,  0 as TaxRate ,                                                     
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                                       
  '应收 发票调整',                               
T1.InDate,T1.BillTime ,                  convert(decimal(15,5), PayFund-isnull(InvQty,0)   ) as RmnInvQty                               
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
'应付 发票调整',                           T1.OutDate,T1.BillTime    ,-T1.PayFund                                    
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
ItemID,null,T2.Name, null,null,(-100*T1.PayFund/taxrate ) ,1 ,                                         
                  
0,convert(decimal(15,5),-100*T1.PayFund/taxrate )as TaxAmt ,convert(decimal(15,5),-100*T1.PayFund/taxrate ) as amt, 0 as AdjustFund ,  taxrate/100 as TaxRate ,           
                                            
null , T1.FpID , T2.code,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input,                    
  '税金: '+convert(varchar(20),convert(decimal(15,5),-100*T1.PayFund/taxrate ) )          , T1.OutDate,T1.BillTime   ,convert(decimal(15,5), (-100*T1.PayFund/taxrate )  )                         
from fn_shldout T1                                                  
join fn_item    T2 on t1.itemid=t2.code                                                                  
where   T2.code='011201'  and  ClientID=@ClientID   and IsReturnTaxAmt=1 and isnull(TaxRate,0)<>0    and FpID is null --  and IsChk=1               
                                                    
union all                                  

select 
1 as pk, 'fn_clntransfer' as TableName,  '转入 '+convert(varchar(10), PayFund )  as BillNote,code,
0  as billtype,27 as billid,  
null,null,null,null,null,PayFund,1 as price,
0,  0,PayFund,PayFund,0,
null, PFpID ,code  ,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input, 

null , Trnsfrdate, billtime,  convert(decimal(15,5), PayFund-isnull(InvQty,0)   ) as RmnInvQty                                
 from fn_clntransfer where InId =@ClientID     and IsTax =1    and ischk=1   and PayFund<>isnull(InvQty,0)
union all                                  

select 
1 as pk, 'fn_clntransfer' as TableName,  '转出 '+convert(varchar(10), PayFund )  as BillNote,code,
0  as billtype,27 as billid,  
null,null,null,null,null,-PayFund,1 as price,
0,  0,-PayFund,-PayFund,0,
null, NFpID ,code  ,case when IsChk=1  then 'clblue' else  'clred' end AS FntClr,1 as Input, 

null , Trnsfrdate, billtime,  -  PayFund  as RmnInvQty                                
 from fn_clntransfer  where OutId =@ClientID and IsTax =1 and ischk=1 and     NFpID is null                  

-- select top  1 * from fn_clntransfer                                                             
  -- select   * from      fn_shldin
                                   
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
                                      
declare  @OwnInvQty  decimal(19,5)                  
                                      
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
                                          
          
          
        
      
    
  

              
  
