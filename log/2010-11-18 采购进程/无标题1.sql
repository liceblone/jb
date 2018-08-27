select * From TcustomsArrivalDL 

sp_help TcustomsArrivalM


sp_helptext sl_invoice_vld




sp_help TcustomsArrivalDL


sp_helptext CustomsArrival_Open


 CREATE proc pr_customsArrival_Lock
@BillCode varchar(20)   
as        
begin    
update TcustomsArrivalM  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode      
     
end    


go


select * from ph_orderDL 

alter table ph_orderDL  add ArrivedQty int 

select top 10 * from ph_order 


select top 0  *From wr_ware
select top 0  model,partNo,brand,pack,origin From wr_ware

alter proc Pr_CusPurchaseOrderRemainQty
@partNo varchar(30),
@Model  varchar(30),
@WhId   varchar(30),
@ClientID varchar(30)
as

select M.SendDate,M.BillTime,DL.OrderID,DL.WareID,DL.PartNo,DL.Brand,DL.Qty,DL.Price,DL.Origin,DL.DLNote ,DL.ArrivedQty ,DL.Qty-isnull(DL.ArrivedQty,0) as UnArrivedQty -- ,RsTp.wareid
from ph_order M
join ph_orderDL DL on M.Code=DL.OrderID
join wr_ware    wr on wr.id=dl.wareid
left join      TWareRenesasType RsTp on DL.wareid=RsTp.wareid 

where M.ischk=1 and isnull( M.isClose,0)=0   and isnull(dl.ArrivedQty,0) <DL.Qty  and RsTp.wareid is not null 
and M.ClientID  = @ClientID
and isnull(DL.PartNo,'')  like @partNo  
and wr.model like @Model   


go


sp_helptext CustomsArrival_chk1


alter PROCEDURE [dbo].[CustomsArrival_chk1]         
                 @CustArriveid varchar(20),        
                 @ChkManId varchar(20)        
  
as  
declare @errorcnt int 
set @errorcnt =0

 select * from TcustomsArrivalM where Code=@CustArriveid and IsChk=0        
 if @@rowcount<>1        
   Raiserror('系统找不到该海关装箱单,单据可能已被其它操作员删除或未审核,请[-刷新-]验证!',16,1)        
 else   
 begin  
   begin tran
        update TcustomsArrivalM set  ChkManId=@ChkManId ,Chktime =getdate(), IsChk =1 where Code=@CustArriveid  
        set @errorcnt =@errorcnt +@@error 

	update A set ArrivedQty=isnull( B.Qty,0)
	from  ph_orderDL A
	join ( select OrderID ,wareid ,sum(qty) qty  from TcustomsArrivalDL where custArriveid=@CustArriveid group by OrderID ,wareid ) 
        as B on B.OrderID=A.OrderID and B.wareid=A.wareid

        set @errorcnt =@errorcnt +@@error 

        if @errorcnt<>0
        begin
           raiserror('审核失败',0,16)
        end

        commit

   return 1  
 end  
  


go

  


create proc Pr_PurchaseOrderExeProgressDL
@ClientID varchar(20),
@BeginDate smalldatetime,
@endDate   smalldatetime,
@PartNo    varchar(30),
@Model     varchar(30),
@Brand    varchar(30),
@Pack    varchar(30),
@Origin  varchar(30)


as


select 
M.Code,M.ClientId,M.BillTo,M.ToFax,M.Address,M.Zip,M.LinkManId,M.LinkTel,M.LinkFax,M.SendDate,M.BillTime,M.ChkTime,
M.Note as FMNote,M.WareFund,M.ClientName,M.IsChk,M.RmbAmt,

DL.WareId,DL.PartNo,DL.Brand, DL.Qty ,DL.Price,DL.dlNote,DL.Origin,DL.RmbPrice,DL.RmbAmt,DL.ArrivedQty , DL.Qty- isnull( DL.ArrivedQty,0) as UnArrivedQty

 from 
ph_order M
join ph_orderDL DL on M.Code=DL.OrderID
join wr_ware wr    on wr.id=dl.wareid
where M.ClientID like @ClientID
and   M.SendDate >=@BeginDate
and   M.SendDate <=@endDate
and   isnull(DL.partNo ,'')  like isnull( @PartNo ,'')
and   isnull(wr.Model,'')    like isnull( @Model ,'')
and   isnull(DL.Brand    ,'')   like isnull(  @Brand     ,'') 
and   isnull(DL.Origin   ,'') like  isnull(  @Origin  ,'')  


go

create proc Pr_PurchaseOrderExeProgressM

@ClientID varchar(20),
@BeginDate smalldatetime,
@endDate   smalldatetime,
@PartNo    varchar(30),
@Model     varchar(30),
@Brand    varchar(30),
@Pack    varchar(30),
@Origin  varchar(30)


as


select 
M.Code,M.ClientId,M.BillTo,M.ToFax,M.Address,M.Zip,M.LinkManId,M.LinkTel,M.LinkFax,M.SendDate,M.BillTime,M.ChkTime,
M.Note as FMNote,M.WareFund,M.ClientName,M.IsChk,M.RmbAmt,

DL.WareId,DL.PartNo,DL.Brand, DL.Qty ,DL.Price,DL.dlNote,DL.Origin,DL.RmbPrice,DL.RmbAmt,DL.ArrivedQty , DL.Qty- isnull( DL.ArrivedQty,0) as UnArrivedQty

into #tmp
 from 
ph_order M
join ph_orderDL DL on M.Code=DL.OrderID
join wr_ware wr    on wr.id=dl.wareid
where M.ClientID like @ClientID
and   M.SendDate >=@BeginDate
and   M.SendDate <=@endDate
and   isnull(DL.partNo ,'')  like isnull( @PartNo ,'')
and   isnull(wr.Model,'')    like isnull( @Model ,'')
and   isnull(DL.Brand    ,'')   like isnull(  @Brand     ,'') 
and   isnull(DL.Origin   ,'') like  isnull(  @Origin  ,'')  



select sum(DL.Qty ) as Qty  , sum(DL.Qty * DL.Price) as FAmt,    sum( DL.RmbAmt)as RmbAmt , sum( DL.ArrivedQty ) as ArrivedQty

,sum(  DL.Qty- isnull( DL.ArrivedQty,0) ) as UnArrivedQty  ,B.FRenesasTypeName
from #tmp A
left join   (select wrRsTp.wareid ,RsTp.FRenesasTypeName from    TWareRenesasType wrRsTp join TRenesasType  RsTp on RsTp.FRenesasTypeCode=wrRsTp.FRenesasTypeCode ) as B  on B.wareid=A.wareid 

group by A.wareid ,B.FRenesasTypeName


drop table #tmp



select * From TWareRenesasType 
select FRenesasTypeName , * From TRenesasType  