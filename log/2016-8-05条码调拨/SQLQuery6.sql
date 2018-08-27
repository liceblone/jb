delete TBarcodeStorage
delete TBarcodeIO

select * from TBarcodeStorage  
--and	  whid='01'
							    

select len(fbilldlF_ID),* from TBarcodeIO	 

select * from wh_movedl where MoveId='wm00083163'
							   
 select   InWhid,   OutWhId from wh_move where code='wm00083163' 
 
 if exists( select * 
             from   TBarcodeStorage st 
             join TBarcodeIO i  on  st.fpackageBarCode   =i.fpackageBarCode
             join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
             join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
             where	 sldl.invoiceid= 'si00178187'
											  )
											  
											   update TBarcodeStorage set Fstatus ='OUT'
       from   TBarcodeStorage st 
       join TBarcodeIO i  on  st.fpackageBarCode   =i.fpackageBarCode
       join wh_movedl  mvdl on   i.FBillDLF_ID = mvdl.MoveF_ID
       join sl_invoicedl sldl on sldl.F_ID =  mvdl.invoicedlF_ID
       where	 sldl.invoiceid= 'si00178187'
       
             select * from wh_movedl 
				  select *	from 	sl_invoicedl							  
	  from   TBarcodeIO bio													    
	  join   wh_movedl		dl on  dl.moveF_ID = bio.FBillDLF_Id  and dl.MoveId='WM00083151' 
	  
 select   InWhid,   OutWhId from wh_move where code='WM00083144'        
	 select  * from wh_movedl where moveid='WM00083144'        

sp_help TBarcodeIO


   update TBarcodeIO   set Fstatus =case when FIOType ='G' then 'IN' else 'movingout'  
    from   TBarcodeIO bio   
   join	wh_move mv on bio.FbillCode =   mv.code
   where	mv.code='WM00083144'

        
 UPDATE TBarcodeStorage  SET  whid= mv.outwhid	   --select				 BAR.whid,	mv.outwhid 
 FROM	TBarcodeStorage  BAR  
 join	wh_move mv on bar.FbillCode =   mv.code
 where	mv.code='WM00083144'
 
 
  
delete from TBarcodeStorage where fpackagebarcode='2116080736605501'  
			delete from TBarcodeIO	where fpackagebarcode='2116080736605501'
