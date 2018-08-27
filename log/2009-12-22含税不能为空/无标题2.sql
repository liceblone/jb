alter        PROCEDURE [dbo].[sl_PriceOutRfs_new]                           
                 @ClientId varchar(50),                          
                 @wareid varchar(100)     ,                  
                 @DbName varchar(100)                          
AS                          
                   
/* 12-22 istax ����Ϊ��  */
      
declare @sql varchar(2000)    /*          ,        
             @ClientId varchar(50),                          
                 @wareid varchar(100)  ,                  
   @DbName varchar(100)                  
set @DbName='jbhzUserData'                  
set @ClientId='hz000548'                     
set @wareid='36401'      */                
set @sql=''                  
               
  select top 0 d.InvoiceId,m.InvoiceDate,'�ɽ�  ' as Brief,d.PartNo,d.Brand,d.Qty,d.Price ,'      ' as IsTax,      
     '       ' as Ischk ,m.TaxRate,d.Price*(1+m.TaxRate)as TaxPrice ,pack   into #TmpPriceOutRefs  from  sl_invoice m,sl_invoicedl d     
    
 
   
set @sql=                 
' insert into #TmpPriceOutRefs  select top 15 d.InvoiceId,m.InvoiceDate,'+'''�ɽ�'''+' as Brief,d.PartNo,d.Brand,d.Qty,d.Price ,case when m.isTax=1 then '''+'��˰'+''' else '''' end as IsTax,      
     case when IsChk=1 then '''+'����'+''' else '''+'δ��'+'''  end as Ischk ,m.TaxRate,d.Price*(1+m.TaxRate) ,pack   from '+@DbName+'.dbo.sl_invoice m,'+@DbName+'.dbo.sl_invoicedl d where  IsChk=1   and  m.Code=d.InvoiceId  and m.ClientId='''+@ClientId+ ''' 
 and d.wareid = '+@wareid  +'  order by InvoiceDate  desc     '              
print @sql                  
exec (@sql)              
                    
set @sql=     
 ' insert into #TmpPriceOutRefs select top 10  d.InvoiceId,m.InvoiceDate,'+'''�ɽ�'''+' as Brief,d.PartNo,d.Brand,d.Qty,d.Price ,case when m.isTax=1 then '''+'��˰'+''' else '''' end as IsTax,      
     case when IsChk=1 then '''+'����'+''' else '''+'δ��'+'''  end as Ischk ,m.TaxRate,d.Price*(1+m.TaxRate) ,pack from '+@DbName+'.dbo.sl_invoice m,'+@DbName+'.dbo.sl_invoicedl d where isnull(IsChk,'''+'0'+''')=0 and  m.Code=d.InvoiceId  and m.ClientId='''+
@ClientId+ '''  and d.wareid = ' +@wareid    +'  order by InvoiceDate  desc     '       
print @sql                  
exec (@sql)              
      
set @sql=       
 'insert into #TmpPriceOutRefs select  top 10 d.QuoteId,m.QuoteDate,'+'''����'''+' as Brief,d.PartNo,d.Brand,d.Qty,d.Price,'''' as Istax,      
case when IsChk=1 then '''+'����'+''' else '''+'δ��'+'''  end as Ischk ,0 as taxrate,0 as TaxPrice,pack       
from '+@DbName+'.dbo.sl_quote m,'+@DbName+'.dbo.sl_quotedl d where m.Code=d.QuoteId  and m.ClientId='''+@ClientId +''' and d.wareid = '+@wareid                            
+'  order by m.QuoteDate  desc     '                  
print @sql                  
exec (@sql)              
    
select * From #TmpPriceOutRefs order by InvoiceDate  desc     
  
drop table #TmpPriceOutRefs  
  
  
