-- sp_helptext  [Pr_SLRtn_ImportSLOrdInv]

select   i.FBarCodeQty as Qty,i.FPackageBarcode, i.wareid , sldl.price          
 from  TBarcodeIO i  
join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
join (select distinct f1 from dbo.Fn_SplitStrBySeprator ( '2116082136608201'  ,',' )) Spliter                 
        on i.fpackageBarcode= spliter.f1                 
        
        
        
       select sldl.Price from  TBarcodeIO i  
       join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
       join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
       where	i.FPackageBarCode ='2116082136608201'
        
       
     create index idx_wh_movedlMoveF_ID	 on	 wh_movedl(MoveF_ID)
      
     create index idx_wh_movedlinvoicedlF_ID on	 wh_movedl(invoicedlF_ID)
 
      create index idx_sl_invoicedlF_ID on	 sl_invoicedl(F_ID)


exec [Pr_SLRtn_ImportSLOrdInv] '','','008','HZ000007','2116082136608201,2116082136608201'

go

     
alter PROCEDURE [dbo].[Pr_SLRtn_ImportSLOrdInv]                                         
--declare                                        
                 @partNo varchar(50),                                        
                 @Model varchar(50),                                        
                 @WhId varchar(20),  
                 @ClientId varchar(20) ='' ,     
                 @FBarCodeList varchar(5000)=''              
                                       
AS                                  
 --2009.07.12 只显示未被停用的规格                           
 --2013.10.31 remove TPriceChangeInfo   , the price in TPriceChangeInfo  is latest price                           
/*                            
exec sl_InvRfs_Use '9014','','008','2114101925189101,2114101925189101',NULL                    
                    
        */    /*           
exec sl_InvRfs_Use '%%','%%','009','HZ000001'  
 declare                                        
                 @partNo varchar(50),   @Model varchar(50),  @WhId varchar(20),    @ClientId varchar(20) ,@FBarCodeList varchar(200)                                       
set @partNo=''                                      
set  @Model=''                                        
set  @WhId='008'                                        
set  @ClientId='HZ000007'     
set @FBarCodeList = '2116082136608201,2116082136608201'                                  
                    
-- remove invalid barcode      
    */                              
select   i.FBarCodeQty as Qty,sldl.price, i.FPackageBarcode, i.wareid  
into #TBarCodelList         
 from  TBarcodeIO i  
join wh_movedl    mvdl on i.FBillDLF_ID = mvdl.MoveF_ID
join sl_invoicedl sldl on sldl.F_ID     = mvdl.invoicedlF_ID
join sl_invoice   sl   on sl.code       = sldl.invoiceid
join (select distinct f1 from dbo.Fn_SplitStrBySeprator ( @FBarCodeList  ,',' )) Spliter                         
        on i.fpackageBarcode= spliter.f1                   
                            
create table #TInvBarCodeList(wareid varchar(30),qty  int,price decimal(19,6),  FPackageBarcode varchar(1000))                    
                    
declare @Wareid varchar(30),@FPackageBarcode varchar(1000)                    
select @Wareid =wareid from #TBarCodelList                    
while exists(select * from #TBarCodelList)                    
begin                    
   set @FPackageBarcode=''                    
   select @FPackageBarcode=@FPackageBarcode+FPackageBarcode+',' from #TBarCodelList where Wareid =@Wareid                    
   insert into #TInvBarCodeList select wareid ,SUM(qty),min(price),@FPackageBarcode from #TBarCodelList where Wareid =@Wareid group by Wareid                    
   delete #TBarCodelList where Wareid =@Wareid                    
   select @Wareid =wareid from #TBarCodelList                    
end                    
                  
--select *from sl_orderdl #TInvBarCodeList                    
-- drop table #TBarCodelList                    
-- drop table #TInvBarCodeList                    
                    
                    
if @ClientId=''     
begin    
select '请选择客户'    
return    
end    
select TOp 50  ord.Code,ord.ClientId,ord.ClientName,dl.InvDate, dl.Qty, dl.RemainQty,ord.IsTax ,dl.F_ID as   SLOrderID       
,dl.wareid,dl.Price          
into #SLOrd          
 from sl_order ord join sl_orderdl dl on ord.Code = dl.OrderId          
where ord.BillTime>'2016-1-1'          
and ord.ClientId like @ClientId    
and dl.DeliveryQty>0   
-- and ISNULL(dl.remainqty,0)<>0         
                    
select distinct    IsNull(w.PriceRate,c.PriceRate) as myRate
,w.Id,w.Model,w.PartNo,w.Brand,w.Pack,w.Origin,w.Note,w.Place,w.Cost,w.Price,w.PriceRate,w.SalePrice,w.MinPackageQty,  w.Unit  into #wr                              
from wr_ware w  left  join wr_class c on w.ClassId=c.Code                         
join    #TInvBarCodeList    as AvBar on w.id= AvBar.Wareid              
union all     
select top 100  IsNull(w.PriceRate,c.PriceRate) as myRate
,w.Id,w.Model,w.PartNo,w.Brand,w.Pack,w.Origin,w.Note,w.Place,w.Cost,w.Price,w.PriceRate,w.SalePrice  ,w.MinPackageQty,  w.Unit-- into #wr                            
      from wr_ware w                             
inner join wr_class c   on   w.ClassId= c.Code                    
where w.isUse=1     
--and  not exists(select * from #TInvBarCodeList)                  
and isnull(w.Model,'') like @Model and isnull(w.partno,'') like @partNo order by w.PartNo,w.Brand,w.Pack                                        
                               
                          
select  d.WareId,d.qty,d.Price,m.istax into #inv from sl_invoice m inner join sl_invoicedl d on ClientId=@ClientId and d.WareId in (select Id from #wr)   and m.Code=d.InvoiceId order by m.InvoiceDate desc,d.dlId desc                                      
  
select d.WareId,d.Price into #qot from sl_quote m inner join sl_quotedl d on ClientId=@ClientId and d.WareId in (select Id from #wr) and m.IsChk=1 and m.Code=d.QuoteId order by m.QuoteDate desc,d.dlId desc                                        
                                        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.WhId,d.WareId,-d.Qty+d.RmnQty,m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)                                        
union all                                       
/*                                     
select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)                                        
*/                                    
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where code='I02') and d.WareId in (select Id from #wr)                                                
union all                                                
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where code='X02') and d.WareId in (select Id from #wr)                                                
                                      
union all                                        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                                        
union all                                        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)                                        
union all                                        
select '',WhId,WareId,Qty,1 from wh_regulate where WareId in (select Id from #wr)                                  
                                        
                                      
                                      
select w.*,                                        
  IsNull((select sum(convert(decimal(19,0),Qty)) from #tmp where WareId=w.Id),0) as alStok,                                        
  -- IsNull((select sum(convert(decimal(19,0),Qty)) from #tmp where WareId=w.Id and WhId=@WhId),0) as myStok,                                        
  isnull(ord.Price, w.Cost*w.myRate) as Fund,                                        
  Isnull((select top 1 Price from #qot where WareId=w.Id),0) as QotPrice,                                        
  Isnull((select top 1 Price from #inv TV where WareId=w.Id and isnull(TV.istax,0)=1 ),0) as SlTaxPrice ,                                      
  Isnull((select top 1 Price from #inv V  where WareId=w.Id and isnull( v.istax,0)=0 ),0) as SlPrice  ,                                      
  isnull( InQ.Fcolor, 'clwhite' ) RowBgColor                      
  ,isnull(invBar.qty ,0) as qty   , invBar.Price, invBar.FPackageBarcode  as FBarCodeList                    
  ,ord.ClientId , ord.ClientName ,ord.Code ,ord.InvDate ,ord.Qty as SLOrdQty,ord.RemainQty ,  ord.Price as SLOrdPrice  ,ord.SLOrderID                          
  ,case when  ord.IsTax=1 then '含' else null end as IsTax          
from #wr w                       
left join #SLOrd  ord on w.Id = ord.WareId                                   
left join #TInvBarCodeList invBar on invBar.wareid = w.Id                                       
left join ( select distinct dl.wareid ,tr.Fcolor                          
            from ph_inquiredl dl join TPriceTrend Tr on dl.fpriceTrendcode = tr.FPriceTrendCode)as InQ on w.id= inQ.WareID                        
                                      
       
                                 
drop table #wr                                        
drop table #tmp                                        
drop table #inv                                        
drop table #qot          
drop table #SLOrd 
drop table #TInvBarCodeList
drop table #TBarCodelList