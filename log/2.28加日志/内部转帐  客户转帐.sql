
alter PROCEDURE dbo.fn_bnktrnsfr_bfrdlt  
                 @AbortStr varchar(250) output,  
                 @WarningStr varchar(250) output,    
                 @EmpId varchar(20),  
                 @BillManId varchar(20)  ,
                 @code  varchar(20)
As  
  
set @AbortStr=''  
set @WarningStr=''  
  
if @EmpId<>@BillManId  
begin  
  set @AbortStr='对不起,您不是本付款单的制单人,您不能删除本单据.'  
  return 0  
end  



declare @Brief varchar(200)

--select *From fn_bnktransfer

select @Brief= '转入'+isnull(inid ,'')+' , '+'转出'+isnull(outid,'') +','+ convert(varchar(20),   payfund)+','+ convert(varchar(10),TrnsfrDate ,121   ) from fn_bnktransfer   where   Code=@Code
 --       select Code,Operate,BillManId,BillTime,F_Note From fn_clientdlinout_isbilLog  where billmanid='000'
 insert into fn_clientdlinout_isbilLog    
 
 select @Code,'删除 收款单' ,@BillManId ,getdate(),@Brief    
  
return 1


go

alter PROCEDURE dbo.fn_clntrnsfr_bfrdlt  
                 @AbortStr varchar(250) output,  
                 @WarningStr varchar(250) output,    
                 @EmpId varchar(20),  
                 @BillManId varchar(20)   ,
                 @code  varchar(20)
As  
  
set @AbortStr=''  
set @WarningStr=''  
  
if @EmpId<>@BillManId  
begin  
  set @AbortStr='对不起,您不是本付款单的制单人,您不能删除本单据.'  
  return 0  
end  


declare @Brief varchar(200)

--select *From fn_clntransfer 

select @Brief= '转入'+isnull(inid ,'')+inName   +' , '+'转出'+isnull(outid,'')+outName +','+ convert(varchar(20),   payfund)+','+ convert(varchar(10),TrnsfrDate ,121   ) from fn_clntransfer    where   Code=@Code
 --       select Code,Operate,BillManId,BillTime,F_Note From fn_clientdlinout_isbilLog  where billmanid='000'
 insert into fn_clientdlinout_isbilLog    
 
 select @Code,'删除 收款单' ,@BillManId ,getdate(),@Brief    
  
  
return 1
