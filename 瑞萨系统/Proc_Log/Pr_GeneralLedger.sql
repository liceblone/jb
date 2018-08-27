  CREATE proc Pr_GeneralLedger        
@FbeginDate smalldatetime,        
@FEndDate   smalldatetime,        
@FCltVdTypeCode varchar(50),        
@FCltVdCode     varchar(50),        
@FisClt         bit  ,    
@IsManufactory         bit =0      
      
as        
        
declare @FVendorTypeCode varchar(30)  
select @FVendorTypeCode = FparamValue From TParamsAndValues where fparamCode='010301'  
  
/*      
declare @FbeginDate smalldatetime,        
@FEndDate   smalldatetime,        
@FCltVdTypeCode varchar(50),        
@FCltVdCode     varchar(50),        
@FisClt         bit        
set @FbeginDate='2010-1-7'      
set @FEndDate='2010-2-7'      
set @FCltVdTypeCode='%'      
set @FCltVdCode='Vd0000010%'      
set @FisClt=0      
*/      
create table #TFCltVdCode ( FCltVdCode varchar(40))        
        
if @FisClt =1        
insert into #TFCltVdCode  select FcltCode    from Tclient where FcltTypeCode    like @FCltVdTypeCode  and FcltCode    like  @FCltVdCode      
else        
insert into #TFCltVdCode  select FVendorCode from Tvendor where FvendorTypeCode like @FCltVdTypeCode  and FVendorCode like  @FCltVdCode      
        
--select * from #TFCltVdCode        
      
--select * from TPayReceive        
--select * from TPayReceiveAble        
      
 --2010-11-4 ¹ýÂËÈ¾³§  
if @IsManufactory=1   
delete #TFCltVdCode where FCltVdCode not in ( select FVendorCode from Tvendor  where FVendorTypeCode=@FVendorTypeCode)  
  
  
      
select FGlcCode,Famt,FCltVdCode         
into #tmp        
from TPayReceive  where FDate>=@FbeginDate and FDate<=@FEndDate and FcltvdCode in (select FCltVdCode from #TFCltVdCode)        
union all         
select FGlcCode,Famt,FCltVdCode from TPayReceiveAble  where FDate>=@FbeginDate and FDate<=@FEndDate and FcltvdCode in (select FCltVdCode from #TFCltVdCode)        
      
       
select FglcCode,sum( isnull(Famt,0) ) as Famt into #tmp2 From #tmp group by FglcCode        
        
        
select  space(len(B.FglcCode )-1)+B.FglcName  as FglcCodelkp   ,  A.Famt ,B.FglcCode        
     from TGLC  B        
left join #tmp2 A  on A.FglcCode like B.FglcCode         
order by  B.FglcCode        
       
        
drop table #tmp        
drop table #TFCltVdCode        
drop table #tmp2        
        
         
        
        
          
      
    
  
 ------------------------------------------------------------------------------------  
