/*
drop table	  result

drop table	  TBarcodeScanData
create table TBarcodeScanData
(
FSectionName varchar(20),
FFileName varchar(200),
FBarCode  varchar(200)  ,
FRawSerialNo varchar(200)  ,
FRawPesistorPartNo varchar(200) ,
FSerialNo varchar(200)  ,
FPesistorPartNo varchar(200),
FcreateTime smalldatetime default getdate()
)

select * from	TBarcodeScanData	order by FcreateTime


alter function Fn_RemoveCR(@str varchar(200))returns varchar(200)
as
begin
	set @str=  REPLACE(REPLACE(@str,'1'+char(10),''),'1'+char(13),'')  
	set @str=   REPLACE(REPLACE(@str, char(10),''), char(13),'')  
	set @str=    REPLACE(@str, '1 ','') 
	set @str=    REPLACE(@str, '2 ','') 
	return @str
end

*/
declare @str   varchar(8000)   
declare @FsectionName varchar(200),@FFileName varchar(200), @FPesistorPartNo  varchar(200),@FBarCode varchar(200)
declare @i int

set @i=0
set @FsectionName='' 

declare cursor1 cursor for         
select    "column 0" from result		  where rtrim("column 0" )<>''			 
open cursor1                       

fetch next from cursor1 into @str
while @@fetch_status=0           
begin
      -- insert into TBarcodeScanData	
     -- if @i=19  
       
           set @FsectionName='Section'+convert(varchar(20),@i)   
			select dbo.Fn_RemoveCR(f1) as f1		 into #tmp	    from dbo.Fn_SplitStrBySeprator(@str ,',')	 where len(f1)>5 order by f1
			
			select @FFileName = f1	  from #tmp    where f1 like '%.eml'
			select @FPesistorPartNo = f1  from #tmp    where f1 like '%F%'
			select @FBarCode =  f1 	from #tmp	  where f1 like '%-%'  --	and len( rtrim(ltrim(f1))) =13
			and isnumeric(substring(f1,1,8))=1   and isnumeric(substring(f1,1,12))=0   	and isnumeric(substring(f1,10,3))=1	   	and isnumeric(substring(f1,13,0))=0
			--60602111-006B
			  
			  print @i
			print	@FPesistorPartNo
			print @FBarCode					  -- select * from TBarcodeScanData
			
			  insert into TBarcodeScanData (FsectionName ,  FFileName, Fbarcode, FRawserialNo, FRawpesistorPartno)
			   select 	@FsectionName	,@FFileName, @Fbarcode ,f1 , 	@FpesistorPartno from #tmp 
			   where f1 <>@FFileName and (  ( f1 <>@FPesistorPartNo and  f1 <>@FBarCode and @Fbarcode is not null)																				  
					  or( f1 <>@FPesistorPartNo   and @Fbarcode is   null)		
					  )
			  drop table #tmp
	 select @i= @i+1	 
	 
fetch next from cursor1 into @str
end

close cursor1                    
deallocate cursor1