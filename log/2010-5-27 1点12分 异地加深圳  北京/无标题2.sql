select sys_filiale.Name,sys_tab.db from sys_filiale inner join sys_tab on sys_filiale.tabid=sys_tab.Code order by sys_filiale.Code desc  

��ɽ

select tabid,*from sys_filiale where code=11

insert into sys_filiale(tabid,code,name )
values
('11','11','���ھ������ӿƼ����޹�˾')
insert into sys_filiale(tabid,code,name )
values
('12','12','�����������ӿƼ����޹�˾')

update sys_filiale set tabid=11 where code=11
select *from sys_tab


insert into sys_tab (code ,filialeid,name,db,isuse)
values
(11,11,'JbSzUserData','JbSzUserData',1)
insert into sys_tab (code ,filialeid,name,db,isuse)
values
(12,12,'jbbjuserdata','jbbjuserdata',1)


select tabid,*from jingbeisyspub.dbo.sys_filiale  
select *from jingbeisyspub.dbo.sys_tab
