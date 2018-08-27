alter           view Wr_ware                                  
as                                     
select                            
A.Id ,A.MemeberId,A.ClassId,A.Model,                          
A.PartNo,A.Brand,A.Pack,A.Origin,A.Unit,A.SafePos,                          
A.MaxPos,A.Note,A.Stock,A.IsUse,A.IsTmp,                          
A.Place,A.CreateDataTime,A.CreateManID,A.ReplaceWareID,        
----***Local Data**---- should be fixed                           
A.hZjb_MinPos as MinPos,A.hZjb_Cost   as Cost ,                          
A.hZjb_Price  as Price ,A.hZjb_PriceRate as PriceRate ,                          
A.hZjb_SalePrice as SalePrice ,A.hZjb_IsCommon  as IsCommon  ,   
----***************----                                   
A.IsPub       ,                  
A.createManName   ,            
A.IsDel   ,  A.DelTime,A.DelManId,A.DelManPlace ,          
A.IsChk   ,IsUpload  ,      
A.HZUseSerialNo as UseSerialNo ,     
A.RsSurfix , A.ShipTo    
From jbhzuserdata.dbo.T_AllWares A                
                 join wr_class   B on A.ClassId=B.code                    
where ( isnull(B.IsPrivate,0) =0  or A.Place='jbSzuserdata'         ) 