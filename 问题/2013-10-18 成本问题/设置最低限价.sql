     	        
     	        select * from TPriceChangeInfo	 where note is not null;
     	        
     	        
     	        
     	        delete TPriceChangeInfo	   where note is  null;
     	       
     	       select * from wh_inout where inout=1 and Sys=0 
     	       go 
     	     
     	     -- drop table #price	  drop table #pitem
     	        
          select ( dl.Price/(1+m.TaxRate)) price	,dl.wareid ,m.billtime	into #pitem
          from ph_arrivedl  dl join wr_ware wr on dl.wareid=wr.id  join ph_arrive M on M.code =dl.Arriveid
          where arrivedate>'2010-1-1'  
    
		   
		    
		 select p.*  into #price from    #pitem p 
		 join (select wareid ,max(billtime) as billtime from #pitem group by wareid) M	on p.wareid = m.wareid and p.billtime=m.billtime
		 
		    
		   
		   insert into	TPriceChangeInfo
		   (WareID,model,partno,Brand,Origin,pack,MinPrice)
		   
		   select   wr.id,wr.model,wr.partno,wr.Brand,wr.Origin,wr.pack,p.price 
		    from #price P join wr_ware wr on p.wareid=wr.id 
		    where p.wareid not in (select wareid from   TPriceChangeInfo)
		    
		    