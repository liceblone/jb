alter table wh_warehouse  add HasWarehousePos bit default 0


select * From wh_warehouse

select * From T_WarehousePosition where WareCode like :WareCode

drop table T_WarehousePosition

create table T_WarehousePosition
(
PosID int identity(100,1) primary key not null,
PosName varchar(20) not null,
Note   varchar(200),
WareCode varchar(20)

)


alter table T_AllWares drop   DF__T_AllWare__UseSe__039C5DE8
alter table T_AllWares drop  column UseSerialNo

alter table T_AllWares  add HZUseSerialNo bit default 0
alter table T_AllWares  add WZUseSerialNo bit default 0
alter table T_AllWares  add YQUseSerialNo bit default 0
alter table T_AllWares  add BjUseSerialNo bit default 0


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
A.hZjb_MinPos as MinPos,A.hZjb_Cost   as Cost ,                    
A.hZjb_Price  as Price ,A.hZjb_PriceRate as PriceRate ,                    
A.hZjb_SalePrice as SalePrice ,A.hZjb_IsCommon  as IsCommon  ,              
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
A.hZjb_MinPos as MinPos,A.hZjb_Cost   as Cost ,                    
A.hZjb_Price  as Price ,A.hZjb_PriceRate as PriceRate ,                    
A.hZjb_SalePrice as SalePrice ,A.hZjb_IsCommon  as IsCommon  ,              
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
A.hZjb_MinPos as MinPos,A.hZjb_Cost   as Cost ,                    
A.hZjb_Price  as Price ,A.hZjb_PriceRate as PriceRate ,                    
A.hZjb_SalePrice as SalePrice ,A.hZjb_IsCommon  as IsCommon  ,              
A.IsPub       ,            
A.createManName   ,      
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,    
A.IsChk   ,IsUpload  ,
A.BjUseSerialNo as UseSerialNo
From jbhzuserdata.dbo.T_AllWares A          
                 join wr_class   B on A.ClassId=B.code              
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbbjuserdata'         )          
    
sp_helptext wr_ware



select * From T507

select *  from T616  
select * into  T616_20090509 from T616  


delete T616  where f01='ph_ArriveX'

sp_help T507 


select * From t202 where f02=907 and f01=1129


delete t202 where f02=907 and f01=1129
