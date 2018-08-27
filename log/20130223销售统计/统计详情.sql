CREATE  PROCEDURE [sl_GetEmpSaledl]           
--                 @WhId varchar(20),         --  sl_GetEmpSaledl '0052','2010-1-17','2010-2-17'  
                 @EmpId varchar(20),          
                 @BeginDate DateTime,          
                 @EndDate Datetime          
AS          
--   if @WhId is null           
--      set @WhId=''          
--   set @WhId=@WhId+'%'          
--WhId like @WhId and          
set @BeginDate=@BeginDate-1          
set @EndDate=@EndDate+1          
          
   select ClientId,GatheringEmp as SaleEmpId,InvoiceDate as xDate,GetFund as Fund,PayFund into #a from sl_invoice where IsChk=1 and InvoiceDate>@BeginDate and InvoiceDate<@EndDate          
   union all          
   select ClientId,null,ReturnDate,-GetFund,0 from sl_return where IsChk=1 and ReturnDate>@BeginDate and ReturnDate<@EndDate          
   union all          
   select ClientId,null,InDate,PayFund,0 from fn_shldin where IsChk=1 and ItemId='0100' and InDate>@BeginDate and InDate<@EndDate          
   union all          
   select ClientId,null,OutDate,-PayFund,0 from fn_shldout where IsChk=1 and ItemId='0100' and OutDate>@BeginDate and OutDate<@EndDate          
   union all          
   select ClientId,null,ReceiverDate,0,PayFund from fn_receiver where IsChk=1 and ReceiverDate>@BeginDate and ReceiverDate<@EndDate          
    
  
union all    
select ClientId,null ,paymentDate,0 , -(PayFund) from fn_payment where IsChk=1   and paymentDate>@BeginDate and paymentDate<@EndDate         
union all    
   select InId,null,  trnsfrDate ,0 ,  -PayFund from fn_clntransfer where IsChk=1    and trnsfrDate>@BeginDate and trnsfrDate<@EndDate      --2011-1-17    
union all          
   select OutId,null,  trnsfrDate, 0 , PayFund from fn_clntransfer where IsChk=1    and trnsfrDate>@BeginDate and trnsfrDate<@EndDate         
/*  */  
--2006-8-7以上加已审核标志        
        
--   delete from #a where ClientId in (select ClientId from sl_empclient where EmpId<>@EmpId)      select top 1000 * From fn_item  fn_payment  fn_clntransfer    
          
--   update #a set SaleEmpId=(select SaleEmpId from crm_client where Code=ClientId)          
--//          
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
          
   select Code,Name,null as Jan,null as Janr,          
                    null as Feb,null as Febr,       
                    null as Mar,null as Marr,          
                    null as Apr,null as Aprr,          
                    null as May,null as Mayr,          
                    null as Jun,null as Junr,          
                    null as Jul,null as Julr,          
                    null as Aug,null as Augr,          
                    null as Sep,null as Sepr,          
                    null as Oct,null as Octr,          
                    null as Nov,null as Novr,          
                    null as Dece,null as Decer,          
                    null as tFund,null as tFundr,          
         null as tFundx,null  as MinusAccountsDue ,null as times into #b from crm_client where Code in (select ClientId from sl_empclient where EmpId=@EmpId)--(select ClientId from #a group by ClientId)          
          
   update #b set Jan=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=1),          
                 Janr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=1),          
                 Feb=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=2),          
                 Febr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=2),          
                 Mar=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=3),          
                 Marr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=3),          
                 Apr=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=4),          
                 Aprr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=4),          
                 May=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=5),          
                 Mayr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=5),          
                 Jun=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=6),          
                 Junr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=6),          
                 Jul=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=7),          
                 Julr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=7),          
                 Aug=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=8),          
                 Augr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=8),          
                 Sep=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=9),          
                 Sepr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=9),          
                 Oct=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=10),          
                 Octr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=10),          
                 Nov=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=11),          
                 Novr=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=11),          
                 Dece=(select sum(Fund) from #a where ClientId=Code and DatePart(month,xDate)=12),          
                 Decer=(select sum(PayFund) from #a where ClientId=Code and DatePart(month,xDate)=12),          
                 tFund=    (select sum(Fund) from #a where ClientId=Code   )  ,        --heji     
                 tFundr=   (select sum(PayFund) from #a where ClientId=Code)  ,  --shou        
                 tFundx=   (select sum(Fundx) from #c where ClientId=Code  )   ,    -- yu      
                 MinusAccountsDue  =isnull( (select sum(-Fund ) from #a where ClientId=Code and Fund<0) ,0) ,    -- yu      
  
                 times=(select count(*) from #a where ClientId=Code)          
          
   select -1 as xOrder,'clBlack' as FntClr,Code,Name,Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dece,tFund,Janr,Febr,Marr,Aprr,Mayr,Junr,Julr,Augr,Sepr,Octr,Novr,Decer,tFundr,tFundx,times ,MinusAccountsDue   from #b           
   union all          
   select 0,'clRed',null,'合计',sum(Jan),sum(Feb),sum(Mar),sum(Apr),sum(May),sum(Jun),sum(Jul),sum(Aug),sum(Sep),sum(Oct),sum(Nov),sum(Dece),sum(tFund),sum(Janr),sum(Febr),sum(Marr),sum(Aprr),sum(Mayr),  
          sum(Junr),sum(Julr),sum(Augr),sum(Sepr),sum(Octr),sum( Novr),sum(Decer),sum(tFundr),sum(tFundx),sum(times),sum(MinusAccountsDue) from #b      
  
   order by xOrder,tFund desc,times desc          
          
   drop table #a          
   drop table #b          
   drop table #c        
        
      
    
  