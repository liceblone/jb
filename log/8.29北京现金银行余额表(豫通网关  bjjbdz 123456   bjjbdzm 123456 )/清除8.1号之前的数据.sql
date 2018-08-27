select * From   fn_receiver where billtime<'2008-8-1'
  select * From  fn_payment   where billtime<'2008-8-1'
  select * From  fn_bnktransfer   where billtime<'2008-8-1'
 select * From  sl_invoice      where billtime<'2008-8-1'
 select * From  sl_retail   where billtime<'2008-8-1'


delete   fn_bnktransfer   where billtime<'2008-8-1'