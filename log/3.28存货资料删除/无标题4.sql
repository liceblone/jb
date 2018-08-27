alter     proc SP_WR_WareBFD            
@AbortStr varchar(250) output,                      
@empid varchar(30)  ,                  
@id varchar(30)          
          
as            
            
        
SET @AbortStr =''       

IF @id =''             
BEGIN            
 SET @abortstr ='货号为空 ,请刷新再试'            
 return 0             
END            
         
return 1

 
create table #TmpUsed          
(wareid int)          
--insert into #TmpUsed  exec jbhzuserdata.dbo.sp_ISwareused   @id        
--insert into #TmpUsed  exec jbwzuserdata.dbo.sp_ISwareused   @id        
--insert into #TmpUsed  exec jbyquserdata.dbo.sp_ISwareused   @id        
          
        
if exists(select *from #TmpUsed  )          
begin          
    drop table #TmpUsed          
    SET @abortstr ='该记录已经被使用'          
    return 0           
end          
          
drop table #TmpUsed          
            
declare @partno varchar(30)            
declare @brand  varchar(30)            
declare @Pack   varchar(30)            
declare @origin varchar(30)      
declare @place  varchar(30)      
             
select @Partno= isnull(Partno,'') ,@brand =isnull(brand,'') ,@Pack =isnull(Pack,''),@origin=isnull(origin,'') ,@place=isnull(place,'') from wr_ware where id=@id            
            
            
insert into TOperateLog              
(Optype  ,content   ,OpTable ,Opinterface ,OpEmp   ,OpTime  ,place )              
values              
('删除  ',@id +'  '+@Partno+'  '+@brand +'  '+@Pack +'  '+@origin,'Wr_ware','存货档案',@empid,getdate(),@place)              
            
return 1            
         
    
  
