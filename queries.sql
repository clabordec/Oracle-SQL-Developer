alter session set current_schema = DM;


-- Table names for tote numbers
SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME = 'CNTR_NBR' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%MSG_LOG%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'RES%' AND OWNER = 'DM';


-- Column names for LPNs
Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'LPN' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'ALLOC_INVN_DTL' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'ORDERS' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'PROD_TRKG_TRAN' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'TASK_DTL' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'TMP_TASK_CREATION_LM_TASK_DTLS' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'TMP_TASK_CREATION_SELECTED_AID' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'TWCC_TOTE_AUDIT' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'OPTIMAL_KINDRED_TOTE' AND OWNER = 'DM';

Select * FROM All_TAB_COLS WHERE TABLE_NAME = 'TWCC_BOSS_PACK_ROUTE' AND OWNER = 'DM';

-------------------------------------------------------------------------------------------------------------------------------- Users ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from role;
select * from ucl_user;
select * from app_instance;
select * from access_control;
select * from user_default;


-- Find user with their first and last name
select user_name, user_first_name, user_last_name
from ucl_user
where user_first_name like '%Ned%'
and user_last_name like '%Cox%';


-- Find the user with user name
select user_name, user_first_name, user_last_name
from ucl_user
where user_name = '334791';

select distinct(uu.user_name)"USER_ID", concat(concat(concat(uu.USER_FIRST_NAME,' '),uu.USER_MIDDLE_NAME),uu.USER_LAST_NAME)"USER_FULL_NAME", uu.created_source "USER_CREATED_BY", to_char(uu.created_dttm, 'MON-DD-YYYY') "USER_PROFILE_CREATED_DATE",
case when r.role_name IS NULL THEN 'NO ROLES ASSIGNED' 
     when ud.parameter_value = '-1' THEN 'CHECK USER DEFAULTS'
end as USER_PROFILE_ISSUE
from ucl_user uu
full outer join access_control ac on uu.ucl_user_id = ac.ucl_user_id
full outer join role r on ac.role_id = r.role_id
full outer join user_default ud on uu.ucl_user_id = ud.ucl_user_id
where uu.is_active = '1'
and (uu.user_name not in ('2_DC SYSTEMS','2_DF','2_ECOM PICK','2_ENGINEERING','2_VAS','3_REPLEN','1_FLEX','4_PTS','4_OSR','4_DF','1_REPLEN','3_OUTBOUND','2_IC','1_WAVING','3_COMPLIANCE','3_DF','1_PULL','2_ROUTING','3_ECOM PICK','1_ECOM PICK','4_WAVING','4_ROUTING','4_PULL','4_INBOUND','4_IC','5_ENGINEERING','2_ECOM PACK','2_FLEX','2_HR','3_OSR','2_PULL','3_PULL','1_ECOM PACK','1_IC','3_DC SYSTEMS','1_OUTBOUND','2_PTS','3_WAVING','4_ECOM PACK','1_VAS','3_HR','2_OUTBOUND','1_OSR','2_WAVING','4_VAS','4_REPLEN','5_FINANCE','slotfinal','2_OSR','1_PTS','2_REPLEN','3_ENGINEERING','3_VAS','1_ENGINEERING','3_ROUTING','4_HR','slotprep','1_ROUTING','3_IC','3_PTS','2_INBOUND','2_COMPLIANCE','1_HR','3_ECOM PACK','3_FLEX','4_OUTBOUND','4_COMPLIANCE','4_FLEX PLT','4_SORTRAK','4_DC SYSTEMS','system','slotslot','5_HR','4_ENGINEERING','1_INBOUND','5_ROUTING','4_ECOM PICK','slotrank','OSR')
and r.role_name is null
or ud.parameter_value = '-1')
and uu.created_dttm >= sysdate - 9999
and uu.user_first_name not like 'TERM%'
order by USER_ID;

-------------------------------------------------------------------------------------------------------------------------------- Allocations & Tasks ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from alloc_invn_dtl;
select * from locn_hdr;
select * from task_dtl;
select * from task_hdr;
select * from prod_trkg_tran;


-- Find Totes
-- cntr_nbr = iLPNs
-- task_cmp_ref_nbr = oLPNs
-- stat_code < 90 to check for open allocations
-- Find allocations with tote number        
select unique cntr_nbr, invn_need_type, carton_nbr, stat_code
from alloc_invn_dtl
where cntr_nbr in ('99019547'  )
and stat_code < 90
and invn_need_type = '60';


-- FInd all INT 52s and send the oLPNs that are tied to the EXC totes to operations
-- They will then have to send the list to Problem Res
-- Problem Res will then submit chase allocations 
select unique cntr_nbr, carton_nbr, invn_need_type, stat_code
from alloc_invn_dtl
where cntr_nbr in ('99019547'  )
and stat_code < 90
and invn_need_type = '52';


-- Check to see if there is any oLPNs that have uncompleted allocations
select cntr_nbr, carton_nbr, task_genrtn_ref_nbr, invn_need_type, stat_code
from alloc_invn_dtl aid
where exists (select 1 from task_dtl td where aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id)
and stat_code < 90;


-- Check the INTs for a certain case
select unique cntr_nbr, invn_need_type, carton_nbr, stat_code, create_date_time, mod_date_time
from alloc_invn_dtl
where cntr_nbr in ('99019547' )
order by mod_date_time desc;


-- Find tasks for iLPN/totes
select unique cntr_nbr, task_id, invn_need_type, stat_code, create_date_time, mod_date_time
from task_dtl 
where cntr_nbr in ('99048016'  )
and stat_code < 90
order by create_date_time desc;


-- Find cases that do not have the same allocated quantity as the wm allocated quantity
select td.task_id, td.invn_need_type, td.stat_code, td.qty_alloc, wi.wm_allocated_qty, wi.wm_allocated_qty - ld.size_value, wi.tc_lpn_id, wi.wm_inventory_id, 
       wi.item_id, wi.batch_nbr, wi.lpn_id, wi.lpn_detail_id, ld.size_value
from task_dtl td, wm_inventory wi, lpn_detail ld
where td.cntr_nbr = wi.tc_lpn_id
and ld.lpn_id = wi.lpn_id
and cntr_nbr in (  )
and td.task_id = '75649165'
and td.stat_code = '40'
and td.qty_alloc - wi.wm_allocated_qty <> 0;


-- Find allocations with oLPNs
select unique cntr_nbr, invn_need_type, carton_nbr, stat_code
from alloc_invn_dtl
where carton_nbr in ('00000197180416856929'  )
and stat_code < 90;
    
    
-- Find tasks with oLPN
select unique cntr_nbr, task_cmpl_ref_nbr, task_id, invn_need_type, stat_code
from task_dtl
where carton_nbr in ('00000197180416574298'  )
and stat_code < 90;


-- Find the INTs for the oLPN
select unique cntr_nbr, task_cmpl_ref_nbr, invn_need_type, stat_code
from task_dtl
where carton_nbr in ('00000197180413736217'  )
and stat_code < 90;


-- Find the task that was created for OSR location
select * from task_hdr where task_genrtn_ref_nbr = '';
    
    
-- Find the tasks associated with the the specific wave number
select unique (cntr_nbr), invn_need_type, task_id, stat_code
from task_dtl
where task_genrtn_ref_nbr = '202305070050' -- Change depending on your problem wave
--and task_type = '93'
and stat_code < '90';


-- Find task from item and location
select t.task_id, t.cntr_nbr, t.batch_nbr, t.invn_need_type, t.task_genrtn_ref_nbr, t.task_cmpl_ref_nbr, t.stat_code, l.locn_brcd, i.item_name, i.description
from task_dtl t, locn_hdr l, item_cbo i
where t.dest_locn_id = l.locn_id
and t.item_id = i.item_id
and l.dsp_locn = 'PE03128I08'
-- and i.item_name = '2O934710 IVY 2T'
and  stat_code < 90;


-- Find the open allocation with a specific location and item
select aid.cntr_nbr, aid.invn_need_type, aid.task_genrtn_ref_code, aid.task_cmpl_ref_code, i.item_name, lh.dsp_locn, lh.create_date_time
from alloc_invn_dtl aid, locn_hdr lh, item_cbo i
where aid.pull_locn_id = lh.locn_id
and aid.item_id = i.item_id
and lh.dsp_locn in ('PE03128I08')
and item_name = '1P291710 ASST 18M'
and stat_code < 90;

-------------------------------------------------------------------------------------------------------------------------------- Locations ----------------------------------------------------------------------------------------------------------------------------------------    

alter session set current_schema = DM;

select * from locn_hdr;
select * from lpn;
select * from alloc_invn_dtl;


-- Pick locations 
select locn_brcd, dsp_locn, locn_pick_seq, last_frozn_date_time, last_cnt_date_time, cycle_cnt_pending, prt_label_flag, user_id
from locn_hdr
where locn_brcd in ('PE03128I08?', 'PE03128I08?');


-- Resevere locations
select locn_brcd, dsp_locn, locn_pick_seq, last_frozn_date_time, last_cnt_date_time, cycle_cnt_pending, prt_label_flag, user_id
from locn_hdr
where LOCN_BRCD between 'RPT2206A01?' and 'RPT2206F03?';


-- Get the list of locations with quantity inside of them
select distinct dsp_locn
from locn_hdr lh inner join wm_inventory wi
on lh.locn_id = wi.location_id
where LOCN_BRCD between 'RPT1939A01?' and 'RPT1939F03?'
order by 1;


-- Check to see which locatoin has a task. 
-- If you're rebuilding a location(s) the process is the same: chekc for any tasks, complete the tasks then rebuild the location.
select t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.last_cnt_date_time, l.user_id
from task_dtl t, locn_hdr l
where t.pull_locn_id = l.locn_id
and l.dsp_locn in ('RPT1939D02'  )
and t.stat_code < 90;


-- 
select t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, i.item_name, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.last_cnt_date_time, l.user_id
from task_dtl t, locn_hdr l, item_cbo i
where t.pull_locn_id = l.locn_id
and t.item_id = i.item_id
and l.dsp_locn in ('RPT1939A01'  )
and i.item_name = 'C220B160 N 8'
and t.stat_code < 90;


-- Find the orders, tasks, and item associated with the truck number
select p.tran_type, p.tran_code, p.tran_nbr, p.cntr_nbr, p.nbr_of_cases, p.nbr_units, o.tc_order_id, o.order_status, t.task_id, i.item_name, i.description
from prod_trkg_tran p, orders o, task_dtl t, item_cbo i
where o.tc_order_id = p.tc_order_id
and t.task_id = p.task_id
and i.item_id = p.item_id;


-- Find the lpn assocaited with location and item 
select l.tc_lpn_id, l.lpn_status, l.lpn_facility_status, i.item_name, lh.dsp_locn, l.lpn_status_updated_dttm, lh.create_date_time, lh.last_frozn_date_time, lh.last_cnt_date_time,
       case when l.lpn_facility_status = '96' then 'iLPN consumed to Active' else 'Other' end as lpn_description,
       lfs.inbound_outbound_indicator
from locn_hdr lh, lpn l, item_cbo i, lpn_facility_status lfs
where lh.locn_id = l.curr_sub_locn_id
and l.item_id = i.item_id
and l.lpn_facility_status = lfs.lpn_facility_status
and lh.dsp_locn in ('RPT1940A01');
--and i.item_name = '3P441010 GY 5';


select * from locn_hdr;
select * from locn_hdr_arch;
select * from lpn;
select * from task_dtl;

-------------------------------------------------------------------------------------------------------------------------------- LPNS & Items ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from lpn;
select * from lpn_detail;
select * from lpn_facility_status;
select * from item_cbo;


-- Find the allocations for the lpn associated with the specified wave
select aid.cntr_nbr, aid.invn_need_type, aid.stat_code, l.tc_lpn_id, l.lpn_facility_status, l.lpn_status, aid.batch_nbr, w.wave_nbr
from alloc_invn_dtl aid, lpn l, wave_parm w
where aid.task_cmpl_ref_nbr = l.tc_lpn_id
and l.wave_nbr = w.wave_nbr
and aid.cntr_nbr is not null;


-- Find the lpn status based on the item
select l.lpn_id, l.tc_lpn_id, l.tc_reference_lpn_id, l.lpn_facility_status, ls.inbound_outbound_indicator, ls.description, i.item_name
from lpn l, lpn_facility_status ls, item_cbo i
where l.lpn_facility_status = ls.lpn_facility_status
and l.item_id = i.item_id
and i.item_name in ('1P651810 DM 6M')
order by i.item_name asc;


-- Check the date of LPN that ops is trying to manifest
select sched_ship_dttm from lpn where tc_lpn_id = '00000197180351349548';


-- Check the size of the container and make sure that it is getting deiverted to its destination
select l.tc_lpn_id, l.container_size, m.mod_date_time, m.divert, m.weight
from lpn l, twcc_mhe_message m
where l.tc_lpn_id = m.carton_nbr
and container_size between 'HC4' and 'HC8'
and divert = 'SCNMDL'
order by m.mod_date_time desc;


-- Find item assocaited with the iLPN
select cntr_nbr, carton_nbr, item_name, item_bar_code, reqd_batch_nbr
from alloc_invn_dtl aid, item_cbo i
where aid.item_id = i.item_id
and cntr_nbr in ('00000197180356072991')
and stat_code < 90;
    

-- How to check if tote is still on the floor
select distinct(aid.carton_nbr), aid.cntr_nbr, aid.BATCH_NBR, l.chute_id, ic.item_bar_code, ic.item_name, aid.qty_alloc, aid.stat_code, lfs.description
from item_cbo ic, alloc_invn_dtl aid, lpn l, lpn_facility_status lfs
where aid.item_id = ic.item_id 
and aid.carton_nbr = l.tc_lpn_id
and l.inbound_outbound_indicator = lfs.inbound_outbound_indicator 
and l.lpn_facility_status = lfs.lpn_facility_status
and aid.cntr_nbr in ('99022746')
and aid.stat_code < '90'
order by aid.carton_nbr asc;
    
    
-- Finding item barcodes for units in allocated ilpns/olpns
SELECT IC.ITEM_ID, IC.ITEM_NAME, IC.DESCRIPTION, IC.ITEM_BAR_CODE, AID.CARTON_NBR, AID.CNTR_NBR, AID.BATCH_NBR, AID.STAT_CODE
FROM ITEM_CBO IC, ALLOC_INVN_DTL AID
WHERE IC.ITEM_ID = AID.ITEM_ID
AND AID.STAT_CODE < '90'
AND AID.CARTON_NBR = '00000197180356072991';
    
    
-- Find allocated quantity for item
select * from alloc_invn_dtl a, locn_hdr l, item_cbo i
where a.dest_locn_id = l.locn_id
and a.item_id = i.item_id
and l.dsp_locn = 'CPSTG02A07'
and i.item_name = '2O934710 IVY 2T'
and stat_code < 90;

-------------------------------------------------------------------------------------------------------------------------------- Waves ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from wave_task_crit;
select * from wave_queue;
select * from wave_parm;
select * from arch_wave_parm;
select * from lpn;
select * from item_cbo;


-- Check the MHE Flag for OSR waves, if the MHE flag is set to 'Y' then run sys code "MHE-FLAG" to set it to 'N'
select wave_nbr, wave_desc, mhe_flag from wave_parm where wave_nbr in ('202401030092');


-- Checks to see who relesaed the wave
select * from event_message
where ek_wave_nbr = '202401030092'
--and user_id = 'yangj'
--where ek_ilpn_nbr = '00000197180104880649'
order by mod_date_time desc;
    
    
-- Check history for released waves
select * from event_message_history
where ek_wave_nbr = '202401030092'
order by mod_date_time desc;

-------------------------------------------------------------------------------------------------------------------------------- Orders ----------------------------------------------------------------------------------------------------------------------------------------                                

alter session set current_schema = DM;

select * from orders;
select * from order_line_item;
select * from lpn;
select * from tran_log;
select * from tran_log_message;
select * from lpn_facility_status;
select * from lpn_status;


-- Retrieve the orders
select unique o.tc_order_id, o.ext_purchase_order, l.tc_lpn_id, l.lpn_status, lfs.description, l.lpn_status_updated_dttm, l.created_dttm, l.last_updated_dttm
from orders o, lpn l, lpn_facility_status lfs
where o.order_id = l.order_id
and l.lpn_status = lfs.lpn_facility_status
and o.ext_purchase_order in ('JCAR91997307');


-- Find order with lpn
select o.order_id, o.tc_order_id, l.tc_lpn_id, l.lpn_facility_status
from lpn l, orders o
where l.tc_order_id = o.tc_order_id
and l.tc_lpn_id = '00000197181388003847';


-- Check if the order came through with any errors or not.
select * from tran_log tl, tran_log_message tlm
where tlm.tran_log_id = tl.tran_log_id
and msg_type = 'DistributionOrder'
and TL.CREATED_DTTM between '11-JUN-23' and '18-JUN-23'
and msg_line_text like '%1216262316%';
    

-- Determine weather the LPNs are BOSS orders or not
-- If the DC_CTR_NBR column is NULL then it is not a BOSS order, if it is not null, then the column will have the retail store number
-- If the O_PHONE_NUMBER column has the letter "B" then the order needs to be consolidated, if not then it needs to be loaded onto the truck to be shipped to the customer's chosen retail store
select l.lpn_id, tc_lpn_id, o.tc_order_id, dc_ctr_nbr, o_phone_number, w.wave_nbr, count(*) over() as lpns
from orders o, lpn l, wave_parm w
where o.tc_order_id = l.tc_order_id
and l.wave_nbr = l.wave_nbr
--and l.tc_lpn_id in ('')
and o_phone_number = 'B';
--and w.wave_nbr = '202304290054'
--and w.create_date_time > sysdate - 2;
--and l.inbound_outbound_indicator = 'O';


---(STS)-Ship to Store
---This SQL Checks to see if STS is ON for all stores
select * from facility f, facility_alias fa
where f.facility_id = fa.facility_id
and substr(fa.facility_alias_id,1,6) = '249380'
and f.ship_to_store = 0;


---This SQL Checks to see if STS is OFF for all stores
select * from facility f, facility_alias fa
where f.facility_id = fa.facility_id
and substr(fa.facility_alias_id,1,6) = '249380'
and f.ship_to_store = 1;


-- Cancel order(s) that are in pre-released status
select * from error_log where order_id = '149217481';
delete from error_log where order_id = '149217481';


-- Update the order to released status
select * from orders where tc_order_id = '1222318803';
update orders set do_status = '110' where tc_order_id = '1222318803';;
select * from order_line_item where order_id = '149217481';
update order_line_item set do_dtl_status = '110' where order_id = '149217481' and do_dtl_status = '105';


-- Find all ordes that are tied to the totes
select aid.cntr_nbr, aid.carton_nbr, aid.task_genrtn_ref_nbr, o.tc_order_id, aid.invn_need_type, aid.stat_code
from alloc_invn_dtl aid inner join orders o
on aid.tc_order_id = o.tc_order_id
where cntr_nbr in ('970077760710','970077760709','970077760705','970077760706','970077760708','970077760707','970077760711')
and stat_code < 90;

-------------------------------------------------------------------------------------------------------------------------------- Shipments ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from shipment;
select * from twcc_mhe_message;

-- Manifest
-- THIS SHOULD RETURN ANY OLPNS THAT COULD BE PROBLEMATIC 
select * from lpn lp, shipment sh 
where sh.tc_shipment_id = lp.tc_shipment_id 
and sh.shipment_status = '120' 
and lp.lpn_facility_status = '40';
    
    
-- Check the weight of the boxes 
-- '******' means invalid weight meaning that the box will not recieve a destination
select * from twcc_mhe_message 
where divert = 'SCNSHIP'
order by mod_date_time desc;

    
-- Enter in the oLPN that is giving the ship date error
select tc_lpn_id, SCHED_SHIP_DTTM from lpn
where tc_lpn_id = ''; -- Enter the olpn 
    

-- Updates the row to the current date added by one
update lpn
set sced_ship_dttm = to_date(sysdate) + 1
where tc_lpn_id = ''; -- Enter the olpn
    
    
-- Confirm that the shipments have been shipped, if the results come back empty, then you will need to ship confirm using the Ship Confirmm Rules UI.
select * from outpt_lpn
where tc_shipment_id in ('CS85018005');
    
    
-- Checks for oLPNs that were shipped
select tc_order_id, tc_lpn_id, lpn_facility_status, bol_nbr, ship_via from lpn 
where tc_shipment_id = 'CS85018005' 
and lpn_facility_status < 90;
    

-- Check the number of oLPNs that are in packed ststus from a shipment
select count(*) Number_of_LPNs from lpn 
where tc_shipment_id = 'CS85018005'
and lpn_facility_status = '30';


-- STS - Ship to Store
-- Checks to see if STS is on for all stores
select * from facility f, facility_alias fa
where f.facility_id = fa.facility_id
and substr(fa.facility_alias_id, 1, 6) = '249380'
and f.ship_to_store = 0;
    
    
-- Check to see if STS is off for all stores
select * from facility f, facility_alias fa
where f.facility_id = fa.facility_id
and substr(fa.facility_alias_id, 1, 6) = '249380'
and f.ship_to_store = 1;


-- Check the status of the appointment  
select appointment_id, facility_id, appt_status from ilm_appointments 
where tc_appointment_id = '101358626';
    

-- 80 stat code = delivered, 120 stat code = cancelled, 60 stat code = accepted, 20 stat code = available
select * from shipment 
where shipment_status = '60'
order by delivery_end_dttm desc;


-- Appointments
select * from ILM_APPT_DOCKS;
select * from ILM_APPT_EQUIPMENTS;
select * from ILM_APPT_SLOTS;
select * from ILM_APPT_SLOT_UTILIZATION;


-- Find the status of the shipment tied to an lpn
select l.tc_parent_lpn_id, s.tc_shipment_id, s.shipment_status, s.delivery_end_dttm
from shipment s, lpn l 
where s.shipment_id = l.tc_shipment_id
and s.shipment_status = '50'
order by s.delivery_end_dttm desc;


-- update lpn set shipment_id = 2640240, tc_shipment_id = 'CS03607725' where tc_lpn_id = '00000197181246626102';
    

-- FIND THE STATIC ROUTE BY CARTON NUMBER
select l.tc_lpn_id, l.tc_parent_lpn_id, o.assigned_static_route_id, l.shipment_id, l.tc_shipment_id, l.tracking_nbr, o.d_facility_alias_id, l.wave_nbr
from orders o, lpn l
where o.tc_order_id = l.tc_order_id
and tc_lpn_id IN ('00000197186577628542'  )
order by o.assigned_static_route_id;
    

-- LPNs with getting error during Routing
select tc_lpn_id, wave_nbr, lpn_facility_status, created_source, last_updated_source, created_dttm, last_updated_dttm
from lpn
where tc_lpn_id in (  );

-------------------------------------------------------------------------------------------------------------------------------- MHEs & Messages ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from cl_message;
select * from msg_log;
select * from event_message;
select * from cl_endpoint_queue;
select * from twcc_mhe_message;
select * from twcc_tote_audit;


-- Check the weight for each box
-- '*****' means invalid weight 
select * from twcc_mhe_message 
where divert = 'SCNMDL'
--and weight like '%******%'
order by mod_date_time desc;

-- Checks how many messages have failed for a certain event name
select count(CL.MSG_ID)
from CL_MESSAGE CL, CL_ENDPOINT_QUEUE EQ
where CL.MSG_ID = EQ.MSG_ID
and SOURCE_ID = 'WCS_SCANNERS'
and eq.status = '10'
and cl.when_Created > sysdate - 2;


-- Check the status for all oLPNs located in Mantissa
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 1) as Message_Number,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as oLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 6) as weight,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as scanner,
        regexp_substr(to_char(data), '[^/^]+', 1, 1) as user_id,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
where cm.source_id = 'MANTISSA_INBOUND_WEIGHT'
--and when_queued > sysdate - 1/24
order by when_queued desc;


-- Check the status for all iLPNs located in PTS
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 9) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        regexp_substr(to_char(data), '[^/^]+', 1, 8) as location,
        regexp_substr(to_char(data), '[^/^]+', 1, 11) as puts,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
where cm.source_id = 'WCS_PTS_PickConfirm'
--and when_queued > sysdate - 1/24
order by when_queued desc;


-- olPNs still in 'Packed' status after being scanned by SCNSHIP
select * 
from twcc_mhe_message tmm
join lpn l              on tmm.carton_nbr = l.tc_lpn_id
join orders o           using (tc_order_id)
left join lpn_lock ll   using (lpn_id)
join cl_message cm      on tmm.msg_id = cm.msg_id
where tmm.msg_id = cm.msg_id
and tmm.source_id = 'WCS_R/S_Scanned'
and tmm.divert = 'SCNSHIP'
and l.lpn_facility_status = '20'
and l.inbound_outbound_indicator = 'O'
--and o.lane_name = 'BOSS'
--and l.tracking_nbr like '%1LS%'  --LaserShip
and tmm.weight like '%*****%'
--and tmm.create_date_time between to_timestamp('05/15/2023' 18:30:00', 'MM/DD/YYYY HH24:MI:SS') and to_timestamp('05/15/2023' 04:30:00', 'MM/DD/YYYY HH24:MI:SS')
and tmm.create_date_time > to_timestamp('08/20/2023 18:30:00', 'MM/DD/YYYY HH24:MI:SS')
order by create_date_time desc;


--Tote Failed To Enter OSR And Not Consumed ... New & Improved??--
select to_substr(data,49,8)) as TOTE, source_id, when_created, cl.msg_id
from cl_message cl, cl_endpoint_queue cq
where cl.msg_id = cq.msg_id
and cl.when_created > sysdate-1/24
and source_id = 'OSR_CONTAINERSTATUSGTPCONSUMED'
and status = '6'
and to_char(substr(data,49,8)) in (select tc_lpn_Id from lpn where lpn_facility_status < '90')
and when_created > (select max(create_date_time) from alloc_invn_dtl where cntr_nbr = to_char(substr(data,49,8)))
order by when_created desc;


-- Check the status of the wave, if status is 5 then the event message for SDI was sent out successfully, if not then there is a connection issue.
select cl.msg_id, cl.event_id, cl.when_created, eq.when_status_changed, cl.data, eq.status
from cl_message cl, cl_endpoint_queue eq
where cl.msg_id = eq.msg_id
and cl.event_id like '%7029%'
and cl.data like '%202306230040%'
and cl.when_created > sysdate - 2
order by cl.when_created desc;


-- Find 6692 messages for transport orders
select msg_id, 
       regexp_substr(to_char(data), '[^/^]+', 1, 12) as TOTE,       
       regexp_substr(to_char(data), '[^/^]+', 1, 13) as QTY,
       regexp_substr(to_char(data), '[^/^]+', 1, 8) as ITEM,
       regexp_substr(to_char(data), '[^/^]+', 1, 11) as ITEM_BARCODE,
       regexp_substr(to_char(data), '[^/^]+', 1, 9) as LOT_CODE,
       regexp_substr(to_char(data), '[^/^]+', 1, 16) as VOLUME,
       when_created
from cl_message
where regexp_substr(to_char(data), '[^/^]+', 1, 12) in ('99019547')
and when_created > sysdate - 3
and event_id = '6692';

-------------------------------------------------------------------------------------------------------------------------------- CCFs, DB Locks & Sessions ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

-- Ecom Backlot
With 
a as(select trim(to_char(sum(order_qty), '999,999,999')) as prereleased from orders o, order_line_item oli where o.order_id = oli.order_id and order_type = 'EC' and do_status < '110'),
b as(select trim(to_char(sum(order_qty), '999,999,999')) as released from orders o, order_line_item oli where o.order_id = oli.order_id and order_type = 'EC' and do_status = '110'),
c as(select trim(to_char(sum(order_qty), '999,999,999')) as allocated from orders o, order_line_item oli where o.order_id = oli.order_id and order_type = 'EC' and do_status in ('120','130')),
d as(select trim(to_char(sum(order_qty), '999,999,999')) as inpacking from orders o, order_line_item oli where o.order_id = oli.order_id and order_type = 'EC' and do_status = '140'),
e as(select trim(to_char(sum(order_qty), '999,999,999')) as Total from orders o, order_line_item oli where o.order_id = oli.order_id and order_type = 'EC' and do_status <= '140')
select prereleased,released,allocated,inpacking "IN PACKING",Total from a,b,c,d,e;

