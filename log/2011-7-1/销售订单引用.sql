    CREATE PROCEDURE [dbo].[GetSlOrderdlRfs]     
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
  