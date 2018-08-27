alter table t602  add F36 varchar(20)  --lock procedure
alter table t602  alter column  F36 varchar(50)  --lock procedure


alter table t602  add F37 varchar(20)  --lock right
alter table t602  add F38 varchar(20)  --unlock right



select *from t602


sp_helptext pr_LockBill


drop proc pr_LockBill  
go

CREATE proc pr_SL_LockBill    
@BillCode varchar(20) 
as      
begin  
update sl_invoice  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
    
end  


go 

CREATE proc pr_Whout_LockBill    
@BillCode varchar(20) 
as      
begin  
update wh_out  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  


go





--select *from sl_retail 

alter table sl_retail add islock bit

go
CREATE proc pr_retail_LockBill    
@BillCode varchar(20) 
as      
begin  
update sl_retail  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  
go
alter table sl_return add islock bit
 go

CREATE proc pr_slret_LockBill    
@BillCode varchar(20) 
as      
begin  
update sl_return  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  
go
alter table ph_arrive add islock bit
go

drop proc pr_ph_arrive_LockBill      
go

CREATE proc pr_phAriv_LockBill    
@BillCode varchar(20) 
as      
begin  
update ph_arrive  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  


go
alter table ph_return add islock bit
 go
drop proc pr_ph_return_LockBill    
go
CREATE proc pr_phrtn_LockBill     
@BillCode varchar(20) 
as      
begin  
update ph_return  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  
go

alter table wh_in add islock bit
 
 go
 CREATE proc pr_wh_in_LockBill    
@BillCode varchar(20) 
as      
begin  
update wh_in  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
   
end  



CREATE proc pr_LockBill    
@BillCode varchar(20),    
@Billtype  int    
as    
if @Billtype=0  
begin  
update sl_invoice  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
    
end  
  
    
if @Billtype=1  
begin  
update wh_out  set islock=case when isnull(islock,0)=0 then 1 else 0 end where code =@BillCode    
    
end  
     
     
    
    
  
