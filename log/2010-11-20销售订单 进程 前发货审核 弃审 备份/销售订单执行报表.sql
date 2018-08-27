   

create  proc Pr_SLOrderExeProgressDL  
@ClientID varchar(20),  
@BeginDate smalldatetime,  
@endDate   smalldatetime,  
@PartNo    varchar(30),  
@Model     varchar(30),  
@Brand    varchar(30),  
@Pack    varchar(30),  
@Origin  varchar(30)  


as

 

select  M.Code,M.ClientId,M.OrderDate,M.Buyer,M.BuyerTel,M.BuyerFax,M.TransportId,M.LinkMan,M.LinkTel,M.LinkFax,M.DeliverAddr,
M.Zip,M.SaleManId,M.BillManId,M.BillTime,M.ChkManId,M.ChkTime,M.Note,M.ClientName,M.IsChk, M.IsClose ,
DL.WareId,DL.PartNo,DL.Brand,DL.Qty,DL.Price,DL.InvDate,DL.dlNote,DL.Origin, isnull( sl.qty,0) as DeliveryQty ,DL.Qty -isnull( sl.qty,0)   as UnDeliveryQty

from sl_order M
join sl_orderdl DL on M.Code=DL.OrderID
join wr_ware   wr on wr.id =dl.wareid
left join (select slOrderID , wareid ,sum(qty) as qty From sl_invoicedl group by slOrderID , wareid )
          as SL on SL.SlorderID=DL.orderiD and sl.slOrderid=dl.orderid and sl.wareid=dl.wareid

where m.clientid like isnull(@ClientID ,'') +'%' 
and M.OrderDate>=@BeginDate  
and M.OrderDate<=@endDate   
and isnull(dl.PartNo ,'')like isnull( @PartNo   ,'')  +'%' 
and isnull(wr.model  ,'')like  isnull( @Model   ,'')  +'%' 
and isnull(dl.Brand  ,'')like   isnull( @Brand   ,'')  +'%' 
and isnull(dl.Origin  ,'')like   isnull( @Origin   ,'')  +'%'  


go




create   proc Pr_SLOrderExeProgressM  
@ClientID varchar(20),  
@BeginDate smalldatetime,  
@endDate   smalldatetime,  
@PartNo    varchar(30),  
@Model     varchar(30),  
@Brand    varchar(30),  
@Pack    varchar(30),  
@Origin  varchar(30)  


as

 

select  M.Code,M.ClientId,M.OrderDate,M.Buyer,M.BuyerTel,M.BuyerFax,M.TransportId,M.LinkMan,M.LinkTel,M.LinkFax,M.DeliverAddr,
M.Zip,M.SaleManId,M.BillManId,M.BillTime,M.ChkManId,M.ChkTime,M.Note,M.ClientName,M.IsChk, M.IsClose ,
DL.WareId,DL.PartNo,DL.Brand,DL.Qty,DL.Price,DL.InvDate,DL.dlNote,DL.Origin, isnull( sl.qty,0) as DeliveryQty ,DL.Qty -isnull( sl.qty,0)   as UnDeliveryQty

into #tmp
from sl_order M
join sl_orderdl DL on M.Code=DL.OrderID
join wr_ware   wr on wr.id =dl.wareid
left join (select slOrderID , wareid ,sum(qty) as qty From sl_invoicedl group by slOrderID , wareid )
          as SL on SL.SlorderID=DL.orderiD and sl.slOrderid=dl.orderid and sl.wareid=dl.wareid

where m.clientid like isnull(@ClientID ,'') +'%' 
and M.OrderDate>=@BeginDate  
and M.OrderDate<=@endDate   
and isnull(dl.PartNo ,'')like isnull( @PartNo   ,'')  +'%' 
and isnull(wr.model  ,'')like  isnull( @Model   ,'')  +'%' 
and isnull(dl.Brand  ,'')like   isnull( @Brand   ,'')  +'%' 
and isnull(dl.Origin  ,'')like   isnull( @Origin   ,'')  +'%'  

select ClientName ,ClientId ,   sum(Qty) as Qty,sum(isnull( DeliveryQty,0)) as DeliveryQty ,sum( UnDeliveryQty) as UnDeliveryQty 
From #tmp
group by ClientName ,ClientId 

drop table #tmp




go




alter PROCEDURE [dbo].[GetSlOrderdlRfs]   
                 @OrderId varchar(50),  
                 @WhId varchar(20)  
AS  
  
select w.*,w.WareId as Id,  
       Isnull((select sum(d.qty) from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 and d.WareId=w.WareId),0)-  
       Isnull((select sum(d.qty) from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 and d.WareId=w.WareId),0)  
       as alStok,  
       Isnull((select sum(d.qty) from wh_in m inner join wh_indl d  on m.Code=d.InId and m.IsChk=1 and m.WhId=@WhId and d.WareId=w.WareId),0)-  
       Isnull((select sum(d.qty) from wh_out m inner join wh_outdl d on m.Code=d.OutId and m.IsChk=1 and m.WhId=@WhId and d.WareId=w.WareId),0)  
       as myStok  
       , isnull( sl.qty,0) as DeliveryQty ,w.Qty -isnull( sl.qty,0)   as UnDeliveryQty
 from sl_orderdl w 
left join (select slOrderID , wareid ,sum(qty) as qty From sl_invoicedl group by slOrderID , wareid )
          as SL on SL.SlorderID=w.orderiD  and sl.wareid=w.wareid
where w.OrderId=@OrderId 
order by


w.Qty -isnull( sl.qty,0)  desc  , w.dlId  






go

alter  PROCEDURE [dbo].[sl_order_open]     
                 @LoginId varchar(50)    
AS    
  
declare @empid varchar(20)  
select @empid =empid  from sys_user where loginid=@LoginId  
  
select A.*, case when clt.UseSLOrdToDeliver=1 then '¡Ì' else '' end as UseSLOrdToDeliverlkp
   from sl_order A
join crm_client clt on A.clientid=clt.code
 where   
(  
select IsAdmin from sys_user where LoginId=@LoginId)=1 or   
ClientId in (select Code from crm_client where IsPub=1) or   
ClientId in (select ClientId from crm_ClientEmp where EmpId=(select EmpId from sys_user where LoginId=@LoginId) or   
ClientId in (select Code from crm_client where classid in (select ClassCode From Crm_ActorClientClass where Actorid in  (select GroupID from sys_groupuser  where UserID=@LoginId)   ) )     
) order by A.code desc    
    
