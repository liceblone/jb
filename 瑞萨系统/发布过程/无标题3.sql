--·¢²¼
--1.deattach database  
--2 attach database with filename adding version

--3.at client side attach database,   import base information

select *from apparelBaseinfo.dbo.sys_DataBase

select * From apparelBaseinfo.dbo.T800 where F05=0


EXEC sp_attach_db @dbname = N'pubs', 
   @filename1 = N'c:\Program Files\Microsoft SQL Server\MSSQL\Data\pubs.mdf', 
   @filename2 = N'c:\Program Files\Microsoft SQL Server\MSSQL\Data\pubs_log.ldf'




EXEC sp_detach_db 'pubs', 'true'



ApparelBaseInfo
ApparelSys
apparelUserData