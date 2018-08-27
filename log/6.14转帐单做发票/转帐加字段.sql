alter table fn_clntransfer add PFpID varchar(30)

alter table fn_clntransfer add NFpID varchar(30)
alter table fn_clntransfer add NInvQty  decimal(19,5)


alter table fn_clntransfer drop column NFpID



NFpID


alter table fn_clntransfer add InvQty  decimal(19,5)

alter table fn_clntransfer add IsTax bit