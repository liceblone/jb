use jbhzuserdata
go
alter           view Wr_ware                            
as                               
select                      
A.Id ,A.MemeberId,A.ClassId,A.Model,                    
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                    
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                    
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID,                    
A.hZjb_MinPos as MinPos,A.hZjb_Cost   as Cost ,                    
A.hZjb_Price  as Price ,A.hZjb_PriceRate as PriceRate ,                    
A.hZjb_SalePrice as SalePrice ,A.hZjb_IsCommon  as IsCommon  ,              
A.IsPub       ,            
A.createManName   ,      
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,    
A.IsChk   ,IsUpload  ,
A.HZUseSerialNo as UseSerialNo
From jbhzuserdata.dbo.T_AllWares A          
                 join wr_class   B on A.ClassId=B.code              
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbhzuserdata'         )          
    
     

use jbwzuserdata
go
alter           view Wr_ware                            
as                               
select                      
A.Id ,A.MemeberId,A.ClassId,A.Model,                    
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                    
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                    
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID,                    
A.WZjb_MinPos as MinPos,A.WZjb_Cost   as Cost ,                    
A.WZjb_Price  as Price ,A.WZjb_PriceRate as PriceRate ,                    
A.WZjb_SalePrice as SalePrice ,A.WZjb_IsCommon  as IsCommon  ,              
A.IsPub       ,            
A.createManName   ,      
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,    
A.IsChk   ,IsUpload  ,
A.WZUseSerialNo as UseSerialNo
From jbhzuserdata.dbo.T_AllWares A          
                 join wr_class   B on A.ClassId=B.code              
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbwzuserdata'         )          
    
     

use jbyquserdata
go
alter           view Wr_ware                            
as                               
select                      
A.Id ,A.MemeberId,A.ClassId,A.Model,                    
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                    
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                    
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID,                    
A.YQjb_MinPos as MinPos,A.YQjb_Cost   as Cost ,                    
A.YQjb_Price  as Price ,A.YQjb_PriceRate as PriceRate ,                    
A.YQjb_SalePrice as SalePrice ,A.YQjb_IsCommon  as IsCommon  ,              
A.IsPub       ,            
A.createManName   ,      
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,    
A.IsChk   ,IsUpload  ,
A.YQUseSerialNo  as UseSerialNo
From jbhzuserdata.dbo.T_AllWares A          
                 join wr_class   B on A.ClassId=B.code              
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbyquserdata'         )          
    
     

use jbbjuserdata
go
alter           view Wr_ware                            
as                               
select                      
A.Id ,A.MemeberId,A.ClassId,A.Model,                    
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                    
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                    
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID,                    
A.BJjb_MinPos as MinPos,A.BJjb_Cost   as Cost ,                    
A.BJjb_Price  as Price ,A.BJjb_PriceRate as PriceRate ,                    
A.BJjb_SalePrice as SalePrice ,A.BJjb_IsCommon  as IsCommon  ,              
A.IsPub       ,            
A.createManName   ,      
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,    
A.IsChk   ,IsUpload  ,
A.BjUseSerialNo as UseSerialNo
From jbhzuserdata.dbo.T_AllWares A          
                 join wr_class   B on A.ClassId=B.code              
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbbjuserdata'         )          
    

 

alter table  T_AllWares add BJjb_MinPos  decimal(19,3)
alter table  T_AllWares add BJjb_Cost  decimal(19,3)

alter table  T_AllWares add BJjb_Price  decimal(19,3)
alter table  T_AllWares add BJjb_PriceRate  decimal(19,3)

alter table  T_AllWares add BJjb_SalePrice  decimal(19,3)
alter table  T_AllWares add BJjb_IsCommon bit



select hzjb_cost,hzjb_price,wzjb_cost,wzjb_price, *from T_AllWares where hzjb_cost is not null and wzjb_cost is null and createdataTime>'2009-5-10' and place='JbWzUserData'

update T_AllWares set wzjb_cost=hzjb_cost,wzjb_price=Hzjb_price  where hzjb_cost is not null and wzjb_cost is null and createdataTime>'2009-5-10' and place='JbWzUserData'



