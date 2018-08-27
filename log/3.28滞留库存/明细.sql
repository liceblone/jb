 alter     proc sp_StorageFinFOut           --明细       
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
begin                
               
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
             
      
 select    IsNull(w.PriceRate,c.PriceRate) as myRate,w.*                 
  into #wr                 
 from wr_ware w inner join wr_class c on w.ClassId=c.Code                 
 where w.Model like  IsNull(@Model,'')+'%' and w.PartNo like  IsNull(@PartNo,'')+'%'  and  isnull(w.brand ,'')like isnull(@brand,'')+'%'  and  isnull(w.pack ,'')like isnull(@pack,'') +'%'             
 and w.ClassId like IsNull(@ClassId,'')+'%' order by w.PartNo,w.Brand,w.Pack                  
                   
 --采购到货入库                   
  select m.Code,9 as billid ,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'采购到货入库   ' as billtype              
  into #tmp                 
  from ph_arrive m inner join ph_arrivedl d on m.Code=d.ArriveId where d.WareId in (select Id from #wr)  and m.WhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 union all                
 --采购退货出库                  
  select m.Code,13 ,m.WhId,d.WareId,-d.Qty ,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt, '采购退货出库 ' as billtype      
   from ph_return m inner join ph_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)     and m.WhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 --销售发货未审              
 union all                    
  select m.Code,19,m.WhId,d.WareId,-d.Qty+IsNull(d.RmnQty,0),m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'销售发货 ' as billtype              
  from sl_invoice m inner join sl_invoicedl d on m.Code=d.InvoiceId where d.WareId in (select Id from #wr)    and m.WhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 union all                    
 --销售退货入库              
  select m.Code,20,m.WhId,d.WareId,d.Qty,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt ,'销售退货' as billtype               
   from sl_return m inner join sl_returndl d on m.Code=d.ReturnId where d.WareId in (select Id from #wr)    and m.WhId=@WhId   --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 union all                
 --零售出库                  
  select m.Code,3,m.WhId,d.WareId,-d.Qty,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt  ,'零售出库' as billtype              
   from sl_retail m inner join sl_retaildl d on m.Code=d.RetailId where d.WareId in (select Id from #wr)   and m.WhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 union all                 
 --调拨入库                 
 -- select m.Code,23,m.InWhId,d.WareId,d.Qty,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt  ,1 as billtype              
 --  from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)  and m.InWhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 --union all                
 --调拨出库                  
 -- select m.Code,23,m.OutWhId,d.WareId,-d.Qty,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt ,1 as billtype               
 --  from wh_move m inner join wh_movedl d on m.Code=d.MoveId where d.WareId in (select Id from #wr)  and m.OutWhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 select m.Code,23,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'调拨入库 ' as billtype              
       from wh_in m inner join wh_indl d on m.Code=d.InId     
       where m.InTypeId in (select Code from wh_inout where code='I02') and whid=@whid  and d.WareId in (select Id from #wr)                
     
 --select top 1 * From wh_out    
 union all                
 select m.Code,23,m.WhId,d.WareId,-d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'调拨出库' as billtype              
        from wh_out m inner join wh_outdl d on m.Code=d.OutId     
        where m.OutTypeId in (select Code from wh_inout where code='X02')and whid=@whid  and d.WareId in (select Id from #wr)                
           
 union all                    
  select m.Code,21,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'调拨入库 ' as billtype              
  from wh_in m inner join wh_indl d on m.Code=d.InId where m.InTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr)  and m.WhId=@WhId --AND datediff(day,M.billtime,getdate()) >=  @StayDayCnt                
 union all                    
             
 select m.Code,            
  case when m.LnkBlCd<>''and isfirst=0 then 19             
  when m.LnkBlCd<>''and isfirst=1 then 19  else 22 end as billid,            
  m.WhId,d.WareId,-d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt    ,'调拨出库' as billtype            
 from wh_out m inner join wh_outdl d on m.Code=d.OutId where m.OutTypeId in (select Code from wh_inout where sys=0) and d.WareId in (select Id from #wr) and m.WhId=@WhId   --AND datediff(day,M.billtime,getdate()) >= @StayDayCnt                
             
 /*               
 union all                 
 --销售发货出库                 
  select m.Code,19,m.WhId,d.WareId,-d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt                
 from wh_out m inner join wh_outdl d on m.Code=d.OutId where d.WareId in (select Id from #wr) and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=1                    
 --销售补货出库              
 union all                      
  select m.Code,19,m.WhId,d.WareId,-d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt                
 from wh_out m inner join wh_outdl d on m.Code=d.OutId where d.WareId in (select Id from #wr) and m.WhId=@WhId and m.LnkBlCd<>'' and IsFirst=0              
                 
 */              
 union all                    
  select 'regulate_'+convert(varchar(10),id),-1,WhId,WareId,Qty,1 , xDate,xDate,0 as diffcnt  ,'调整' as billtype               
  from wh_regulate where WareId in (select Id from #wr)  and WhId=@WhId -- AND datediff(day,xDate,getdate()) >=  @StayDayCnt                  
                     
                 
 select sum(qty)as qty,wareid into #temp2 from #tmp   group by wareid                 
 --select * from  #temp2             select * from  #tmp    
                 
                 
 declare @sql    varchar(8000)    
     
     
 /*    
 declare @WhId char(10)                
 declare @Model varchar(50)                    
 declare @PartNo varchar(100)                    
 declare @ClassId varchar(100)                    
 declare @StayDayCnt  int    --滞留仓库的天数                
 declare @CurDBName  varchar(100)                
 set @WhId='01'                 
 SET @Model=''                
 SET @PartNo=''                
 SET @ClassId=''                
 SET @StayDayCnt=5        
 set @CurDBName='jbhzuserdata'       
 */    
   if isnull(@OldDbName,'')<>''  
	begin
	 Set @sql='    
	    insert into #tmp    
	    select m.Code,9 as billid ,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'''+ '历史入库' +''' as billtype                        
	    from  '+@OldDbName+'.dbo.ph_arrive m inner join '+@OldDbName+'.dbo.ph_arrivedl d on m.Code=d.ArriveId     
	    where d.WareId in (select Id from #wr)  and m.WhId='''+@WhId+'''    
	 union all                
	    select m.Code,20,m.WhId,d.WareId,d.Qty,m.IsChk, M.BillTime,M.ChkTime,0 as diffcnt ,'''+ '历史出库' +''' as billtype               
	    from '+@OldDbName+'.dbo.sl_return m inner join '+@OldDbName+'.dbo.sl_returndl d on m.Code=d.ReturnId     
	    where d.WareId in (select Id from #wr)  and m.WhId='''+@WhId+'''    
	 union all                
	    select m.Code,23,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'''+ '历史调拨入库' +''' as billtype              
	    from '+@OldDbName+'.dbo.wh_in m inner join '+@OldDbName+'.dbo.wh_indl d on m.Code=d.InId     
	    where d.WareId in (select Id from #wr)  and m.InTypeId in (select Code from '+@OldDbName+'.dbo.wh_inout where code='+'''I02'''+') and whid='''+@WhId+'''            
	 union all                    
	    select m.Code,21,m.WhId,d.WareId,d.Qty,m.IsChk , M.BillTime,M.ChkTime,0 as diffcnt  ,'''+ '历史调拨出库' +''' as billtype              
	    from '+@OldDbName+'.dbo.wh_in m inner join '+@OldDbName+'.dbo.wh_indl d on m.Code=d.InId     
	    where m.InTypeId in (select Code from '+@OldDbName+'.dbo.wh_inout where sys=0)    
	    and d.WareId in (select Id from #wr)  and m.WhId='''+@WhId+''''    
	     
	 ----print @sql   4162    
	 exec( @sql)    
end     
 --select   code,qty,billtime from #tmp where qty>0 and left(code,8)<>'regulate'  order by billtime desc    
     
                 
 --SELECT * fROM  #wr    
   
 --  SELECT * fROM #temp2  
  -- SELECT  *  fROM #TMP  
   
   
 declare @sumqty  decimal(13,3)                
 declare @itemqty decimal(13,3)                
 declare @tmpqty decimal(13,3)                
 declare @str char(50)                
 declare @code char(50)                
 declare @i int                
 declare @wareID int                 
 set @i=0                
 set @str=''                
                 
 declare crSum cursor for                 
   select   * from  #temp2 where qty>0  --and wareid=35821                
 open crSum                
 while (1=1)                
 begin                 
  fetch next                
  from  crSum into @sumqty,@wareID                
  if @@fetch_status<>0 break                
  set @tmpqty=@sumqty                
                 
   declare crStkInItem cursor for                
    select   code,qty from #tmp where qty>0 and wareid=@wareID  and left(code,8)<>'regulate'   order by billtime desc --and datediff(day,billtime,getdate()) >=  @StayDayCnt                
   open crStkInItem                
                   
    while ( 1=1)                
    begin                
     fetch next                 
     from  crStkInItem into @code,@itemqty                 
     if @@fetch_status<>0 break                
     set @tmpqty=@tmpqty-@itemqty                
                  
     if @tmpqty<=0                   
     begin                  
      update  #tmp set diffcnt=@tmpqty where code=@code and wareid=@wareID                 
      break                   
     end                
     update  #tmp set diffcnt=@tmpqty where code=@code and wareid=@wareID                 
  /* --select @tmpqty*/                     
    end                
    close crStkInItem                
    deallocate crStkInItem                
 end                
 close crSum                
 deallocate crSum                
                 
                 
           
--select * From #tmp        
                 
                 
                 
 select A.Code as billcode ,A.billid,A.WhId,A.WareId,A.qty ,  A.BillTime,A.ChkTime,A.diffcnt,A.BillType  ,            
 b.qty as strcnt ,                
 case when diffcnt >0 then a.qty  when diffcnt<0 then A.qty+diffcnt end as remainCnt,                
 datediff(day,A.billtime,getdate()) FromBillTime,                
 datediff(day,A.Chktime,getdate()) FromChkTime,                
c.Model,c.PartNo,c.Brand,c.Pack,c.Origin,c.Unit,c.SafePos,c.MaxPos,c.Note,c.Stock,c.IsUse,  c.MinPos,c.Cost,c.Price,c.PriceRate,c.SalePrice  --       into T           
 from  #tmp  A                 
 join  #temp2  B on A.wareid=B.wareId                 
 join    #wr     C on C.id=A.wareid and c.id=b.wareid                
 where  A.qty >0 and B.qty>0  and diffcnt <>0                 
 and datediff(day,A.billtime,getdate()) >=  @StayDayCnt  -1              
 order by A.wareId , billtime desc                
                 
        

                 
 drop table #temp2                
 drop table #wr                    
 drop table #tmp                  
                 
end                
              
  
