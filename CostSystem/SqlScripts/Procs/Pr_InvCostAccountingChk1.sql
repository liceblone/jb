CREATE  proc [dbo].[Pr_InvCostAccountingChk1]                                               
@Abortstr  varchar(300) output                                                                                                                            
,@Warningstr  varchar(3000) output                                                                                                
,@FMonth smalldatetime                                                                                                 
,@FWhCode varchar(10)                                                                                                      
,@FIsAccounted varchar(10)                                                                                                      
,@FEmpCode  varchar(30)                                                                                                                                 
as                   
          
                                                                   
/*                 
              
                                                       
declare @p1 varchar(300)                                                            
set @p1=NULL                                                            
declare @p2 varchar(3000)                                                            
set @p2=NULL                                                            
exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,'2014-4-1 20:03:00','008','已核算','E000010'                                       
                     
   declare @p1 varchar(300)              
set @p1=NULL              
declare @p2 varchar(3000)              
set @p2=NULL              
exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,'2014-06-03 15:13:00','008','','000'              
select @p1, @p2              
exec Pr_InvCostAccountingChk1 @p1 output,@p2 output,'2013-02-19 20:03:00','008','','E000010'                                                            
                                
select *from TInvCostAccounting    where Fwhcode='008' and fmonth='2014-4-30'                                  
                                                                                              
                                                                                             
 */                                                                                                         
 set nocount on                                
declare @RowIndex int                                                                                  
select @FMonth=dbo.Fn_GetFirstDayofMonth (@FMonth)                                                                                     
print @FMonth  print DATEADD(m,-1,@FMonth)                 
-- select dbo.FN_GetFirstDayofMonth(getdate())                                                                                      
declare @AccountingType int   ,@FSLRtnTypeCode varchar(30), @SlIOType varchar(20),@FisFirstAccountingMonth bit  , @AccountingByChkDate  bit                                                        
select @AccountingByChkDate  = FParamValue  From TParamsAndValues where FParamCode='01050302'                                         
select @AccountingType  =FParamValue From TParamsAndValues where FParamCode='01050301'    print @AccountingType                                                                
 select  @FSLRtnTypeCode = FParamValue  From TParamsAndValues where FParamCode='010102'       print @FSLRtnTypeCode                                                                             
                                           
--如果期末数据已审，则不能弃审                                                                        
if isnull(@FIsAccounted,'') <> ''                                                                                                    
begin                                                                        
   if exists( select 1 from  TMtrLStorageHis where dbo.Fn_MonthEqual(FMonth, @FMonth )=1 and FWhCode=@FWhCode  and FisChk=1)                                                
 begin                    
    set @AbortStr= convert(varchar(4),year(  @FMonth ))+'-'+convert(varchar(4),month( @FMonth  ))+' 期末数据已经审核！请先弃审期末数据。'                           
    return 0                                                                                              
  end                                  
   else                                  
   begin                                  
    delete TInvCostAccounting from TInvCostAccounting  InvAct   where dbo.Fn_MonthEqual(FMonth,@FMonth)=1 and FWhCode=@FWhCode                            
    delete  from TMtrLStorageHis      where dbo.Fn_MonthEqual(FMonth,@FMonth)=1 and FWhCode=@FWhCode                                                                                                     
    return 1                                  
   end                                  
end                                      
                                                                              
declare @FMinAbortClsDate datetime                                                                                                   
if exists( select * From TInvCostAcctMonthEndClose     where Fmonth =dateadd(m,-1,@FMonth) and  isnull(FisClosed,0)=0    )                                                                                      
begin                                                                
   set @AbortStr='请先月节'+convert(varchar(4),year( dateadd(m,-1,@FMonth) ))+'-'+convert(varchar(4),month( dateadd(m,-1,@FMonth) ))+' 记录'                                                    
   return 0                                                                                                     
end                                                                                                 
if exists (select *   from Twhindl  idl                                             
           join TWhin               inM  on inM.FWhinCode = idl.FWhinCode                                              
           join TPaymentApportionDL PayApDL on PayApDL.FWhDLFID = idl.F_ID                                                
           join TPaymentApportion   PayApM  on PayApDL.FPaymentApportionCode = PayApM.FPaymentApportionCode                                                
           where  isnull(PayApM.fischk,0)=0                                               
           and  ((dbo.Fn_MonthEqual(inM.FinDate ,  @FMonth)=1  and @AccountingByChkDate =0) or (dbo.Fn_MonthEqual(inM.FChkTime ,  @FMonth)=1    and @AccountingByChkDate =1  ))                                          
           and  isnull(inM.FWhCode,'')       = @FWhCode   )                                                
begin                                                
    set @abortstr='有分摊记录未审核，不能核算。'                                                                                   
    return 0                                                        
end                                                
                                  
if exists (select convert(smalldatetime,FParamValue) From TParamsAndValues    where FParamCode='01050202'  and  dbo.Fn_getfirstDayofmonth( convert(smalldatetime,FParamValue)) = dbo.Fn_getfirstDayofmonth(dateadd(m,-1, @FMonth) ))                           
  
    
     
         
          
            
             
   set   @FisFirstAccountingMonth =1                                                                                    
                                                 
/* for debug    drop table  #Items                       
declare  @FMonth smalldatetime    ,@FWhCode varchar(10)    ,@AccountingByChkDate bit                 
 ,@FSLRtnTypeCode varchar(30)     , @abortstr   varchar(200)                       
set @FMonth ='2014-6-1' set @FWhCode ='008' set @AccountingByChkDate=1       set @FSLRtnTypeCode='I03'                           
               */                        
create table #Items                                                                             
( id int identity(1,1),                 
FBillCode varchar(50),Fprice decimal(25,8),F_ID varchar(50),FAccountingPrice decimal(25,8),FMainQty decimal(25,8), FAmt decimal(25,8)                  
,FinvCode varchar(30),Fdate smalldatetime ,FWhCode varchar(50),FormID int ,BillType varchar(6),ParameterFLDs varchar(300),FWindowsFID varchar(50)                                    
,FinvName varchar(50),FGoodCode varchar(50),FColorCode varchar(50)                                         
,FChkTime datetime,FOutCost decimal(25,8),FPriceIsEstimated int,FLstPrice decimal(25,8)  ,FinOutTypeCode varchar(50)                                                                                         
,FFnIschk bit                                                                    
,FPackageQty decimal(25,8),FQty  decimal(25,8),FAmount  decimal(25,8),FBalanceAmt  decimal(25,8),FBalanceQty  decimal(25,8)                                                  
,FBalancePkgQty  decimal(25,8), FIsIn int                                                                                              
,FNote varchar(200), FisLastRow bit  ,RowIndex int  , FEstimatedPrice  decimal(25,8) , FExpensesApportion   decimal(25,8)                                   
,FProcessResult varchar(50)   ,FInvAccountingAmt decimal(25,8)                                
CONSTRAINT PK_tmpIOItems PRIMARY KEY (FWhCode,FinvCode,FChkTime,Fdate,id)                                                                 
)                       
              
insert into  #Items                  
select                                                                   
inM.FWhinCode as FBillCode, inDL.Fprice, inDL.F_ID ,  0.000000  as FAccountingPrice,isnull( inDL.FMainQty,0)  as FMainQty                                                                                                
 , inDL.FMainQty*inDL.Fprice   as FAmt                                                                     
,inDL.FinvCode ,inM.FinDate as Fdate, inM.FWhCode  , 1055 as FormID ,'BillEx' as BillType   ,'FBillCode' as ParameterFLDs ,'{80ABD574-3465-4E04-9389-4FF9C28EFF83}' as FWindowsFID                                    
,inDL.FinvName,inDL.FGoodCode,inDL.FColorCode                                     
 , inM.FChkTime   ,0.000000 as FOutCost   ,case when isnull(indl.Fprice,0)=0 then 1 else 0 end as FPriceIsEstimated              
,stg.FLstPrice ,inM.FinOutTypeCode   ,inM.FFnIschk   , inDL.FPackageQty   , isnull( inDL.FMainQty,0) as FQty               
 ,0.000000   as FAmount              
,0.0000000 as FBalanceAmt ,0.0000000 as FBalanceQty ,0.000000 as FBalancePkgQty                                            
,1 as FIsIn ,' ' as FNote ,0 as FisLastRow     ,0 as RowIndex    ,null as FEstimatedPrice                
,dbo.fn_GetExpensesApportion(inDL.F_ID ) as FExpensesApportion   ,' 'FProcessResult  ,0.000000 as FInvAccountingAmt                                
From Twhin inM                                                                                                                                                     
join Twhindl inDL   on inM.FWhinCode=inDL.FWhinCode                                                                                       
left join TMtrLStorage stg on stg.FinvCode=inDL.FInvCode  and stg.FWhCode=inM.FWhCode                                                                                            
where inM.FisChk=1     and inM.FWhCode = @FWhCode              
and  inM.FChkTime >= @FMonth and   inM.FChkTime < dateadd(m,1,@FMonth)              
 --and  inDL.Finvcode='36215'                                   
union all                                                                                      
select                                                                                                                            
OutM.FWhOutCode,OutDL.Fprice ,OutDL.F_ID , null as FAccountingPrice,   isnull( OutDL.FOutQty ,0)  as FMainQty           
,isnull(OutDL.Fprice*OutDL.FOutQty  ,0)    as FAmt                                                                                                           
,OutDL.FinvCode ,OutM.FOutDate as Fdate   , OutM.FWhCode   , 1054 as FormID ,'BillEx' as BillType ,'FBillCode' as ParameterFLDs  , '{553E4ABD-BE4E-4F92-82CE-3C5411F8ED23}' as FWindowsFID                       
 ,OutDL.FinvName,OutDL.FGoodCode,OutDL.FColorCode                                                                                                                                              
, OutM.FChkTime  ,0.000000 as FOutCost , 0 as FPriceIsEstimated              
,0 as FLstPrice, OutM.FinOutTypeCode  ,OutM.FFnIschk   ,OutDL.FPackageQty  , -isnull( OutDL.FOutQty ,0)  as FQty                
,-isnull(OutDL.Fprice*OutDL.FOutQty  ,0)  as FAmount              
,0.0000000 as FBalanceAmt ,0.0000000 as FBalanceQty ,0.000000 as FBalancePkgQty                                            
,0 as FIsIn ,' ' as FNote ,0 as FisLastRow     ,0 as RowIndex    ,null as FEstimatedPrice                
,0 as FExpensesApportion    ,' 'FProcessResult  ,0.000000 as FInvAccountingAmt                
from TwhoutM   OutM                                                                                                    
join TwhOutdl  OutDL on OutM.FWhOutCode=OutDL.FWhOutCode                                                                                                                                  
where OutM.FisChk=1          and  OutM.FWhCode  = @FWhCode                                                                                                 
and  outm.FChkTime >= @FMonth and   outm.FChkTime < dateadd(m,1,@FMonth)              
  --and  OutDL.Finvcode='36215'                                                                              
                   
                                                                                        
   /*    drop table #Items                                                                                
if exists(  select * from ( select FFnisChk from #itemIn union select FFnisChk from #itemOut )as T where isnull( FFnisChk  ,0)=0 )                                                                                      
begin                                                                                      
  set @Warningstr='有记录未财务审核，不能成本核算。'                                                    
  return 0                                                                                     
end */                                                                                                 
                                     
                                 
                                                           
-- if inventory in whout is   w/o or price storage in history data, please correct it.  select * from TMtrLStorageHisCorrection                             
declare @tmptable table( fmonth smalldatetime, finvcode varchar(30), fwhcode varchar(30),favgprice decimal(25,8) )                                         
insert into @tmptable                             
select distinct   @FMonth, items.FinvCode ,@FWhCode , stg.FAvgPrice  -- select *                                  
from  #items items                                  
left join TMtrLStorageHis his on items.FWhCode=his.FWhCode     and items.FinvCode =his.FInvCode                                  
left join TMtrLStorage    stg on  items.FinvCode =stg.FInvCode and his.FinvCode =stg.FInvCode                                  
where items.FIsIn=0 and  items.FWhCode=@FWhCode and his.FMonth=@FMonth    and items.FinOutTypeCode=@FSLRtnTypeCode                              
and   not exists( select * from TMtrLStorageHisCorrection where finvcode =items.FinvCode and fmonth=@FMonth and FWhCode=items.FWhCode)                                  
and  ( his.F_ID is null or isnull(his.FAvgPrice,0)=0 or isnull(his.FStorage,0) =0 )                                  
                            
insert into  TMtrLStorageHisCorrection(f_ID, Fmonth ,finvcode ,FWhCode ,FAvgPrice )   select NEWID() ,* from @tmptable                                    
/**/                            
                                  
                                  
if exists(select * from  TMtrLStorageHisCorrection correct where  FWhCode=@fwhcode and FMonth=dateadd(m,-1,@fmonth) and  isnull(FIsChk ,0)=0)                                  
begin                                  
    drop table #Items                                                                  
    set @abortstr='请先审核上月期末更正数据。'                                
    return 0                                                        
end                                   
                          
              
delete TInvCostAccounting from TInvCostAccounting  InvAct   where dbo.Fn_MonthEqual(FMonth,@FMonth)=1 and FWhCode=@FWhCode                                      
delete TMtrLStorageHis    where dbo.Fn_MonthEqual(FMonth,@FMonth)=1 and FWhCode=@FWhCode                                     
declare @FinvCode varchar(20),@FAmount decimal(25,8) ,@FStoragePkgQty decimal(25,8),@FStgAmt decimal(25,8),@FQty decimal(25,8),@FMainQty decimal(25,8)                                                            
 ,@FAvgPrice decimal(25,8) ,@FRevisedPrice decimal(25,8)   ,@FOutCost  decimal(25,8)                                          
 ,@FSumInAmount decimal(25,8), @FSumInQty decimal(25,8)    ,@FExpensesApportion  decimal(25,8)                                                     
declare @FSumQty decimal(25,8), @FSumAmount decimal(25,8),@FSumPkgQty decimal(25,8)  ,@FPreviousAvgPrice decimal(25,8) , @FultimoPrice decimal(25,8) ,@FInvAccountingAmt decimal(25,8)                                                                        
  
    
       
       
           
           
              
                
                   
                   
-- Merge storagehistory data                            
if   exists(  select * from  TMtrLStorageHisCorrection invCor                           
left  join TMtrLStorageHis his on  invCor.FInvCode= his.FInvCode  and invCor.FWhCode =his.FWhCode and  invCor.FMonth=his.FMonth                             
where   invCor.FWhCode=@FWhCode  and his.F_ID is null and invCor.FMonth = DATEADD(m,-1,@Fmonth) )                             
insert into  TMtrLStorageHis (F_ID,Fmonth,FInvCode,fwhcode,FCreateTime,FChkTime,FIsChk,FRevisedPrice,FRevisedStorage,FRevisedPkgStorage)                          
select distinct invcor.F_ID,invcor.Fmonth,invcor.FInvCode,@FWhcode,invcor.FCreateTime,invcor.FChkTime,invcor.FIsChk,invcor.FAvgPrice,invcor.FStorage,invcor.FStoragePkgQty                          
from  TMtrLStorageHisCorrection invCor                           
left  join TMtrLStorageHis his on  invCor.FInvCode= his.FInvCode  and invCor.FWhCode =his.FWhCode and  invCor.FMonth=his.FMonth                             
where   invCor.FWhCode=@FWhCode  and his.F_ID is null and invCor.FMonth = DATEADD(m,-1,@Fmonth)                          
 /**/                           
update TMtrLStorageHis set  FRevisedPrice = case when  invCor.FavgPrice IS not null  then invCor.FavgPrice  else FRevisedPrice end                            
,FRevisedStorage = case when  invCor.Fstorage  IS not null  then  invCor.Fstorage else FRevisedStorage end                            
, FRevisedPkgStorage =  case when  invCor.FStoragePkgQty   IS not null  then  invCor.FStoragePkgQty else FRevisedPkgStorage end                            
from  TMtrLStorageHisCorrection invCor                           
left  join TMtrLStorageHis his on  invCor.FInvCode= his.FInvCode  and invCor.FWhCode =his.FWhCode and  invCor.FMonth=his.FMonth                             
where   invCor.FWhCode=@FWhCode  and    invCor.FIsChk =1  and invCor.FMonth = DATEADD(m,-1,@Fmonth)                            
                         
              
              
create table #inventory (              
Finvcode varchar(20), FInQty decimal(25,8), FInAmt decimal(25,8), FExpensesApportion decimal(25,8)              
,FOutQty decimal(25,8), FOutCost decimal(25,8), FHisQty decimal(25,8), FHisAvgPrice decimal(25,8),              
FHisAmt decimal(25,8), FCorQty decimal(25,8), FCorAvgPrive decimal(25,8), FPhWhHisCorAvgPrice decimal(25,8) )                                    
              
insert into   #inventory (Finvcode) select distinct Finvcode   from #items              
                                  
select his.* into #TMtrLStorageHis  from TMtrLStorageHis his join #inventory inv on his.finvcode=inv.finvcode              
where   FWhCode= @FWhCode and FMonth=dateadd(m,-1,@FMonth)                              
                                                              
if isnull(@FIsAccounted,'') = ''                                                                                                    
begin                                                                                                    
  if @AccountingType = 1                                                                                                  
  begin    --     drop table #inventory                     
          update #items set    FinvAccountingAmt = FAccountingPrice*FmainQty, FAccountingPrice = dbo.Fn_GetOutSourceWhInCostPrice(F_ID)               
            , FExpensesApportion =dbo.fn_GetExpensesApportion(f_id)  from #items where fisin=1              
                        
          update #items set    FinvAccountingAmt =  FAccountingPrice*FmainQty  from #items where   fisin=1               
                        
          update   #inventory  set FInQty= B.FQty, FInAmt =B.famt, FExpensesApportion = B.FExpensesApportion              
          from #inventory inv join ( select SUM(FMainQty) as FQty , sum(isnull(FinvAccountingAmt,0))as FAmt, SUM(isnull(FExpensesApportion,0)) FExpensesApportion,finvcode from #items items where fisin=1 group by finvcode )as B on inv.Finvcode=B.finvcode  
  
   
       
                 
          update   #inventory  set FOutQty= B.FQty               
          from #inventory inv join ( select SUM(FMainQty) as FQty   ,finvcode from  #items  items  where  fisin=0 group by finvcode )as B on  inv.Finvcode =B.finvcode              
                      
          update   #inventory  set FHisQty= B.FQty , FHisAvgPrice = B.FAvgPrice  ,FHisAmt = b.FAmt          
         -- select *              
          from #inventory inv join (  select FStorage as FQty , ISNULL(FRevisedAmt, FAmt) as Famt ,FAvgPrice, FInvCode   from TMtrLStorageHis where FWhCode =@FWhCode and FMonth= DATEADD(m,-1,@FMonth) )as B on  inv.Finvcode =B.finvcode              
                      
          update   #inventory  set FCorQty= B.FQty, FCorAvgPrive =B.FAvgPrice                
          from #inventory inv join (  select FStorage as FQty  ,FAvgPrice, FInvCode from TMtrLStorageHisCorrection where FisChk=1 and FWhCode =@FWhCode and FMonth=DATEADD(m,-1,@FMonth))as B on  inv.Finvcode =B.finvcode              
                        
          update   #inventory  set FPhWhHisCorAvgPrice= B.FAvgPrice               
          from #inventory inv join (  select top 1  FAvgPrice, FInvCode from TMtrLStorageHisCorrection where FisChk=1 and FWhCode=@FWhCode and FMonth<  @FMonth   order by FMonth desc)as B on  inv.Finvcode =B.finvcode              
                       
         update #inventory               
         set FOutCost = case when   (isnull(FHisQty,0)+isnull(FInQty,0)   =0) and isnull(FInQty,0)<>0              
                             then  isnull(isnull(isnull(FCorAvgPrive,FHisAvgPrice ),FPhWhHisCorAvgPrice), FInAmt/FInQty)              
                             when   (isnull(FHisQty,0)+isnull(FInQty,0)   =0) and isnull(FInQty,0)= 0              
                             then    isnull(isnull(FCorAvgPrive,FHisAvgPrice ),FPhWhHisCorAvgPrice)               
                             when  ISNULL(fhisAmt,0)<0 and  isnull(FInQty,0) <>0    
                             then  ( isnull(FInAmt,0)+ISNULL(FExpensesApportion,0)) / isnull(FInQty,0)     
                             else                         
                             (ISNULL(fhisAmt,0)+ isnull(FInAmt,0)+ISNULL(FExpensesApportion,0)) / (isnull(FHisQty,0)+isnull(FInQty,0))              
                        end    From  #inventory               
                         
                                      
          update #items set foutcost =inv.foutcost, FinvAccountingAmt= case when fisin=1  then    FAccountingPrice*FmainQty  else -1*fmainQty*inv.foutcost end              
          from #inventory inv join #items items on inv.Finvcode=items.finvcode               
                       
         -- select *from #inventory              
                       
          --select *  From #items  #inventory                         
 /*                                                                     
     declare @FinvCode varchar(20),@FAmount decimal(25,8) ,@FStoragePkgQty decimal(25,8),@FStgAmt decimal(25,8),@FQty decimal(25,8),@FMainQty decimal(25,8) ,@FAvgPrice decimal(25,8) ,@FRevisedPrice decimal(25,8)   ,@FOutCost  decimal(25,8)               
       ,@FSLRtnTypeCode varchar(30)                                                            
      , @FMonth smalldatetime , @RowIndex int   , @FWhCode varchar(10) ,@FSumInAmount decimal(25,8), @FSumInQty decimal(25,8)                                  
     select  @FSLRtnTypeCode = FParamValue  From TParamsAndValues where FParamCode='010102'       print @FSLRtnTypeCode                                                            
     set @FMonth='2014-6-1'               set @FWhCode='008'      */                
                   
                   
declare cursor1 cursor for                                                                                            
     select distinct  FinvCode from #Items  --  where finvcode=41009 --- order by Fdate,FChkTime                                                           
     open cursor1                                                                                                                     
        fetch next from cursor1 into @FinvCode                                                                                
        while @@fetch_status=0                                                                                                         
        begin                    
          set @FAmount =0   set @FQty=0 set @RowIndex=0   set @FStoragePkgQty=0   set   @FRevisedPrice=0                                                                  
                       
          select                                                                           
 @FAmount=isnull( isnull(FRevisedAmt,FAmt) ,0)   ,@FQty = isnull( FRevisedStorage,FStorage)                                                                            
             ,@FStoragePkgQty =isnull( isnull( FRevisedPkgStorage,FStoragePkgQty),0)    ,@FRevisedPrice= isnull( FRevisedPrice ,FAvgPrice) ,@FAvgPrice=isnull(FRevisedPrice,FAvgPrice )                            
              from #TMtrLStorageHis where FInvCode= @FinvCode                                                                                    
                                                                                    
          update #Items set                                                                               
           @FQty= ISNULL(@FQty,0)+isnull(FQty ,0)       ,@FStoragePkgQty=isnull(@FStoragePkgQty,0)+ isnull(FPackageQty,0)                                    
          ,@FAmount=@FAmount+  case when ISNULL(Fisin,0)=1 then FAccountingPrice*FQty else Fqty*FoutCost end                                                   
          ,FBalanceQty=isnull(@FQty,0)                  ,FBalanceAmt=isnull(@FAmount,0)          ,FBalancePkgQty=@FStoragePkgQty                                                                                   
          ,RowIndex=@RowIndex                           ,@RowIndex=@RowIndex+1               
           from #Items A                                                                                              
           where FInvCode =@FinvCode  and FWhCode= @FWhCode                        
          /*  */                                       
           update #Items set  RowIndex=@RowIndex ,@RowIndex=@RowIndex+1     where FInvCode =@FinvCode                             
          fetch next from cursor1 into @FinvCode                                           
        end                                                                               
     close cursor1                                                                                                                 
   deallocate cursor1                
                             
   update #Items   set fislastrow = 1              
   from #Items items               
   join ( select   MAX(fchktime)fchktime ,max(RowIndex) RowIndex ,finvcode  from #items group by finvcode ) as B               
         on  items.finvcode=B.finvcode and items.fchktime= B.fchkTime and items.RowIndex =B.RowIndex              
                 
              
                 
                                /*                                 
     declare cursor1 cursor for                                                                                            
     select distinct  FinvCode from #Items   --   where finvcode=43360 --- select *From #items   order by fchktime                                                      
     open cursor1                                                                                                       
        fetch next from cursor1 into @FinvCode                                                                                
        while @@fetch_status=0                                                                                                         
        begin                                
          set @FAmount =0   set @FQty=0 set @RowIndex=0   set @FStoragePkgQty=0   set   @FRevisedPrice=0                                                                  
                                               
          select                                                                           
              @FAmount=isnull( isnull(FRevisedAmt,FAmt) ,0)   ,@FQty = isnull( FRevisedStorage,FStorage)                                                                            
             ,@FStoragePkgQty =isnull( isnull( FRevisedPkgStorage,FStoragePkgQty),0)    ,@FRevisedPrice= isnull( FRevisedPrice ,FAvgPrice) ,@FAvgPrice=isnull(FRevisedPrice,FAvgPrice )                            
              from TMtrLStorageHis where FInvCode= @FinvCode   and FWhCode= @FWhCode and FMonth=dateadd(m,-1,@FMonth)                                                                                
                                    
          -- select      @FQty ,@FAvgPrice,@FAmount                                                                            
                                   
           --销售退货 取期初成本  无期初则取退货价                                      
          update #Items  set FAccountingPrice=case when isnull(@FQty,0) <>0 then  isnull(@FAmount/ @FQty,0)  else  @FAvgPrice  end     where FInvCode =@FinvCode and FinOutTypeCode=@FSLRtnTypeCode                              
          --销售退货 取最新进价                                                            
          update #Items set FAccountingPrice= FAvgPrice  from #Items A join TMtrLStorage B on A.FinvCode=B.FinvCode and A.FWhCode=B.FWhCode and isnull( A.FAccountingPrice,0)=0 and A.FinOutTypeCode=@FSLRtnTypeCode and A.FInvCode =@FinvCode                
  
     
     
         
         
            
                                                                                       
          select @FSumInAmount=SUM(   FQty*isnull(FAccountingPrice ,fprice)  + isnull(FExpensesApportion, 0)) from #Items    where FInvCode =@FinvCode    and FIsIn = 1       --print '@FSumInAmount' print @FSumInAmount                                      
  
    
      
        
                             
          select @FSumInQty   =SUM(FQty) from #Items    where FInvCode =@FinvCode    and FIsIn = 1                                     -- print '@FSumInQty'    print @FSumInQty                                                            
                                                                     
          select @FAvgPrice= case when isnull(@FSumInQty,0)+isnull(@FQty,0)=0 or isnull(@FSumInQty,0)=0 then @FAvgPrice                   
                                when isnull(@FQty,0)<0 then isnull(@FSumInAmount,0)/ isnull(@FSumInQty,0)                  
                                  else (isnull(@FSumInAmount,0)+ isnull( @FAmount,0))/( isnull(@FSumInQty,0)+isnull(@FQty,0))   end                              
                                      
          select @FAvgPrice= isnull( FAvgPrice,FUltimoPrice) from TMtrLStorage where FinvCode =@FinvCode and ISNULL(@FAvgPrice ,0)=0                                    
                                           
         --  select @FSLRtnTypeCode , @FAmount as FAmount, @FQty as fqty, @FStoragePkgQty as FStoragePkgQty ,  @FAvgPrice as FAVgprice   ,@FSumInQty    as FsumInQTY ,@FSumInAmount as FSumInAmount  --show variables                                          
  
    
      
        
          
           
               
               
                 
                    
                      
                       
                                                                        
          update #Items  set FOutcost=@FAvgPrice       where FInvCode =@FinvCode and FIsIn=0  and ISNULL (FOutcost,0)=0                            
                                                                      
          --update estimated price  when in price is 0                                                                  
          update #Items set                                                                               
           @FQty= ISNULL(@FQty,0)+isnull(FQty ,0)       ,@FStoragePkgQty=isnull(@FStoragePkgQty,0)+ isnull(FPackageQty,0)                                    
          ,@FAmount=@FAmount+ isnull(FExpensesApportion, 0)+ case when ISNULL(Fisin,0)=1 then  Fqty*FAccountingPrice else Fqty*FoutCost end                                 
          ,FBalanceQty=isnull(@FQty,0)                  ,FBalanceAmt=isnull(@FAmount,0)          ,FBalancePkgQty=@FStoragePkgQty                                                                                   
          ,RowIndex=@RowIndex                           ,@RowIndex=@RowIndex+1    ,      FInvAccountingAmt= isnull(FExpensesApportion, 0)+ case when ISNULL(Fisin,0)=1 then  Fqty*FAccountingPrice else Fqty*FoutCost end                             
          from #Items A                                                                                              
          where FInvCode =@FinvCode  and FWhCode= @FWhCode                                                           
                                      
          --select * from #items                                                        
      update #Items set fislastrow = 1  where finvcode=@FinvCode                            
          and  fchktime= (select MAX(fchktime) from #items  where finvcode=@FinvCode)                                
          and  RowIndex= (select MAX(RowIndex) from #items  where finvcode=@FinvCode)                                            
                                      
                                      
                                      
          fetch next from cursor1 into @FinvCode                                                                                                
        end                                                                               
     close cursor1                                                                                                                 
   deallocate cursor1         */                                                 
                               
    --select * from #Items -- where FInvCode ='47053' order by RowIndex                                                             
                                                                                                   
  end                                                                                                 
  if @AccountingType = 2                                                                             
  begin                                        
                            
/*                
select FultimoPrice from TMtrLStorageHis                                                                    
     declare @FinvCode varchar(20),@FWhCode varchar(20),@FAmount decimal(25,8) ,@FStgAmt decimal(25,8),@FQty decimal(10,4), @FRevisedPrice decimal(25,8)                                  
     ,@FMainQty decimal(25,8), @FMonth smalldatetime ,@FAvgPrice decimal(25,8)   ,@FStoragePkgQty decimal(25,8)  ,@RowIndex int                                                           
     set @FMonth ='2014-1-1' set @FWhCode ='008'        */                                                                                               
                                        
     declare cursor2 cursor for                                                    
     select distinct   FinvCode from #Items  -- where Finvcode='49423' --- order by Fdate,FChkTime                                                                                            
     open cursor2                                                     
        fetch next from cursor2 into @FinvCode                                                                                
        while @@fetch_status=0                                                                                                    
        begin                     
          set @FSumAmount =0   set @FSumQty=0   set @FSumPkgQty=0    set @RowIndex=0 set @FInvAccountingAmt=0                                                                        
          select                                                                           
           @FSumAmount=isnull(FRevisedPrice*isnull(FRevisedStorage,FStorage),FAmt)     ,@FAvgPrice = ISNULL( FRevisedPrice ,FAvgPrice )                                  
          ,@FultimoPrice=ISNULL( FRevisedPrice ,FAvgPrice )                           ,@FRevisedPrice= FRevisedPrice                                    
          ,@FSumQty =isnull( FRevisedStorage,FStorage)                                 ,@FSumPkgQty =isnull( FRevisedPkgStorage,FStoragePkgQty)                                                               
                                                                            
           from TMtrLStorageHis where FMonth=DATEADD(m,-1,@FMonth) and FInvCode= @FinvCode  and FWhCode= @FWhCode                                        
                                           
          --select  @FAmount, @FQty, @FSumPkgQty ,@FinvCode  ,DATEADD(m,-1,@FMonth)   ,@FAvgPrice                                   
          if exists(select * from TMtrLStorageHisCorrection where Fmonth=@FMonth and Finvcode=@FinvCode and Fmonth=@FMonth and ISNULL(FisChk,0)=1)                                  
             update #Items set FProcessResult ='请审核期初数' where Finvcode=@FinvCode                                
          else                                  
          begin                                  
             DECLARE     @F_ID  AS VARCHAR(50) ,@FinOutTypeCode2 varchar(30),@Fisin2 bit,@FQty2 decimal(25,8),@FPackageQty2 decimal(25,8), @FAccountingPrice2 decimal(25,8)                                   
                                  
             DECLARE InvCost_CR2 CURSOR FOR SELECT F_ID, FinOutTypeCode,Fisin, FQty ,FPackageQty ,FAccountingPrice FROM #Items where Finvcode =@FinvCode                    
             order by FchkTime,fisin desc,fdate OPEN InvCost_CR2                
             FETCH NEXT FROM InvCost_CR2 INTO @F_ID,@FinOutTypeCode2,@Fisin2 , @FQty2 ,@FPackageQty2  ,@FAccountingPrice2 WHILE (@@FETCH_STATUS = 0)                                  
             BEGIN                                   
                                              
                set @RowIndex=@RowIndex+1                              
                set @FPreviousAvgPrice=case when @FSumQty<>0 then @FSumAmount/@FSumQty  end                                                  
                set @FSumPkgQty = isnull(@FSumPkgQty,0)+ ISNULL(@FPackageQty2,0)                                   
                set @FSumQty= ISNULL(@FSumQty,0)+ISNULL(@FQty2,0)                                    
                if (@Fisin2=1 )                                   
                  set @FAvgPrice=@FAccountingPrice2   --  if itt is whin , get accounting cost                                  
                else                                    
                  set @FAvgPrice=case when  @FinOutTypeCode2<>@FSLRtnTypeCode then @FPreviousAvgPrice else @FultimoPrice end   -- get previouse cost ,if it's  sales return  get @FultimoPrice                                   
                set @FInvAccountingAmt= case when @Fisin2=1 then    @FQty2*isnull(@FAccountingPrice2 ,0)                                   
                                           else   @FQty2*isnull(@FAvgPrice ,0) end          
                                                                              
                set @FSumAmount =    ISNULL(@FSumAmount,0) + @FInvAccountingAmt                                       
                                                                        
                 --select @fisin2,@FAvgPrice as FAvgPrice ,@FQty2*isnull(@FAvgPrice ,0) as [FQty2*FAvgPrice], @FQty2*@FAccountingPrice2 as[FQty2*FAccountingPrice2]                                  
                 --,case when @FSumQty<>0 then @FSumAmount/@FSumQty end as [@FSumAmount/@FSumQty],@FSumQty as FSumQty ,@FSumAmount as FSumAmount ,@FAccountingPrice2 as FAccountingPrice2,@FQty2 as FQty                                  
                                                                 
                update #Items set FOutCost =  case when fisin=0 or @FinOutTypeCode2=@FSLRtnTypeCode then  @FAvgPrice    else null end                                  
                   ,FBalanceQty=isnull(@FSumQty,0)                  ,FBalanceAmt=isnull(@FSumAmount,0)          ,FBalancePkgQty=@FSumPkgQty                                        
                   ,RowIndex=@RowIndex   ,FInvAccountingAmt=  @FInvAccountingAmt                                      
                  from #Items A  where F_ID=@F_ID                                   
                                                  
                FETCH NEXT FROM InvCost_CR2  INTO @F_ID,@FinOutTypeCode2,@Fisin2 ,@FQty2 ,@FPackageQty2  ,@FAccountingPrice2                                   
             END                                  
             CLOSE InvCost_CR2  DEALLOCATE InvCost_CR2                                 
                                            
             update #Items set fislastrow = 1   where finvcode=@FinvCode and  RowIndex = (select MAX(RowIndex) from #items  where finvcode=@FinvCode)                                 
          end                                      
          fetch next from cursor2 into @FinvCode end  close cursor2                                                                                                                 
     deallocate cursor2                                        
    -- select *from #items                                                            
  end                                            
    /*                        
  if exists(select * from  TMtrLStorageHisCorrection correct where  FWhCode=@fwhcode and FMonth=@fmonth and  isnull(FIsChk ,0)=0)                                  
  begin                                  
  drop table #Items                                                                                           
  drop table #itemIn                                                         
  drop table #itemOut                                                                                       
  set @abortstr='部分出库无成本价，请先更正成本数据。'                      
  return 0                                                        
  end                                   
        */                        
                                                  
     insert into TInvCostAccounting                                                                                                           
     (FInvCode,FOriPrice,FBillCode, BillType, FormID, ParameterFLDs,FWindowsFID                                                   
     ,FQty,F_ID,FAccountingPrice,FDate, FWhCode   ,FMonth ,FChkTime , FIsAccounted ,FoutCost                                                                         
     ,Fisin,FBalanceQty,FBalanceAmt,Findex ,FBalancePkgQty  ,FisLastRow ,FinOutTypeCode ,FPackageQty ,FAmt ,FInvAccountingAmt,RowIndex,FEstimatedPrice  ,FExpensesApportion)                                                                                  
  
    
      select                                                                                                       
     FInvCode,FPrice,FBillCode , BillType, FormID,   ParameterFLDs,FWindowsFID                                                   
     ,FMainQty,F_ID,FAccountingPrice,FDate, FWhCode ,@FMonth ,FChkTime ,    1  ,FoutCost                                                                                           
     ,Fisin,FBalanceQty,FBalanceAmt , id  ,FBalancePkgQty  ,FisLastRow  ,FinOutTypeCode  ,FPackageQty  ,Famt  ,FInvAccountingAmt,RowIndex  ,FEstimatedPrice ,FExpensesApportion                                                                                
  
   
     from #Items [io]                             
                          
                                                                                     
                                                                                
      --当月无出入库，取上月月节数据                                                                                      
     insert into TMtrLStorageHis(f_ID,FCreateEmp,FCreateTime ,FMonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  FIsChk,FChkTime,FChkEmp,FAmt,FRevisedPkgStorage,FRevisedPrice,FRevisedStorage,FCostInaccuracy,FNote)                            
     select                                                                              
     newid(),FCreateEmp,getdate() ,@Fmonth,FStorage,FStoragePkgQty,FInvCode,FWhCode, FAvgPrice,  0,null ,null,isnull(frevisedamt,FAmt) ,FRevisedPkgStorage,FRevisedPrice,FRevisedStorage,FCostInaccuracy ,'from previous month '                            
     from  TMtrLStorageHis where Fmonth=dateadd(m,-1,@Fmonth) and FWhCode=@FWhCode and                                                                              
     not exists(select * from #Items io                                                                               
                where    io.FInvCode=TMtrLStorageHis.FInvCode      )                                                                         
                                                                                                
     --有出入库取核算明细                                                                                      
     insert into TMtrLStorageHis       (F_ID,FCreateTime,fmonth,FInvCode,FWhCode,FAvgPrice,FStorage,FStoragePkgQty,FAmt,FIsChk,FChkTime,FChkEmp,FNote)                             
     select                                                                                         
     F_ID ,getdate(),FMonth,FInvCode,FWhCode      
     ,   
     case when Fisin = 1 then FAccountingPrice   
          else   
         case when isnull(FOutCost,0)<>0  then FOutCost   
             else  case when isnull(FBalanceQty,0)<>0 then FBalanceAmt/FBalanceQty  end  end  
     end   
     ,FBalanceQty,FBalancePkgQty, convert(decimal(25,2),FBalanceAmt),0, null ,null  ,'from InvCostAccounting '                            
     from TInvCostAccounting where FisLastRow=1 and FMonth=@FMonth  and FWhCode=@FWhCode    ---  and FBalanceQty>=0                                                                                        
                                        
 end                           
                                                                                                   
drop table #inventory                                                                                        
drop table #Items                                                                                              
drop table #TMtrLStorageHis                          
set nocount off                   
      
              
                                 
 ------------------------------------------------------------------------------------                                                   
 ------------------------------------------------------------------------------------ 