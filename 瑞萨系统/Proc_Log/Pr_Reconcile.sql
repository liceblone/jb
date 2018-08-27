create proc Pr_Reconcile                    
@Abortstr  varchar(30) output,                    
@Warningstr  varchar(30) output,       
            
@FCode varchar(30),                    
@FCltVdCode varchar(30),                    
@FReconcileFlag varchar(20) ,                    
@FBillCode varchar(20),                    
@FinvCode  varchar(20)   ,                    
@FEmpCode  varchar(30)                   
                    
as          
      
set @Abortstr  =''      
set @Warningstr=''         
  /*                
declare                   
@FEmpCode  varchar(30),                    
@FCode varchar(30),                    
@FCltVdCode varchar(30),                    
@FReconcileFlag varchar(20) ,                    
@FBillCode varchar(20),                    
@FinvCode  varchar(20)                    
                  
set @FEmpCode  ='E000010'                    
set @FCode ='ShRP001706'                  
set @FCltVdCode ='C0000025'                   
set @FReconcileFlag =''                  
set @FBillCode ='MLO00000575'                  
set @FinvCode  ='Inv00000424'                   
*/                  
                  
declare @ReconcileTime  smalldatetime                    
declare @FReconciled bit                     
declare @error int                                 
                   
set @error =0                                
set @FReconciled=0                    
set @ReconcileTime  =getdate()                    
                    
if isnull( @FReconcileFlag,'')<>'' set @FReconciled =1                    
                    
set @FReconciled=  ( @FReconciled^1)                    
if  @FReconciled<>1  set @FEmpCode  =null                    
if  @FReconciled<>1  set @ReconcileTime  =null                     
                    
                  
begin tran                  
                  
update TPayReceive     set  FReconciled=@FReconciled ,FReconcileEmp=@FEmpCode , FReconcileTime= @ReconcileTime  where FRpCode=@FCode                    
set @error =@error +@@error                                  
                                              
if isnull(@FBillCode,'')=''                    
begin                  
   update TPayReceiveAble set  FReconciled=@FReconciled ,FReconcileEmp=@FEmpCode , FReconcileTime= @ReconcileTime  where FShRpCode=@FCode                    
   set @error =@error +@@error                                                            
end                  
else                    
begin                    
   update Twhindl   set  FReconciled=@FReconciled ,FReconcileEmp=@FEmpCode , FReconcileTime= @ReconcileTime  where FWhinCode =@FBillCode  and  FinvCode=@FinvCode                    
   set @error =@error +@@error                                  
                  
   update Twhoutdl set  FReconciled=@FReconciled ,FReconcileEmp=@FEmpCode , FReconcileTime= @ReconcileTime  where FWhoutCode =@FBillCode and  FinvCode=@FinvCode                   
   set @error =@error +@@error                                  
                  
   select FwhinCode as FBillCode , FReconciled into #tmp from Twhindl where FwhinCode =@FbillCOde   union all select FWhoutCode as FBillCode , FReconciled from Twhoutdl where FWhoutCode=@FBillCode                       
   set @error =@error +@@error                                  
--  select *from #tmp                  
        if      not exists(   select *from #tmp where   FReconciled is null    )          and (  (select count(*) from #tmp)>0  )                    
        begin                    
             update TPayReceiveAble set  FReconciled=@FReconciled ,FReconcileEmp=@FEmpCode , FReconcileTime= @ReconcileTime  where FShRpCode=@FCode                      
        end                     
        else                    
            update TPayReceiveAble set  FReconciled= null ,FReconcileEmp= null  , FReconcileTime= null  where FShRpCode=@FCode                    
                  
        set @error =@error +@@error                                  
                   
   drop table #tmp           
end                    
                    
              
              
select idl.FMainQty*idl.Fprice*isnull(FistDebitCredit,1) as Famt ,M.FWhinCode as FBillCode    into #Tio              
 From Twhindl  idl                     
 join Twhin M   on  M.FwhinCode=idl.FwhinCode   and M.FVendorCode=  @FCltVdCode  and idl.FReconciled=1                  
left  join TinOutType itp on itp.FinOutTypeCode=M.FinOutTypeCode                         
       -- where M.FWhinCode =@FBillCode               -- fix bug 2011-5-4        
union all                     
select odl.FOutQty*odl.Fprice*isnull(FistDebitCredit,1) as Famt  ,M.FWhOutCode as FBillCode                  
 From TWhOutDL odl                     
 join TwhoutM M on  M.FWhOutCode=odl.FwhoutCode   and M.FCltVdCode=  @FCltVdCode and odl.FReconciled=1                  
left  join TinOutType itp on itp.FinOutTypeCode=M.FinOutTypeCode          --   where M.FWhOutCode =@FBillCode               
              
              
 select -1*Famt  as FAmt into #TAmt from TPayReceive where FReconciled=1 and FCltVdCode=@FCltVdCode                  
union all                   
 select isnull(Tio.Famt,0)   from   #Tio  Tio                
union all               
 select  isnull( A.famt, 0 )               
 from TPayReceiveAble A                    
 where A.FReconciled=1 and   A.FCltVdCode=  @FCltVdCode                
 and not exists(select FBillCode from #Tio where FBillCode=A.FbillCode  )              
 set @error =@error +@@error                                  
                  
                  
 update TCltVdBookkeeping set FCurReconciledAmt=( select sum(FAmt)  from #TAmt) ,FReconcileTime=getdate() where   FCltVdCode=  @FCltVdCode                  
set @error =@error +@@error                                  
              
              
drop table #Tio                  
drop table #TAmt                  
                  
if @error<>0                                   
begin                                  
  raiserror('∂‘’  ß∞‹'  ,16,1)                  
  rollback                                   
                  
end                    
                  
commit tran                  
                  
return 1                  
--select * from Twhin                  
--select * From TPayReceiveAble                  FUltimoBalce
    
    
 ------------------------------------------------------------------------------------  
