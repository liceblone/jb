alter  proc sp_BFP_PriceChange    
    
@AbortStr   varchar(50) output,    
@WarningStr varchar(50) output,    
@wareid int,    
@MinPrice money ,
@pk  int   
as    
begin    
set @AbortStr=''    
set @WarningStr=''    
    
    /*
if not exists(select 1 from wr_ware where id=@wareid and Cost<@MinPrice)    
begin    
 set @AbortStr='��ͼ۸���ڳɱ���'      
 return 0    
end   
*/ 

--select * from TPriceChangeInfo
    
if  exists(select 1 from TPriceChangeInfo where wareid=@wareid and  pk<>@pk)    
begin    
 set @AbortStr='���ֹ��ļ�¼�Ѿ�����!'      
 return 0    
end    
return 1    
end    
    
  