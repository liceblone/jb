



alter   PROCEDURE [dbo].[wh_StokMinWarningAndPhP]       
                 @Model varchar(50),      
                 @PartNo varchar(100),      
                 @ClassId varchar(50)  ,    
                 @YDdbName varchar(50),    
                 @localDB varchar(20)   ,
                @pack varchar(20),
                @brand varchar(30) 
                     
AS    
  
/*
declare           @Model varchar(50),      
                 @PartNo varchar(100),      
                 @ClassId varchar(50)  ,    
                 @YDdbName varchar(50),    
                 @localDB varchar(20) ,    
                @pack varchar(20),
                @brand varchar(30) 
                      
set @Model=''  
set @PartNo=''  
set @ClassId=''  
set @YDdbName='jbwzuserdata'  
set @localDB='jbhzuserdata' 
set @pack=''
set @brand=''

 
*/  
  
  
  
--select id,model,partno,Brand,pack,origin,safePos,maxPos,MinPos,Cost,Price  From wr_ware      
    
select id,model,partno,Brand,pack,origin,safePos,maxPos,MinPos,Cost,Price  into   #wr from wr_ware w       
where iscommon=1 and isuse=1 and  isnull(istmp,0)=0 and w.Model like '%'+@Model+'%' and w.PartNo like '%'+@PartNo+'%' 
     and w.ClassId like @ClassId+'%' and isnull(pack,'') like       @pack +'%'and isnull(  brand,'') like @brand+'%'
    
    
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk into #tmp from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId  where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from ph_return m inner join ph_returndl d on m.Code=d.ReturnId  where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,-d.Qty+d.RmnQty,m.IsChk from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.InWhId,d.WareId,d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.OutWhId,d.WareId,-d.Qty,m.IsChk from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,d.Qty,m.IsChk from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)        
union all        
select m.Code,m.WhId,d.WareId,-d.Qty,m.IsChk from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)        
union all        
select '',WhId,WareId,Qty,1 from wh_regulate where WareId in (select Id from #wr)    
    
    
    
select *, isnull( (select sum(isnull(qty,0)) From #tmp where WareId=w.Id             ) ,0)as RealQty,    
          isnull( (select sum(isnull(qty,0)) From #tmp where WareId=w.Id and ischk=1 ) ,0)as SysQty    
into #NoCompare    
from #wr W    
  
    
if  @localDB = @YDdbName    
begin    
   alter table #NoCompare add PhQty int   
   select *From #NoCompare  where MinPos>RealQty  
end    
else  
begin  

/*
	declare           @Model varchar(50),      
	                 @PartNo varchar(100),      
	                 @ClassId varchar(50)  ,    
	                 @YDdbName varchar(50),    
	                 @localDB varchar(20) ,    
	                @pack varchar(20),
	                @brand varchar(30) 
	                      
	set @Model=''  
	set @PartNo=''  
	set @ClassId=''  
	set @YDdbName='jbwzuserdata'  
	set @localDB='jbhzuserdata' 
	set @pack=''
	set @brand=''
	*/
	
	       declare @sql varchar(8000)  
	      
	if exists(select *From tempdb.dbo.sysobjects where name='##YDStory') 
	begin
	  drop table ##YDStory
	end

	 set @sql='  
	 select d.WareId,sum(isnull(d.Qty,0)) as qty ,      m.IsChk into  ##YDStory from '+@YDdbName+'.dbo.'+'ph_arrive m inner join '+@YDdbName+'.dbo.'+'ph_arrivedl d on m.Code=d.ArriveId  where d.WareId in (select Id from #wr) group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(-d.Qty,0)),       m.IsChk from '+@YDdbName+'.dbo.'+'ph_return m inner join '+@YDdbName+'.dbo.'+'ph_returndl d on m.Code=d.ReturnId  where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(-d.Qty+d.RmnQty,0)),m.IsChk from '+@YDdbName+'.dbo.'+'sl_invoice m inner join '+@YDdbName+'.dbo.'+'sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(d.Qty,0))       ,m.IsChk from '+@YDdbName+'.dbo.'+'sl_return m inner join '+@YDdbName+'.dbo.'+'sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(-d.Qty,0))      ,m.IsChk from '+@YDdbName+'.dbo.'+'sl_retail m inner join '+@YDdbName+'.dbo.'+'sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(d.Qty,0))      ,m.IsChk from '+@YDdbName+'.dbo.'+'wh_move m inner join '+@YDdbName+'.dbo.'+'wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(-d.Qty,0))      ,m.IsChk from '+@YDdbName+'.dbo.'+'wh_move m inner join '+@YDdbName+'.dbo.'+'wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(d.Qty,0))      ,m.IsChk from '+@YDdbName+'.dbo.'+'wh_in m inner join '+@YDdbName+'.dbo.'+'wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from '+@YDdbName+'.dbo.'
	          +'wh_inout where sys=0) and d.WareId in (select Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select d.WareId,sum(isnull(-d.Qty,0))      ,m.IsChk from '+@YDdbName+'.dbo.'+'wh_out m inner join '+@YDdbName+'.dbo.'+'wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from '+@YDdbName+'.dbo.'+'wh_inout where sys=0) and d.WareId in (select 
	Id from #wr)      group by d.WareId,m.IsChk  
	 union all        
	 select   WareId,sum(isnull(Qty,0))          ,1     from '+@YDdbName+'.dbo.'+'wh_regulate where WareId in (select Id from #wr)group by WareId'  
	   
	 --print @sql  
	 exec(@sql)  
  
 
  
 select *  ,  
           isnull( (select sum(isnull(qty,0)) From  ##YDStory where WareId=LL.Id             ) ,0)as YDRealQty,    
           isnull( (select sum(isnull(qty,0)) From  ##YDStory where WareId=LL.Id and ischk=1 ) ,0)as YDSysQty     
 into #TmpCompare  
 From #NoCompare LL  
          
 alter table #TmpCompare add PhQty int   
  
 select *from #TmpCompare  where MinPos>RealQty   
  
 drop table  ##YDStory  
 drop table #TmpCompare  
end  

  
drop table #wr  
drop table #tmp  
drop table #NoCompare  
  
  
