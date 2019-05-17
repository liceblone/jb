	create function Fn_BarcodeQtyDecode(@strQty varchar(30)) returns int
begin
   declare @rlt int
   return @rlt
end

go
	exec Pr_GetBarCodeInfomation  '54412-4k-1000579' , '54412-4k-100' , ''
						  go
						  
						  
   
  CREATE proc Pr_GetBarCodeInfomation                                 
 @FBarCode        varchar(30),                                
 @FPackageBarCode varchar(30),                       
 @invoicedlF_ID       varchar(30)='',                           
 @wareid varchar(20)='',                                
 @OutWhid varchar(20)='',                                
 @InWhid varchar(20)='',                                
 @ClientID varchar(20)=''                                
 as                                
  /*                    
      */                     
               
   declare  @FBarCode        varchar(30),                                
 @FPackageBarCode varchar(30),                                
 @wareid varchar(20)='',                                
 @OutWhid varchar(20)='',                                
 @InWhid varchar(20)='',                                
 @ClientID varchar(20)=''                       
 set   @FBarCode = '54412-4k-1000579'                   
 set @FPackageBarCode = '54412-4k-100'                    
                     
                    
          
  
          
  
declare @OriginalBarCode varchar(30)  , @wareid int , @Cnt int	,  @FBarCodeQty int 


set @OriginalBarCode= @FBarCode 
set @Cnt =  ( select count(1) from dbo.fn_splitstrbySeprator(@FbarCode ,'-' ))
set @wareid =  select * from wr_ware where id = ( select f1 from dbo.fn_splitstrbySeprator(@FbarCode ,'-' )where Frow=1	)
set @FBarCodeQty = select * from wr_ware where id = ( select f1 from dbo.fn_splitstrbySeprator(@FbarCode ,'-' )where Frow=2	)

if   @Cnt =3
	  and exists( select * from wr_ware where id = ( select f1 from dbo.fn_splitstrbySeprator(@FbarCode ,'-' )where Frow=1	)  )
begin


end
else      
begin
    set @FBarCode = dbo.Fn_FixFBarCode(@FBarCode, 'HS')                    
    print @FBarCode                    
                                 
    select distinct stg.FBarCode , sum(stg.FBarCodeQty )as FBarCodeQty ,  max(stg.FPackageBarcode)as FPackageBarcode                            
    , sum(stg.FPackageqty)FPackageqty , stg.Wareid   --, sum(dl.Qty) Qty ,dl.F_ID                             
    into #tmp                                        -- from #sl_invoice  dl --on m.Code = dl.InvoiceId   --  and m.ClientId ='hz000001'                                
    from TBarcodeStorage stg              
    where        FFixedBarCode    = @FBarCode                     
    group by stg.FBarCode ,      stg.WareId                             
              
    union all                                  
    select distinct stg.FBarCode , isnull(pti.FMimPackageQty,5000) as  FBarCodeQty , stg.FPackageBarcode
     , stg.FPackageqty, stg.Wareid       
     --into #tmp                            --, dl.Qty ,dl.F_ID                                     
    from TBarcodeStorage stg                        
    join TPesistorToInventory  pti on stg.Wareid  = pti.Wareid                           
    where      stg.FPackageBarCode =SUBSTRING( @FBarCode ,1,9)  --and     stg.FPackageBarCode =SUBSTRING( 611003810 ,1,9)                                  
                         
    insert into TErrorBarCodeScanned (Fbarcode, FpackageBarcode,wareid)                        
    select @FBarCode,@FPackageBarCode,'' where not exists(select * from #tmp)                        
        
    if exists(   select * from #tmp   )                         
        select * from #tmp     
    else   
    begin  
        select TOp 100 * from TBarcodeIO where FPackageBarCode = @OriginalBarCode  
        print @OriginalBarCode  
    end  
end
             
   drop table #tmp               
   --drop table #sl_invoice