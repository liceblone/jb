 

--销售发货单  update 
alter  PROCEDURE [sl_invoice_bfrpst]                         
                 @Result varchar(250) output,                        
                 @warningstr varchar(250) output,                        
                 @LoginId varchar(20),                        
                 @PayFund Money,                        
                 @BankId varchar(20),                        
                 @PayeeId varchar(20),                        
                 @GetFund Money,                        
                 @OtherFund Money,                        
                 @WareFund Money,                        
                 @PayModeId varchar(20),                        
                 @Code varchar(20)  ,                      
                 @isTax bit         ,        
                 @InvoiceDate     smalldatetime  ,      
                 @islock    bit     
               ,    @clientID  varchar(20)  
                      
AS                        
      
  set @warningstr=''  
if isnull(@islock,0)='1'      
begin      
    set @Result='发货单: 已经被锁定不能更改'                        
  return 0         
end      
        --去掉 @PayeeId    折扣率不能大于3%,超过500元              
                    
if (@GetFund-@OtherFund)/@WareFund<0.97 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                         
  set @Result='对不起,折扣率不能大于3%,请与管理员联系.'                        
  return 0                        
end                        
if @WareFund-(@GetFund-@OtherFund)>500 and (select IsAdmin from sys_user where LoginId=@LoginId)<>1 begin                         
  set @Result='对不起,折扣金额不能超过500元,请与管理员联系.'                        
  return 0                        
end                        
if (isnull(@PayFund,0)<>0) and (isnull(@BankId,'')=''or isnull(@PayModeId ,'')='')            
begin                        
  set @Result='对不起,在 <本单已收> 不为0时,您必需填写<收款方式>和<收款帐户>.'                        
  return 0                        
end                        
            
if (isnull(@PayFund,0)=0) and (isnull(@BankId,'')<>''or isnull(@PayModeId ,'')<>'')            
begin                        
  set @Result='对不起,在 <本单已收> 为0时,您不需填写<收款方式>和<收款帐户>.   如要清除<收款帐户>请按Delete'             
  return 0                        
end                        
                        
if exists(select 1 from sl_invoice where Code=@Code and FnIsChk=1 and (PayFund<>@PayFund or BankId<>@BankId))                        
begin                        
  set @Result='对不起,本单收款已经财务审核通过,您不能再修改<本单已收>及<收款帐户>！'                        
  return 0                        
end                        
                        
if (@GetFund  <>@WareFund+@OtherFund)       --2007-6-30  ori   if @isTax=1 and (@GetFund  <>@WareFund+@OtherFund)           
begin                      
  set @Result='发货单: 实际应收=货款+其它'                        
  return 0                        
end                      
        
if @InvoiceDate>getdate()        
begin        
  set @Result='发货不能大于当前日期'                        
  return 0             
end        
  
 if exists(select *from crm_client where code =@clientid and isnull(CreditLine,0)<>0 and isnull(debt,0)+ @GetFund>isnull(CreditLine,0) )  
 begin  
 set @warningstr='已经超过欠款额度,是否还要保存？'                        
 return 0   
end   
 

select @Result= partno+'   '+ pack+'   '+isnull(brand,'') From sl_invoicedl where invoiceid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @Result<>''
begin  
   set @Result=@Result+char(13)+' 该资料已经被停用请联系管理员    '
  return 0  
end  
  return 1                      
            
--select *From crm_client  
        
        
         
      
    
  
            
      
    

go

--销售退货单  update 
 alter PROCEDURE [sl_return_bfrpst]   
                 @AbortStr varchar(250) output,  
                 @WarningStr varchar(250) output,  
                 @WareFund Money,  
                 @OtherFund Money,  
                 @GetFund Money  ,
                 @Code    varchar(20) 
  
AS  
  
  
set @AbortStr=''  
set @WarningStr=''  
  
if (@GetFund=0) or (@GetFund is null)  
begin  
  set @WarningStr='提示: 您确定<实际应付>为 0 吗?'  
  return 0  
end  
else if @GetFund>@WareFund+@OtherFund   
begin  
  set @WarningStr='提示: <实际应付>大于<货款+其它支出>,仍要继续保存吗>?'  
  return 0  
end  
 


 
select @AbortStr= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From sl_returndl  where returnid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @AbortStr<>''
begin  
   set @AbortStr=@AbortStr+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end    

 
  return 1

  go

--零售单   add 
 

 

alter PROCEDURE [sl_retail_bfrpst]   
                 @Result varchar(250) output,  
                 @LoginId varchar(20),  
                 @GetFund Money,  
                 @WareFund Money,  
                 @Code varchar(20),  
                 @BankId varchar(20)  
AS  
  
if (@GetFund/@WareFund<0.95) and (select IsAdmin from sys_user where LoginId=@LoginId)<>1   
begin   
  set @Result='对不起,折扣率不能大于5%,请与管理员联系.'  
  return 0  
end  
  
if exists(select 1 from sl_retail where Code=@Code and FnIsChk=1 and (GetFund<>@GetFund or BankId<>@BankId))  
begin  
  set @Result='对不起,本单收款已经财务审核通过,您不能再修改<本单收款>！'  
  return 0  
end  
  
-- select top 1 partno+'   '+ pack+'   '+isnull(brand,'') From sl_retaildl where retailid=  @Code 
select @Result= partno+'   '+ pack+'   '+isnull(brand,'') From sl_retaildl where retailid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @Result<>''
begin  
   set @Result=@Result+char(13)+' 该资料已经被停用请联系管理员    '
  return 0  
end  
  
  return 1


--select  partno+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From ph_arrivedl
-- where arriveid=  'PA00015571' and wareid in (select id from wr_ware where isnull(isuse,0)=0)

go
--采购到货单   add WareFund,OtherFund,GetFund,TaxRate
 
alter PROCEDURE [ph_arrive_bfrpst]   
                 @AbortStr varchar(250) output,  
                 @WarningStr varchar(250) output,  
                 @WareFund Money,  
                 @OtherFund Money,  
                 @GetFund Money,  
                 @TaxRate Money ,
                 @Code    varchar(20)
AS  
set @AbortStr=''  
set @WarningStr=''  
  

select @AbortStr= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From ph_arrivedl where arriveid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @AbortStr<>''
begin  
   set @AbortStr=isnull(@AbortStr,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end   

if @TaxRate is null   
begin  
  set @AbortStr='对不起,决对不匀许税率为空,如果没有请务必填0,谢谢合作.'  
  return 0  
end  
else if (@GetFund=0) or (@GetFund is null)  
begin  
  set @WarningStr='提示: 您确定<实际应付>为 0 吗?'  
  return 0  
end  
else if @GetFund>@WareFund+@OtherFund   
begin  
  set @WarningStr='提示: <实际应付>大于<货款+其它支出>,仍要继续保存吗>?'  
  return 0  
end  
 
 
return 1





go
--采购退货单  add  
create  proc  Pr_phReturnBFP          
@abortstr varchar(100) output,            
@worningstr varchar(100) output,             
@code  varchar(20)   
as
begin
set @abortstr=''          
set @worningstr=''

--select returnid,*from  ph_returndl

select @AbortStr= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From ph_returndl where returnid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @AbortStr<>''
begin  
   set @AbortStr=isnull(@AbortStr,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end

return 1
  
end

go

--入库单  add  

alter  PROCEDURE [wh_in_bfrpst]         
                 @Result varchar(250) output,        
                 @InTypeId varchar(20),        
                 @ClientId varchar(20)  ,      
                 @TaxRate  decimal(19,6) ,  
                 @InDate   smalldatetime  ,
                 @code     varchar(20) 
AS        
        
if (@InTypeId='I08' or @InTypeId='I09') and ((@ClientId is null) or @ClientId='')         
begin        
  set @Result='对不起! 存盘失败: 客户编号不能为空,请补充后再存盘.'        
  return 0        
end        
if (@InTypeId<>'I08'   and isnull(@TaxRate,0)<>0 )         
begin        
  set @Result='对不起! 只有同行借调入库才可以填税率。'        
  return 0        
end          
      
if (@InTypeId='I08'   and (isnull(@TaxRate,0)<0  or isnull(@TaxRate,0)>1) )         
begin        
  set @Result='请填写正确的税率。'        
  return 0        
end          
      
if @InDate>getdate()  
begin  
  set @Result='入库日期不能大于当前日期'        
  return 0   
end   

--select * from wh_indl

select @Result= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From wh_indl where inid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @Result<>''
begin  
   set @Result=isnull(@Result,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end

return 1      
      
     
  

--出库单  add  

 
go

alter PROCEDURE [wh_out_bfrpst]     
                 @Result varchar(250) output,    
                 @OutTypeId varchar(20),    
                 @ClientId varchar(20)  ,  
                 @OutDate  smalldatetime  ,
                 @code     varchar(20)
    
AS    
    
if (@OutTypeId='X08' or @OutTypeId='X09') and ((@ClientId is null) or @ClientId='')     
begin    
  set @Result='对不起! 存盘失败: 客户编号不能为空,请补充后再存盘.'    
  return 0    
end    
    
  
if @OutDate>getdate()  
begin  
  set @Result='出库日期不能大于当前日期'    
  return 0   
end  

--select *From  wh_outdl

select @Result= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From wh_outdl  where  Outid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)
if @Result<>''
begin  
   set @Result=isnull(@Result,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end



return 1  
  

--本地调拨   add 

---sp_helptext sp_whmoveBFp


 
go

alter proc sp_whmoveBFp  
@Result    varchar(250) output,                    
@movedate smalldatetime  ,
@code     varchar(20)
                  
AS     
  
if @movedate>getdate()    
begin    
  set @Result='发货不能大于当前日期'                    
  return 0         
end    

--select * from wh_movedl
 
select @Result= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From wh_movedl   where  MoveID=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)

if @Result<>''
begin  
   set @Result=isnull(@Result,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end

  return 1                  
        


go
--异地调拨  add 
--select * from jingbeiNewsys.dbo.wh_attemper
--select Attemperid,* from jingbeiNewsys.dbo.wh_attemperDL



create proc sp_wh_attemperBFP  
@Result    varchar(250) output,    
@code     varchar(20)
as

--select  isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From jingbeiNewsys.dbo.wh_attemperDL   where  Attemperid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)


select @Result= isnull(partno,'')+'   '+ isnull(pack,'')+'   '+isnull(brand,'') From jingbeiNewsys.dbo.wh_attemperDL   where  Attemperid=  @Code and wareid in (select id from wr_ware where isnull(isuse,0)=0)

if @Result<>''
begin  
   set @Result=isnull(@Result,'')+char(13)+' 该资料已经被停用请联系管理员    '
   return 0  
end

  return 1    