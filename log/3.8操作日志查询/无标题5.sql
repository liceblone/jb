--select stra as code,strb as operate, strc as BillManId,begindate,enddate,strd as  F_note  from sys_finditem  where 1<>1


--code,operate,BillManId,begindate,enddate,F_note


alter proc pr_FindOperateLog
@code     varchar(20),
@operate    varchar(20),
@BillManId   varchar(20),
@begindate   smalldatetime,
@enddate     smalldatetime,
@F_note     varchar(20) 
as


 select   Code,Operate,BillManId,BillTime,F_Note 
From fn_clientdlinout_isbilLog 
   
where code like @code+'%'
and   operate like @operate +'%'
and   BillManId  like  @BillManId+'%'  
and   billtime>= @begindate  
and    billtime  <=@enddate+1  
and   F_note  like  '%'+@F_note+'%'  
 

union all 

select  '',
Optype+OpTable+ Opinterface,
OpEmp,
OpTime,
Content+place
From TOperateLog
 where  
      (Optype+OpTable+ Opinterface)  like @operate +'%'
and   OpEmp   like  @BillManId+'%'  
and   OpTime>= @begindate  
and    OpTime  <=@enddate+1  
and   Content  like  '%'+@F_note+'%'  


 