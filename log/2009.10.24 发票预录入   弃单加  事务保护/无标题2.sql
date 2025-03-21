alter PROCEDURE dbo.SP_InvoiceDlt                        
                 @AbortStr varchar(50) output ,                         
                 @EmpId varchar(20),                        
                 @Code varchar(20)                        
as                
declare @ErrorNo int 


set @ErrorNo =0
set @AbortStr=''            
if @code=''               
begin            
set @AbortStr='单号空，请先刷新'            
return 0             
end                        
            
 --   declare           @Code varchar(20)              
--  set @Code='ii00004109'            
            
declare @SumInvQty decimal(19,6)                  
declare @CurInvQty decimal(19,6)                      
declare @fpID      varchar(20)            
declare @clientid  varchar(20)            
            
select @clientid  = clientid   from TinvoiceMsg  where code=@Code    
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
          set @ErrorNo =@ErrorNo+@@error
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
set @ErrorNo =@ErrorNo+@@error
            
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
  set @ErrorNo =@ErrorNo+@@error
                       
            
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
   rollback               
   return 0                
end         
else      
          update fn_shldin set  invqty= A.invqty -B.Qty            
          from fn_shldin A            
          join TinvoiceMsgDL    b on A.code=b.itemtablebillcode            
          where b.code=@code            
          set @ErrorNo =@ErrorNo+@@error
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
set @ErrorNo =@ErrorNo+@@error

drop table #fnBillInvFund               
    
update fn_shldout  set FpID=null where FpID=@code                 
set @ErrorNo =@ErrorNo+@@error
    
    
     insert into TinvoiceMsgDisCard                      
     select Code,InvCode,InvDate,InvFund,   WareFund,TaxFund,InvName,ClientID,ClientName,   Note,BillManID,Billtime,IsChk,ChkTime,   ChkManID,@EmpId,getdate()                   
     from TinvoiceMsg where code=@code                      
                                       
     insert into TinvoiceMsgDisCardDL                      
     select FromPK,Code,ItemTableName,ItemTableBillcode,   Dlid,wareid,model,partNo,pack,   Brand,qty,Price,WareFund,Taxamt,   TaxRate,AccountNo,note   from TinvoiceMsgDL where code=@code                 
                                      
     delete TinvoiceMsgDL where code=@code                      
     set @ErrorNo =@ErrorNo+@@error
     delete TinvoiceMsg where code=@code                
     set @ErrorNo =@ErrorNo+@@error                                 
/*    
select invqty,istax, * from fn_clntransfer where  istax=1              
--new clt transfer   update  fn_clntransfer set invqty=0 where code='fc00002788'    
-- select * From fn_clntransfer where code='fc00002788'       
  select * from  fn_clntransfer where code='FC00002793'    
  select * from  fn_clntransfer where inid='HZ000002'    
*/    
    
--转入        
 select sum(isnull(A.qty,0)) as invQty ,B.itemtablebillcode into #fnCltTrBillInvFund            
 from TinvoiceMsgDL A            
 join #billCode     B on B.itemtablebillcode=A.itemtablebillcode   AND Itemtablename='fn_clntransfer'  and  A.Qty>0    
 group by B.itemtablebillcode    
     
       --IF  EXISTS(SELECT *FROM #fnCltTrBillInvFund)    
       BEGIN    
         update fn_clntransfer set  invqty=B.invQty     
         from   fn_clntransfer A    
         left  join   #fnCltTrBillInvFund  B on b.itemtablebillcode  = A.code     
         where  A.istax=1     and A.inid=@clientid  and A.code in (select itemtablebillcode from #billCode)  
         set @ErrorNo =@ErrorNo+@@error
       END    
         
--转出    
update fn_clntransfer  set NFpID=null where NFpID=@code       
set @ErrorNo =@ErrorNo+@@error    
    
drop table #fnCltTrBillInvFund    
drop table #billCode            

end                      

commit tran                          
if @ErrorNo <>0               
begin              
  drop table #slBillInvFund            
  drop table #fnBillInvFund            
  drop table #billCode            
  set @AbortStr='弃单时出现错误!'                        
  rollback               
  return 0             
end          
         
return 1             
    
  
  
