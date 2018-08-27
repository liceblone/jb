
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
  set @AbortStr='�Բ���,�����Ǳ�������Ƶ���,������ɾ��������.'  
  return 0  
end  



declare @Brief varchar(200)

--select *From fn_bnktransfer

select @Brief= 'ת��'+isnull(inid ,'')+' , '+'ת��'+isnull(outid,'') +','+ convert(varchar(20),   payfund)+','+ convert(varchar(10),TrnsfrDate ,121   ) from fn_bnktransfer   where   Code=@Code
 --       select Code,Operate,BillManId,BillTime,F_Note From fn_clientdlinout_isbilLog  where billmanid='000'
 insert into fn_clientdlinout_isbilLog    
 
 select @Code,'ɾ�� �տ' ,@BillManId ,getdate(),@Brief    
  
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
  set @AbortStr='�Բ���,�����Ǳ�������Ƶ���,������ɾ��������.'  
  return 0  
end  


declare @Brief varchar(200)

--select *From fn_clntransfer 

select @Brief= 'ת��'+isnull(inid ,'')+inName   +' , '+'ת��'+isnull(outid,'')+outName +','+ convert(varchar(20),   payfund)+','+ convert(varchar(10),TrnsfrDate ,121   ) from fn_clntransfer    where   Code=@Code
 --       select Code,Operate,BillManId,BillTime,F_Note From fn_clientdlinout_isbilLog  where billmanid='000'
 insert into fn_clientdlinout_isbilLog    
 
 select @Code,'ɾ�� �տ' ,@BillManId ,getdate(),@Brief    
  
  
return 1
