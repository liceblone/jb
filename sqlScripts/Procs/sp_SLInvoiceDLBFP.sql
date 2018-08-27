--Bank,Paymode,PayFund    
--@Bank     varchar(20) ,    
--@Paymode  varchar(20) ,    
--@PayFund  money    
alter  proc  sp_SLInvoiceDLBFP          
@abortstr varchar(100) output,            
@worningstr varchar(100) output,             
@invoiceid varchar(20)  ,            
@dlid    int    ,     
@fund    money  ,
@wareid  varchar(30),
@Price   decimal(19,6) 
    
as          
          
if @invoiceid=''           
begin          
set @abortstr='���Ų���Ϊ��'          
return 0           
end          
set @worningstr ='d'            
set @abortstr ='d'            
--select *From sl_invoice where SI00049397          
--  select *From sl_invoicedl where invoiceid='SI00049390' and dlid='147600'          
          
if  exists(select *From   sl_invoicedl where invoiceid=@invoiceid         and dlid=@dlid and isnull(InvQty,0)<>0)          
 or exists(select *from  TInvoiceMsgDL where itemtablebillcode=@invoiceid and dlid=@dlid )      
begin          
    if exists(select *From   sl_invoicedl where invoiceid=@invoiceid   and dlid=@dlid  and price*qty<>@fund)  
    begin  
        set @abortstr='����ϸ�Ѿ���Ʊ���������޸�, ���Ƚ���ƱԤ¼���� ��Ʊɾ��.'          
        return 0           
    end  
end          

if exists( select * from TParamsAndValues	where FParamCode='0101' and FParamValue=1)
if exists( select *from TPriceChangeInfo	where wareid= @wareid and @Price< isnull(MinPrice,0)   )
begin
        set @abortstr='���ۼ۸���С������޼�.'          
        return 0           
end
    
    
return 1          
          
          
    
  