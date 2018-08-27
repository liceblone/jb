alter  PROCEDURE [dbo].[SaleReference]             
                 @MyWhId varchar(20),            
                 @Model varchar(50),            
                 @PartNo varchar(100),            
   @ClientID  varchar(100)     ,
 @pack varchar(30),
@brand varchar(30)      
AS           

if  @Model ='' and    @PartNo ='' and                @ClientID  ='' and    @pack ='' and   @brand    =''
select '请至少输入一个条件'   as    PartNo    

else
begin
	
	    /*   
	  declare               @Model varchar(50)            
	  declare               @PartNo varchar(100)            
	  declare @ClientID  varchar(100) 
	    declare        @pack varchar(30) 
           declare @brand varchar(30)  
	set @ClientID=''    
	 set @Model=''            
	  set @PartNo=''             
	  set          @pack=''
	 set  @brand=''
	 */
	--2006-7-12 更改调拨部分           
	          
	select IsNull(w.PriceRate,c.PriceRate) as myRate,w.* into #wr from wr_ware w inner join wr_class c on w.ClassId=c.Code 
	where w.Model like '%'+@Model+'%' and w.PartNo like '%'+@PartNo+'%'  
	     and isnull(pack,'') like @pack   +'%'   and  isnull(brand ,'') like  @brand +'%' 
	    
	     
	select d.WareId,d.qty,d.Price,m.ClientId ,m.invoicedate 
         into #invsl 
        from sl_invoice m inner join sl_invoicedl d on   m.Code=d.InvoiceId and ClientId like @ClientId+'%' and d.WareId in (select Id from #wr) and IsChk=1 order by m.InvoiceDate desc,d.dlId desc          
	         
	select d.WareId,d.Price,m.quotedate 
         into #qot 
        from sl_quote m inner join sl_quotedl d on  m.Code=d.QuoteId  and  ClientId like @ClientId+'%' and d.WareId in (select Id from #wr) and m.IsChk=1 order by m.QuoteDate desc,d.dlId desc          
	     
	 
	select    clt.name, sl.WareId   ,wr.model,wr.partno,wr.pack,wr.brand ,  
     
	    qt.Price  as QotPrice, qt.quotedate      ,           sl.Price as SlPrice   ,sl.invoicedate  
          ,        pch.MaxPrice,     pch.MinPrice
	  
	from            #invsl      sl    
	left join   #qot          qt     on qt.WareId= sl.WareId    
	left join   TPriceChangeInfo  pch     on pch.WareId= sl.WareId
	left join  crm_client    clt  on  sl.ClientId=clt.code
	left join  wr_ware       wr   on wr.id= sl.WareId    
	--select *From crm_client 
	
	
	
	drop table #invsl
	drop table  #qot
	drop table #wr            
          
end
 
  
