sp_helptext Pr_BarCodeWarehouse
go
exec Pr_BarCodeWarehouse '2016-07-06 00:00:00','2016-08-05 00:00:00','%','2116080536604701%','%','%','%','%','%'

go

      
  --  exec Pr_BarCodeWarehouse '2016-05-20 00:00:00','2016-06-19 00:00:00','%','%','%','%','%','%','%'  
    
        
alter proc Pr_BarCodeWarehouse      
@BeginDate smalldatetime,      
@EndDate   smalldatetime,          
@FBillCode varchar(30),  
@FPackageBarCode varchar(30),  
@Whid varchar(10)  ,    
@Model  varchar(20)='%',    
@PartNo varchar(20)='%',    
@Pack   varchar(20)='%',    
@Brand  varchar(20)='%'    
as      
      
--select * from wh_warehouse      
select bar.*, wh.Name as WhName      
,wr.PartNo,wr.Model,wr.Brand,wr.Pack,wr.Origin,wr.RsSurfix      
--, case when bar.FOutisChk=1 then 'clred' else 'clblue'end fntclr    
--,ivitem.ClientName, ivitem.ClientId, ivitem.InvoiceDate, ivitem.InvoiceId  ,ivitem.MoveId    
 from tbarcodestorage bar join wh_warehouse wh on bar.whid= wh.Code      
join wr_ware wr on bar.Wareid =wr.id      
   
 where bar.CreateTime>=@BeginDate and bar.CreateTime<=@EndDate +1     
and bar.FPackageBarcode like @FPackageBarCode+'%'      
and bar.FBarCode like @FBillCode  +'%'     
and bar.whid like @Whid  +'%'     
      
 order by bar.whid ,FBarCode,CreateTime desc      
      