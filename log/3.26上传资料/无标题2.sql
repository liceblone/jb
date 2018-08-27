if not  exists(      
select * from master.dbo.sysservers where srvname='[202.75.217.59,1433]' 

)      
      select * from master.dbo.sysservers where srvname='[202.75.217.59,1433]' 


     select * from  master.dbo.sysservers


exec sp_addlinkedserver '[202.75.217.59,1433]'      
   


 
EXEC sp_addlinkedsrvlogin  '[202.75.217.59,1433]', 'false', NULL, 'jingbei' , 'jingbeicom'  

 
    create view V1
as

select * From [202.75.217.59].jbic.dbo.wr_class  



    select *   from master.dbo.sysservers where srvname='202.75.217.59,1433'   
select * From #tmp

    
   
EXEC    sp_addlinkedserver    @server='202.75.217.59,1433', @srvproduct='',
                                @provider='SQLOLEDB', @datasrc='202.75.217.59,1433'


 

EXEC sp_addlinkedsrvlogin  '202.75.217.59,1433', 'false', NULL, 'jingbei' , 'jingbeicom'  


select top 1 * From [125.122.25.169,7706].jbhzuserdata.dbo.wr_class  
      
 select top 1 * From [202.75.217.59,1433].jbic.dbo.sysobjects
select top 1 * From [202.75.217.59,1433].jbic.dbo.wr_class
 

4	1184	[125.122.25.169,7706]		SQLOLEDB		NULL	NULL	2009-03-26 22:30:32.420	NULL	NULL	NULL	NULL	0	0	NULL	1	0	0	0	0	0	0	1	0	0	1	0	NULL
4	225	[125.122.25.169,7706]	SQL Server	SQLOLEDB	[125.122.25.169,7706]	NULL	NULL	2009-03-26 22:31:03.140	NULL	NULL	NULL	NULL	0	0	[125.122.25.169,7706]         	1	1	0	0	0	0	1	1	0	0	0	0	NULL
