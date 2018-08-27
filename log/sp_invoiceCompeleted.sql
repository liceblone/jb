alter     proc Sp_InvoiceCompeleted                  
@abortStr varchar(500) output,                  
@warningStr varchar(500)output,                  
@diff money  ,            
@invcode Varchar(20)    ,            
@code Varchar(20)  ,        
@InvFund money    ,    
@ClientID varchar  (20)  
                  
as                  
set @warningStr=''             
set @abortStr=''            
    
  
create table #OwnQty  
( pk int ,TableName varchar(30),  
billnote  varchar(30),code      varchar(30),  
Billtype  varchar(30),billid  varchar(30),  
dlId  varchar(30),WareId   varchar(30),  
PartNo   varchar(30),Brand   varchar(30),  
Pack   varchar(30),Qty    decimal(19,5),  
Price decimal(19,5),WareFund  decimal(19,5),  
TaxAmt decimal(19,5),amt decimal(19,5) ,  
AdjustFund decimal(19,5),taxrate  decimal(19,5),  
Cost  decimal(19,5),FpID  varchar(32),  
AccountItemID varchar(32),FntClr varchar(32),  
Input varchar(32),Note varchar(32),FDate varchar(32) ,  
Billtime varchar(32),RmnInvQty decimal(19,5),  
OwnInvQty decimal(19,5)  
)  
   
insert into #OwnQty exec   
InvoiceInput_UnCom @ClientID  
  
declare @OwnInvQty decimal(19,3)  
select   @OwnInvQty  =isnull(sum( isnull(RmnInvQty,0)*isnull(price,0)   ),0) From  #OwnQty  
  
drop   table #OwnQty  
  
select @OwnInvQty   
  
  
if isnull(@InvFund,0)>isnull(@OwnInvQty,0)+100  --  +convert(varchar(19),@OwnInvQty )      
begin        
 set @warningStr='欠票金额:'+convert(varchar(30),@OwnInvQty )  +char(10)+char(13)+'应开金额不能大于 欠票金额+发票调整，'  
                +char(10)+char(13)+               '发票调整不能大于100  保存中止!'        
 return 0   
end        
    
            
if @InvFund<=0         
begin        
 set @abortStr='应开金额应大于 0,  保存中止!'        
 return 0   
end        
        
if exists(select * from TinvoiceMsg where invcode=@invcode and code<>@code)            
begin            
set @abortStr='发票号重复'                  
  --set @abortStr=' 差额应该为0'                  
 return 0                  
end            
return 1                  
      
