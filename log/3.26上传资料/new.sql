alter proc Pr_UpdateInventory        
        
as        
        
declare @ip   varchar(40)    
declare @port varchar(40)    
declare @username varchar(40)    
declare @password varchar(40)    
  
  
  
declare @address varchar(40) declare @addressEX varchar(40)    
    
select     @ip= ip from jingbeisyspub.dbo.Tparameters where f_id=1000    
select  @port= port from jingbeisyspub.dbo.Tparameters where f_id=1000    
select  @username= fusername from jingbeisyspub.dbo.Tparameters where f_id=1000    
select  @password= fpassword from jingbeisyspub.dbo.Tparameters where f_id=1000    
  
  
--alter table Tparameters add fUserName varchar(50)  
--alter table Tparameters add fPassword varchar(50)  
  
set @address=@ip+','+@port    
set @addressEX='['+@address+']'    
     
    
if not  exists(        
select * from master.dbo.sysservers where srvname=@address)        
begin        
         
  
EXEC    sp_addlinkedserver    @server=@address, @srvproduct='',  
                                @provider='SQLOLEDB', @datasrc=@address   
end        
         
        
        
EXEC sp_addlinkedsrvlogin  @address, 'false', NULL, @username , @password     
        
       -- select      ip from jingbeisyspub.dbo.Tparameters where f_id=1000    
--  select   * from [202.75.217.59,1433].jbic.dbo.wr_class  order by code      
--select  top 1 * from  wr_class        
    
--select   * from  @address.jbic.dbo.wr_class  order by code      
    
declare @sql  varchar(8000)    
    
set @sql='    
        
if ( select count (*) from   '+@addressEX+'.jbic.'+@username+'.wr_class )<> ( select count (*) from  wr_class )      
begin      
      
     delete '+@addressEX+'.jbic.'+@username+'.wr_class        
        
     insert into '+@addressEX+'.jbic.'+@username+'.wr_class (code ,name ,parentcode )           
  select  code ,name   , left(code,len(code)-1) as parentcode from wr_class w      
 where code not in (select code from '+@addressEX+'.jbic.'+@username+'.wr_class)        
end      
        
        
delete '+@addressEX+'.jbic.'+@username+'.wr_ware        
        
insert into '+@addressEX+'.jbic.'+@username+'.wr_ware (wareid,classid,model,PartNo,Brand,pack,Origin,Unit,WareStat,Qty,price  ,updatetime)        
select  id,classid,model,PartNo,Brand,pack,Origin,Unit,case when isnull(stock,0)<=0 then '+''''+'¶©»õ'+''''+' else '+''''+'ÏÖ»õ'+''''+' end ,stock,price ,getdate() from wr_ware where ispub=1 and isupload=1       
     '    
         
print @sql    
    
    
   exec(@sql)    
         
    
return 1        
        
        
       
    
  
