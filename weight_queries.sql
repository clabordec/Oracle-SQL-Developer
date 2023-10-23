alter session set current_schema = dm;

select * from cl_message;
select * from twcc_mhe_message;
select * from lpn;
select * from orders;


-- Check how many cases have diverted with no weight
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
where tmm.divert = 'SCNSHIP' 
-- and tmm.weight = '******' 
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.create_date_time desc;

-- Kohls
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391415777','00000197180391236358','00000197180391236594')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392029317','00000197180392029249','00000197180391747007','00000197180391747007','00000197180391746123','00000197180391746994','00000197180392031006','00000197180392029348','00000197180391742668','00000197180392036339','00000197180391744419','00000197180391744488','00000197180391747304','00000197180392036322','00000197180392028952','00000197180391744747','00000197180391744563','00000197180391744747','00000197180391744501','00000197180392029171','00000197180392028785','00000197180392036353','00000197180391744501','00000197180391744921','00000197180391745409','00000197180391744662','00000197180391744938','00000197180391745584','00000197180391745584','00000197180391745164','00000197180391742453','00000197180392036230','00000197180392036292','00000197180392036254','00000197180392036223','00000197180391746765','00000197180392036155','00000197180392036308','00000197180392028815','00000197180391745843','00000197180391742569','00000197180391742545','00000197180391747335','00000197180391744518','00000197180391744990','00000197180391747410','00000197180391747779','00000197180391745195','00000197180391747335')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Lindsey
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392029454','00000197180392029485','00000197180392036261','00000197180392029485','00000197180392028808','00000197180392036384')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Simpson
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391746826','00000197180391745331','00000197180391745331')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Rhodes
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392030993')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Tyler
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392028792', '00000197180391747601')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Gallant
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391747106')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;

-- Belk Hudson
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391747045')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Hensdale
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392028846')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Matthews
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391747281')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Belk Parks
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180391747403')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Macys
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392376954')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- Carters Store 821
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197181300242934','00000197181300379852','00000197181300299570')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- USPSGT1
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392724601')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;


-- USPSGT1
select distinct tmm.carton_nbr,
       tmm.msg_type,
       tmm.action,
       tmm.divert,
       tmm.weight,
       tmm.msg_id,
       tmm.source_id,
       cle.status,
       o.order_type,
       l.container_size,
       l.lpn_facility_status,
       tmm.create_date_time
from twcc_mhe_message tmm
join cl_endpoint_queue cle
on tmm.msg_id = cle.msg_id
join cl_message clm
on cle.msg_id = clm.msg_id
join lpn l
on tmm.carton_nbr = l.tc_lpn_id
join orders o
on l.order_id = o.order_id
where tmm.divert = 'SCNSHIP' 
and tmm.carton_nbr in ('00000197180392725431','00000197180392725448')
and mod_date_time between '21-OCT-23 08.00.00.000000000 PM' and '22-OCT-23 04.30.00.000000000 AM'
order by tmm.carton_nbr asc;

