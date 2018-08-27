 


alter  VIEW dbo.V502    
   
AS    
SELECT c.F07 & c.F08 AS F07, c.F06 AS colreadonly, c.F02, c.F03, c.F04, c.F05, c.F09,     
      c.F10, c.F11, c.F12, c.F13, c.F14, c.F15, c.F16, c.F17, c.F18, c.F19, c.F20, c.F21, c.F22,     
      c.F23,c.f27, f.F02 AS fldname  ,f.f07 as displayValues  
FROM dbo.T505 c LEFT OUTER JOIN    
      dbo.T102 f ON f.F01 = c.F03    


alter table T505 add F27 varchar(20)



 
 