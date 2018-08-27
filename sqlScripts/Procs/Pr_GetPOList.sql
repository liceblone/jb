alter proc Pr_GetPOList
 @Code  varchar(20)    
,@WhId  varchar(20)      
,@ClientID  varchar(20)      
,@BeginDate  varchar(20)      
,@endDate  varchar(20)      
,@PartNo  varchar(20)      
,@Model  varchar(20)      
,@Brand  varchar(20)      
,@Pack  varchar(20)      
,@Origin varchar(20)      
    
as    
    
    
select      
  m.Code, m.ClientId, m.ArriveDate, m.HandManId, m.BillManId, m.BillTime, m.ChkManId, m.ChkTime, m.Note    
, m.WhId, m.WareFund, m.OtherFund, m.GetFund, m.PayFund, m.PayeeId, m.BankId, m.WhInCode, m.ClientName    
, m.TaxRate, case when m.islock=1 then '¡Ì' else '' end as islock , m.SaleManID    
, case when m.IsChk=1 then '¡Ì' else '' end as IsChk 
, case when m.FQtyChk=1 then '¡Ì' else '' end as FQtyChk 
, dl.WareId, dl.PartNo, dl.Brand, dl.Pack, dl.Qty, dl.Price, dl.dlNote, dl.Origin    
    
from ph_arrive m     
join ph_arrivedl DL ON M.Code=DL.ArriveId    
where m.ClientId like @ClientID+'%'    
and m.WhId like @WhId+'%'    
and m.Code  like '%'+@Code +'%'    
and m.ArriveDate between @BeginDate and @endDate    
and isnull( dl.PartNo ,'') like '%'+ @PartNo +'%'    
and isnull( dl.Brand  ,'') like '%'+ @Brand +'%'    
and isnull( dl.Pack   ,'') like '%'+ @Pack +'%'    
and isnull( dl.Origin ,'') like '%'+ @Origin +'%'    
order by m.ArriveDate desc
