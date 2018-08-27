alter           view Wr_ware                                    
as                                       
select                              
A.Id ,A.MemeberId,A.ClassId,A.Model,                            
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                            
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                            
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID, 
----***Local Data**----                           
A.BJjb_MinPos as MinPos,A.BJjb_Cost   as Cost ,                            
A.BJjb_Price  as Price ,A.BJjb_PriceRate as PriceRate ,                            
A.BJjb_SalePrice as SalePrice ,A.BJjb_IsCommon  as IsCommon  ,         
----***************----             
A.IsPub       ,                    
A.createManName   ,              
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,            
A.IsChk   ,IsUpload  ,        
A.HZUseSerialNo as UseSerialNo ,       
A.RsSurfix , A.ShipTo      
From jbhzuserdata.dbo.T_AllWares A                  
              left   join wr_class   B on A.ClassId=B.code                      
where ( isnull(B.IsPrivate,0) =0  or A.Place='jBBjuserdata'         ) 


/*
select * into Wr_ware20131020  from 	 Wr_ware

update wr_ware	set MinPos=hisWr.MinPos  ,  Cost=hisWr.Cost	,  Price=hisWr.Price ,   PriceRate=hisWr.PriceRate ,SalePrice=hisWr.SalePrice , IsCommon=hisWr.IsCommon
-- select wr.MinPos ,hisWr.MinPos  ,  wr.Cost,hisWr.Cost	,  wr.Price,hisWr.Price ,   wr.PriceRate,hisWr.PriceRate ,wr.SalePrice,hisWr.SalePrice , wr.IsCommon,hisWr.IsCommon
from wr_ware wr
join wr_ware20131020 hisWr on wr.id=hisWr.id

select wr.MinPos ,hisWr.MinPos  ,  wr.Cost,hisWr.Cost	,  wr.Price,hisWr.Price ,   wr.PriceRate,hisWr.PriceRate 
,wr.SalePrice,hisWr.SalePrice , wr.IsCommon,hisWr.IsCommon
from wr_ware wr
join wr_ware20131020 hisWr on wr.id= hisWr.id
where
isnull( wr.MinPos ,0)<> isnull( hisWr.MinPos ,0)
or  isnull(wr.Cost,0) <> isnull( hisWr.Cost,0)
or isnull( wr.Price,0) <>isnull(hisWr.Price ,0)
or  isnull(wr.PriceRate,0 ) <> isnull( hisWr.PriceRate ,0)
or  isnull(wr.SalePrice, 0) <>isnull( hisWr.SalePrice ,0)
or  isnull( wr.IsCommon,0)<> isnull( hisWr.IsCommon   ,0)



*/
