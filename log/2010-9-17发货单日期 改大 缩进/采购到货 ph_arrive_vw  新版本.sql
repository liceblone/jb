  
 alter PROCEDURE [dbo].[ph_arrive_vw]   
                       @YdId int,  
                       @PartNo varchar(100),  
                       @Brand varchar(50)  
AS  
declare @db varchar(50),@sql nvarchar(1000)  
select @db=(select db from jingbeiSysPub.dbo.sys_tab where code=(select tabid from jingbeiSysPub.dbo.sys_filiale where code=@YdId))  
set @db=@db+'.dbo.'  
set @sql=N'select m.*,d.* from '+@db+'ph_arrive m inner join '+@db+'ph_arrivedl d on m.Code=d.ArriveId where m.IsChk=1 and d.PartNo like ''%'+@PartNo+'%'' and d.Brand like ''%'+@Brand+'%'''  
exec sp_executesql @sql

 go




update jingbeiNewSys.dbo.sys_filiale  set name ='浙江晶贝电子科技有限公司登云路639号'   where code in (8 )
update jingbeiNewSys.dbo.sys_filiale  set name ='温州晶贝'   where code in ( 9 )
update jingbeiNewSys.dbo.sys_filiale  set name ='乐清晶贝'   where code in ( 10)
 

 
