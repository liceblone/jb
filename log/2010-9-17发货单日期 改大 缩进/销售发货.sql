alter PROCEDURE [dbo].[sl_invoice_vw]   
                       @YdId int,  
                       @PartNo varchar(100),  
                       @Brand varchar(50)  
AS  
declare @db varchar(50),@sql nvarchar(1000)  
select @db=(select db from jingbeisysPub.dbo.sys_tab where code=(select tabid from jingbeisysPub.dbo.sys_filiale where code=@YdId))  
set @db=@db+'.dbo.'  
set @sql=N'select m.*,d.* from '+@db+'sl_invoice m inner join '+@db+'sl_invoicedl d on m.Code=d.InvoiceId where m.IsChk=1 and d.PartNo like ''%'+@PartNo+'%'' and d.Brand like ''%'+@Brand+'%'''  
exec sp_executesql @sql
