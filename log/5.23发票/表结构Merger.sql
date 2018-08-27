create proc Pr_mergerTableFlds
@MainTable varchar(20),
@SubTable varchar(20)
as
/*	declare @MainTable varchar(20)
	declare @SubTable varchar(20)
	set @MainTable='sl_retailDisCard'
	set @SubTable='sl_retail'
*/

declare @sql       varchar(1000)

declare @i int
set @i=0
while (@i<30)
begin
        set @sql=''
	select  @sql=
	'alter table  '+@MainTable+'  add      '+ A.Name +' '+B.Name   +case when B.Name ='varchar' then '('+convert(varchar(20), A.length) +')' else '' end 
	
	-- , A.Name ,B.Name as type , A.length   
        From syscolumns A
	join systypes B on A.xtype=B.xtype
	 where id=object_id(@SubTable   ) 
	and A.Name not in (select  Name   From syscolumns  where id=object_id( @MainTable ) )  
	order by colid
        print @sql
        if @sql<>''
          exec(@sql)
        set @i=@i+1
end


select *from sl_retailDisCard
select *from sl_retail
--alter table sl_retailDisCard      add islock bit
--alter table sl_retailDisCard      drop column      islock  
alter table sl_retailDisCard      drop  column      islock  
alter table sl_retailDisCard      drop column tt 

exec Pr_mergerTableFlds   'sl_retailDisCard','sl_retail'

alter table sl_retail      add tt varchar(30) 



Code	varchar	no	20	     	     	no	no	no	Chinese_PRC_CI_AS
RetailDate	datetime	no	8	     	     	yes	(n/a)	(n/a)	NULL
WhId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
SaleManId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
WareFund	money	no	8	19   	4    	yes	(n/a)	(n/a)	NULL
GetFund	money	no	8	19   	4    	yes	(n/a)	(n/a)	NULL
PayeeId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
BillManId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
BillTime	datetime	no	8	     	     	yes	(n/a)	(n/a)	NULL
ChkManId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
ChkTime	datetime	no	8	     	     	yes	(n/a)	(n/a)	NULL
Note	varchar	no	200	     	     	yes	no	no	Chinese_PRC_CI_AS
WhOutCode	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
IsChk	bit	no	1	     	     	no	(n/a)	(n/a)	NULL
IsClose	bit	no	1	     	     	no	(n/a)	(n/a)	NULL
IsDepose	bit	no	1	     	     	no	(n/a)	(n/a)	NULL
BankId	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
FnIsChk	bit	no	1	     	     	yes	(n/a)	(n/a)	NULL
FnChkManId	varchar	no	50	     	     	yes	no	no	Chinese_PRC_CI_AS
FnChkTime	datetime	no	8	     	     	yes	(n/a)	(n/a)	NULL
IsTax	bit	no	1	     	     	yes	(n/a)	(n/a)	NULL
TaxRate	money	no	8	19   	4    	yes	(n/a)	(n/a)	NULL
Profit	money	no	8	19   	4    	yes	(n/a)	(n/a)	NULL
InvCode	varchar	no	20	     	     	yes	no	no	Chinese_PRC_CI_AS
InvDate	datetime	no	8	     	     	yes	(n/a)	(n/a)	NULL
InvFund	money	no	8	19   	4    	yes	(n/a)	(n/a)	NULL
InvName	varchar	no	30	     	     	yes	no	no	Chinese_PRC_CI_AS
IsInvoice	bit	no	1	     	     	yes	(n/a)	(n/a)	NULL
discardTime	smalldatetime	no	4	     	     	yes	(n/a)	(n/a)	NULL
discardManID	varchar	no	50	     	     	yes	no	no	Chinese_PRC_CI_AS
