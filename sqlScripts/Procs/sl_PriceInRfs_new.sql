 
 go
 alter       PROCEDURE [dbo].[sl_PriceInRfs_new]                               
                 @PartNo varchar(100)       ,                
                 @DBname varchar(100)                             
AS                              
   /*                         
declare  @PartNo varchar(100)  ,                  
       @DBname varchar(100)                      
set @PartNo='4007'                  
set @DBname='jbhzuserdata'                
  */                  
                
declare @sql varchar(8000)                
    
CREATE TABLE ##tmp(    
 [wareid] [int] NOT NULL,    
 [InId] [varchar](20) NOT NULL,    
 [InDate] [smalldatetime] NOT NULL,    
 [Brief] [varchar](30) NULL,    
 [PartNo] [varchar](300) NOT NULL,    
 [Brand] [varchar](50) NULL,    
 [Qty] [int] NOT NULL,    
 [Price] [varchar](10) NULL,   
  [pack] [varchar](30) NULL  ,   
 [TaxPrice] [varchar](10) NULL,    
 TaxRate varchar(10)  
)     
  
         
set @sql=  '  
  insert into ##tmp  
  select top 50  d.wareid,d.InId,m.InDate,  
 (select whName from '+@DBname+'.dbo.wh_inout where Code=m.InTypeId) as Brief,d.PartNo,d.Brand,d.Qty  
, convert(decimal(19,6),ph.TaxPrice/(1+ph.TaxRate )) as Price    ,  d.pack    
, case when m.intypeid=''I01''and isnull(ph.TaxRate,0)<>0 then ph.TaxPrice         else  null end as TaxPrice  
, convert(decimal(2,0),case when ph.TaxRate=0 then null else ph.TaxRate*100 end) as TaxRate  
  from '+@DBname+'.dbo.wh_in m   
  join '+@DBname+'.dbo.wh_indl d  on  m.Code=d.InId    
  left join (  select convert(decimal(19,6),price) as TaxPrice, pm.whincode   ,pd.wareid ,pm.TaxRate   
                              from '+@DBname+'.dbo.ph_arrivedl  pd         
                              join '+@DBname+'.dbo.ph_arrive    pm  on pd.arriveid=pm.code    
                               ) as Ph on m.Code  = ph.WhInCode and ph.WareId = d.WareId  
   where   m.IsChk=1 and m.InTypeId in (''I01'',''I08'',''I09'')   
  and PartNo like '+'''%'+@PartNo+'%'''   
  +'  order by  m.InDate desc'  
        
print @sql                
exec  ( @sql)                   
                
                
                
/*                
declare  @PartNo varchar(100)  ,                  
       @DBname varchar(100)   ,                
 @sql varchar(8000)                   
set @PartNo='4021'                  
set @DBname='hzjb03a'                
*/                
                
  
set  @sql=   '  
 select top 50  *, case when isnull(taxRate,0)=0 then ''clblack'' else ''clred'' end as fntclr  from ##tmp      
      union all    
      select null,null,billtime,''价格浮动.修改人:''+b.Name ,partno,Brand,null,convert(varchar(10),minprice),pack ,null,null   
       ,''clblack'' as fntclr   
       from '+@DBname+'.dbo.TPriceChangeInfo     
       join '+@DBname+'.dbo.hr_employee      B on BillManId=B.Code   where wareid in (select wareid from ##tmp )    
         order by InDate  desc '  
            
print @sql                              
exec  ( @sql)                  
                
drop table ##tmp                    
  