CREATE   PROCEDURE [sl_GetEmpSale]         
--                 @WhId varchar(20),        
                 @BeginDate DateTime,        
                 @EndDate Datetime        
AS        
  
/*  
declare   
                 @BeginDate DateTime,        
                 @EndDate Datetime       
set @BeginDate='2007-1-1'  
set @EndDate='2007-12-1'  
*/  
  
--   if @WhId is null         
--      set @WhId=''        
--   set @WhId=@WhId+'%'        
--WhId like @WhId and        
--2006-7-22 销售发货 销售退货  后加审核标志      
set @BeginDate=@BeginDate-1        
set @EndDate=@EndDate+1        
        
--//  销售发货      
   select ClientId,gatheringemp as SaleEmpId,InvoiceDate as xDate,GetFund as Fund,PayFund into #a from sl_invoice where IsChk=1 and InvoiceDate>@BeginDate and InvoiceDate<@EndDate        
   union all        
--销售退货      
   select ClientId,null,ReturnDate,-GetFund,0 from sl_return where IsChk=1 and ReturnDate>@BeginDate and ReturnDate<@EndDate        
 --//应收单      
  union all        
   select ClientId,null,InDate,PayFund,0 from fn_shldin where ItemId='0100' and InDate>@BeginDate and InDate<@EndDate        
 --//应付单      
   union all        
   select ClientId,null,OutDate,0,PayFund from fn_shldout where ItemId='0100' and OutDate>@BeginDate and OutDate<@EndDate        
 --//收款单      
   union all        
   select ClientId,null,ReceiverDate,0,PayFund from fn_receiver where ReceiverDate>@BeginDate and ReceiverDate<@EndDate        
        
--select gatheringemp,*from sl_invoice  
--select *From #a  
--drop table #a  
  
--   delete from #a where ClientId in (select Code from crm_client where IsNull(SaleEmpId,'')='')        
        
   update #a set SaleEmpId=(select top 1 EmpId from sl_empclient where sl_empclient.ClientId=#a.ClientId)        
  
--select  EmpId,* from sl_empclient  
  
       
   select ClientId,sum(GetFund) as Fundx into #c from sl_invoice where IsChk=1 group by ClientId        
union all        
   select ClientId,-sum(PayFund) from sl_invoice where FnIsChk=1 group by ClientId        
union all        
   select m.ClientId,-sum(d.RmnQty*d.Price) from sl_invoicedl d inner join sl_invoice m on d.InvoiceId=m.Code where m.IsChk=1  group by m.ClientId        
union all        
   select ClientId,-sum(GetFund) from sl_return where IsChk=1 group by ClientId        
union all        
   select ClientId,-sum(GetFund) from ph_arrive where IsChk=1 group by ClientId        
union all        
   select ClientId,sum(GetFund) from ph_return where IsChk=1 group by ClientId        
union all        
   select ClientId,-sum(WareFund) from wh_in where (InTypeId='I08' or InTypeId='I09') and IsChk=1  group by ClientId        
union all        
   select ClientId,sum(WareFund) from wh_out where (OutTypeId='X08' or OutTypeId='X09') and IsChk=1 group by ClientId        
union all        
   select ClientId,-sum(PayFund) from fn_receiver where IsChk=1 group by ClientId        
union all        
   select ClientId,sum(PayFund) from fn_payment where IsChk=1 group by ClientId        
union all        
   select ClientId,sum(PayFund) from fn_shldin where IsChk=1 group by ClientId        
union all        
   select ClientId,-sum(PayFund) from fn_shldout where IsChk=1 group by ClientId        
union all        
   select InId,sum(PayFund) from fn_clntransfer where IsChk=1 group by InId        
union all        
   select OutId,-sum(PayFund) from fn_clntransfer where IsChk=1 group by OutId        
union all        
   select Code,IsNull(Balance,0) from crm_client        
        
--//        
SELECT CODE,NAME,NULL AS JAN,NULL AS JANR,        
            NULL AS FEB,  NULL AS FEBR,        
            NULL AS MAR,  NULL AS MARR,        
            NULL AS APR,  NULL AS APRR,        
            NULL AS MAY,  NULL AS MAYR,        
            NULL AS JUN,  NULL AS JUNR,        
            NULL AS JUL,  NULL AS JULR,        
            NULL AS AUG,  NULL AS AUGR,        
            NULL AS SEP,  NULL AS SEPR,        
            NULL AS OCT,  NULL AS OCTR,        
            NULL AS NOV,  NULL AS NOVR,        
     NULL AS DECE, NULL AS DECER,        
            NULL AS TFUND,NULL AS TFUNDR,                                                
 NULL AS TFUNDX,NULL AS TIMES INTO #B FROM HR_EMPLOYEE WHERE isuse=1 and CODE IN (SELECT EMPID FROM SL_EMPCLIENT GROUP BY EMPID)--(SELECT SALEEMPID FROM #A GROUP BY SALEEMPID)        
        
--select *From HR_EMPLOYEE  
  
update #b set Jan= (select sum(Fund) from #a where SaleEmpId=Code and DatePart(month,xDate)=1),        
         Janr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=1),        
         Feb= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=2),        
         Febr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=2),        
         Mar= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=3),        
         Marr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=3),        
         Apr= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=4),        
         Aprr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=4),        
         May= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=5),         
         Mayr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=5),        
         Jun= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=6),        
         Junr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=6),        
         Jul= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=7),        
         Julr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=7),        
         Aug= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=8),        
         Augr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=8),        
         Sep= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=9),        
         Sepr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=9),        
         Oct= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=10),        
         Octr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=10),        
         Nov= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=11),        
         Novr= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=11),        
         Dece= (select sum(Fund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=12),        
         Decer= (select sum(PayFund)  from #a where SaleEmpId=Code and DatePart(month,xDate)=12),        
         tFund= (select sum(Fund)  from #a where SaleEmpId=Code),        
         tFundr=(select sum(PayFund)  from #a where SaleEmpId=Code),        
         tFundx=(select sum(Fundx)  from #c where ClientId in (select ClientId from sl_empclient where EmpId=Code)),        
         times= (select count(*)  from #a where SaleEmpId=Code)        
    
select -1 as xOrder,'clBlack' as FntClr,Code,Name,Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dece,tFund,Janr,Febr,Marr,Aprr,Mayr,Junr,Julr,Augr,Sepr,Octr,Novr,Decer,tFundr,tFundx,times from #b         
union all        
select 0,'clRed',null,'合计',sum(Jan),sum(Feb),sum(Mar),sum(Apr),sum(May),sum(Jun),sum(Jul),sum(Aug),sum(Sep),sum(Oct),sum(Nov),sum(Dece),sum(tFund),sum(Janr),sum(Febr),sum(Marr),sum(Aprr),sum(Mayr),sum(Junr),sum(Julr),sum(Augr),sum(Sepr),sum(Octr),sum(Novr
  
),sum(Decer),sum(tFundr),sum(tFundx),sum(times) from #b        
order by xOrder,tFund desc,times desc        
    
drop table #a        
drop table #b        
drop table #c      
      
    