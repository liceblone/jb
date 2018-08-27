alter  PROCEDURE [dbo].[fn_alrdyinout_open]                   
                       @LoginId varchar(20),                  
                       @BankId varchar(20),                  
                       @BeginDate datetime,                  
                       @EndDate datetime,                  
                       @IsBetween bit,                  
                       @UnChked bit                  
AS                  
/*          
declare           
                       @LoginId varchar(20),                  
                       @BankId varchar(20),                  
                       @BeginDate datetime,                  
                       @EndDate datetime,                  
                       @IsBetween bit,                  
                       @UnChked bit              
          
set  @LoginId ='chy'          
set  @BankId =''          
set  @BeginDate ='2007-1-1'          
set  @EndDate ='2007-8-1'          
set  @IsBetween ='1'          
set  @UnChked ='1'             
*/          
          
  select 0 as BillType,  case when isnull(isAcceptancebill,0)=0 then  20 else 48 end as billid ,'clBlue' as FntClr,r.ReceiverDate,r.Code,VoucherId as VoucherId,r.ClientId,r.ClientName,i.Name as Brief,r.BankId,r.PayModeId,r.PayFund as InQty,null as OutQty,
  
r.HandManId,r.IsChk    
  ,r.BillManId,r.BillTime,r.ChkManId,r.ChkTime,r.Note  ,AcceptancebillCode     
   into #tmp       
  from fn_receiver r left outer join fn_item i on r.ItemId=i.Code --where r.ReceiverDate>=@BeginDate and r.ReceiverDate<=@EndDate                  
       
  union all                  
  select 0, case when isnull(p.isAcceptancebill,0)=0 then  21 else 49 end as billid ,'clRed',p.PaymentDate,p.Code,p.VoucherId,p.ClientId,p.ClientName,i.Name,p.BankId,p.PayModeId,null,p.PayFund,p.HandManId,p.IsChk    
  ,p.BillManId,p.BillTime,p.ChkManId,p.ChkTime,p.Note   ,p.SubAcceptancebillCode as AcceptancebillCode    
  from fn_payment p     
  left outer join fn_item i on p.ItemId=i.Code        
       
        
  union all                  
  select 1,19,'clBlue',InvoiceDate,Code,'',ClientId,ClientName,'销售收入',BankId,PayModeId,PayFund,null,PayeeId,FnIsChk    
  ,BillManId,BillTime,FnChkManId,FnChkTime,Note ,'' as AcceptancebillCode    
  from sl_invoice where PayFund<>0 --and InvoiceDate>=@BeginDate and InvoiceDate<=@EndDate          
          
  union all                  
  select 0,22,'clRed',Trf.TrnsfrDate,Trf.Code,'',null,Trf.InId,'内部转帐(出)单',Trf.OutId,null,null,Trf.PayFund,null,Trf.IsxChk    
  ,Trf.BillmanId,Trf.BillTime,Trf.xChkManId,Trf.xChkTime,Trf.Note ,rec.AcceptancebillCode    
  from fn_bnktransfer Trf--where TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate     
  left   join fn_receiver Rec on Rec.Code = Trf.ReceiverCode      
                 
  union all                  
  select 0,22,'clBlue',Trf.TrnsfrDate,Trf.Code,'',null,Trf.OutId,'内部转帐(入)单',Trf.InId,null,Trf.PayFund,null,null,Trf.IsiChk    
  ,Trf.BillmanId,Trf.BillTime,Trf.iChkManId,Trf.iChkTime,Trf.Note ,rec.AcceptancebillCode      
  from fn_bnktransfer Trf--where TrnsfrDate>=@BeginDate and TrnsfrDate<=@EndDate                  
  left   join fn_receiver Rec on Rec.Code = Trf.ReceiverCode      
                
--where PaymentDate>=@BeginDate and PaymentDate<=@EndDate                  
  union all                  
  select 1,3,'clBlue',RetailDate,Code,null,null,null,'零售收入',BankId,'001',GetFund,null,PayeeId,FnIsChk    
  ,BillManId,BillTime,FnChkManId,FnChkTime,Note,'' as AcceptancebillCode    
   from sl_retail where GetFund<>0 --and RetailDate>=@BeginDate and RetailDate<=@EndDate                  
    
        
         
  order by BankId,ReceiverDate                  
                  
if @BankId<>''                   
  delete from #tmp where BankId not like @BankId+'%'                  
/*                  
if @Bankind='我的帐户'                  
  delete from #tmp where BankId not in (select BankId from sys_userbank where UserId=@LoginId)                  
else if @Bankind='其他帐户'                   
  delete from #tmp where BankId in (select BankId from sys_userbank where UserId=@LoginId)                  
*/                  
if @IsBetween=1                   
  delete from #tmp where ReceiverDate<@BeginDate or ReceiverDate>@EndDate                  
           
if @UnChked=1                   
  delete from #tmp where IsChk=1                  
                  
          
          
select *,0 as Findex into #TT From #tmp order by ReceiverDate          
declare @i int          
set @i=0          
update #TT set Findex=@i,@i=@i+1          
          
--select * From #TT          
          
          
--select BillType,BillId,ReceiverDate,Code,InQty,OutQty,          
--( select sum(isnull(convert(decimal(19,2),InQty),0.00)-isnull(convert(decimal(19,2),OutQty),0.00))  from #TT  D where D.Findex <=M.Findex  ) as RmnQty           
-- from #TT M            
          
          
          
select BillType,BillId,FntClr,ReceiverDate,Code,VoucherId,ClientId,ClientName,Brief,BankId,PayModeId,InQty,OutQty,          
( select sum(isnull(convert(decimal(19,2),InQty),0.00)-isnull(convert(decimal(19,2),OutQty),0.00))  from #TT  D where D.Findex <=M.Findex  ) as RmnQty ,          
          
HandManId,IsChk,BillManId,BillTime,ChkManId,ChkTime,Note,AcceptancebillCode from #TT M                 
union all                  
select null,null,'clFuchsia',null,null,null,null,null,'    合   计',null,null,sum(InQty),sum(OutQty),convert(decimal(19,2),sum(InQty)-sum(OutQty)) as  RmnQty,null,null,null,null,null,null,null,null from #TT                  
order by ReceiverDate            
          
          
/*          
          
select BillType,BillId,FntClr,ReceiverDate,Code,VoucherId,ClientId,ClientName,Brief,BankId,PayModeId,InQty,OutQty,          
( select sum(isnull(convert(decimal(19,2),InQty),0.00)-isnull(convert(decimal(19,2),OutQty),0.00))  from #tmp  D where D.Findex <=M.Findex  ) as RmnQty ,          
          
HandManId,IsChk,BillManId,BillTime,ChkManId,ChkTime,Note from #tmp M                 
union all                  
select null,null,'clFuchsia',null,null,null,null,null,'    合   计',null,null,sum(InQty),sum(OutQty),convert(decimal(19,2),sum(InQty)-sum(OutQty)) as  RmnQty,null,null,null,null,null,null,null from #tmp                  
order by ReceiverDate     */           
drop table #TT             
drop table #tmp                
                
              
            
          
        
                
              
            