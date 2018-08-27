 

create    proc sp_StorageFinFOutSum                 
(                                            
                     @Model varchar(50),                    
                 @PartNo varchar(100),               
                 @WhId varchar(20),                 
                 @ClassId varchar(100)    ,                
                 @StayDayCnt  int   , --滞留仓库的天数    ,  
                 @OldDbName varchar(30 )   ,             
                 @CurDBName varchar(30 )   ,
                 @brand     varchar(30 )  , 
                 @pack      varchar(30 )            
)            
as             
   /*
 declare @WhId char(10)                
 declare @Model varchar(50)                    
 declare @PartNo varchar(100)                    
 declare @ClassId varchar(100)                    
 declare @StayDayCnt  int    --滞留仓库的天数                
 declare @OldDbName varchar(30 )               
 declare  @CurDBName varchar(30 )    
               
 set @WhId='01'                 
 SET @Model=''                
 SET @PartNo='2n3904'                
 SET @ClassId=''                
 SET @StayDayCnt=1       
 SET @OldDbName ='HZJB03A'  
 set @CurDBName='jbhzuserdata'          
         */    

   
create table #tmpb  
(  
billcode varchar(50),  
billid   int,  
whid varchar(50),  
wareid varchar(50),  
qty    int ,   
Billtime datetime,  
ChkTime  datetime,  
diffcnt  int,  
Billtype  varchar(23),  
strCnt int,  
RemainCnt int,  
FromBillTime varchar(23),  
FromChkTime varchar(23),   
  
Model varchar (50),  
PartNo varchar (200),  
Brand varchar (50),  
Pack varchar (50),  
Origin varchar (50),  
Unit varchar (20),  
SafePos decimal (19,3),  
MaxPos decimal (19,3),  
Note varchar (200),  
Stock decimal (9),  
IsUse bit ,  
 MinPos decimal (19,3),  
Cost decimal (19,3),  
Price decimal (19,3),  
PriceRate decimal (19,3),  
SalePrice decimal (19,3),  
 )             
 -- c.Model,c.PartNo,c.Brand,c.Pack,c.Origin,c.Unit,c.SafePos,c.MaxPos,c.Note,c.Stock,c.IsUse,  c.MinPos,c.Cost,c.Price,c.PriceRate,c.SalePrice 

  
 insert into #tmpb  
exec                  sp_StorageFinFOut @Model ,@PartNo ,@WhId,@ClassId , @StayDayCnt,@OldDbName,@CurDBName ,@brand  ,@pack
    
--select *From wr_class
-- exec jbhzuserdata.dbo.sp_StorageFinFOut '',        '2n3904','01'    ,'',1,'hzjb03a','jbhzuserdata'  

 select wareid ,sum(qty )as qty,sum(RemainCnt) as RemainCnt 
,  min(datediff(day, billtime,getdate())) FromBillTime               
,  min(datediff(day, Chktime,getdate()) ) FromChkTime    into #TmpDis  From #tmpb  group by wareid


select *,(qty * price )as amt from #TmpDis A join wr_ware B on a.wareid=b.id
  
drop table #TmpDis
drop table #tmpb  
  
