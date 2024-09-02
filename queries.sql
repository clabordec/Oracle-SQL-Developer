alter session set current_schema = DM;


-- Find certain columns
SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME = 'CNTR_NBR' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%MSG_LOG%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'RES%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE 'BATCH_NBR%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%TRACKING%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%QTY%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%XML%' AND OWNER = 'DM';


-- Find certain tables
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

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%TWCC%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ASN%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ARCHIVE%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LOG  %' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'MSG%' AND OWNER = 'DM';


-- Find certain tables and columns
SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'SHIPMENT' AND COLUMN_NAME LIKE '%GROUP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'SHIPMENT' AND COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'ORDERS' AND COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ARCH%' AND COLUMN_NAME LIKE '%LPN%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LPN%' AND COLUMN_NAME LIKE '%MANIFEST%' AND OWNER = 'DM';

-------------------------------------------------------------------------------------------------------------------------------- Users ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from role;
select * from ucl_user;
select * from app_instance;
select * from access_control;
select * from user_default;

select * from cl_message where data like '%00000197180464613246%';


-- Find user with their first and last name
select user_name, user_first_name, user_last_name, is_active
from ucl_user
where user_first_name like '%Jeanette%'
and user_last_name like '%William%';


-- Find the user with user name
select user_name, user_first_name, user_last_name, is_active
from ucl_user
where user_name in ('351033', '351028', '351026');


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
where cntr_nbr in (  )
and stat_code < 90
and invn_need_type = '60';


-- FInd all INT 52s and send the oLPNs that are tied to the EXC totes to operations
-- They will then have to send the list to Problem Res
-- Problem Res will then submit chase allocations 
select unique cntr_nbr, carton_nbr, invn_need_type, stat_code
from alloc_invn_dtl
where cntr_nbr in (  )
and stat_code < 90
and invn_need_type = '52';


select cntr_nbr, carton_nbr, ic.item_name, ic.item_bar_code, stat_code, mod_date_time
from alloc_invn_dtl aid, item_cbo ic
where aid.item_id = ic.item_id
and item_bar_code = '195862649013'
and cntr_nbr = '99043953'
and mod_date_time > sysdate - 1;

-- Find tasks for iLPN/totes
select unique cntr_nbr, task_id, carton_nbr, invn_need_type, task_type, stat_code, create_date_time, mod_date_time
from task_dtl 
where cntr_nbr in ( '970902507913' ) 
--and stat_code < 90
order by create_date_time desc;


-- Get the most recent lpn
select l.tc_lpn_id, ic.item_name, ic.item_bar_code, l.last_updated_dttm
from item_cbo ic, lpn l
where ic.item_id = l.item_id
and item_bar_code = '195862520992'
and l.last_updated_dttm > sysdate - 1/24;


-- Check for open tasks for specified item(s)
select task_id, item_name, item_bar_code
from task_dtl td, item_cbo ic
where td.item_id = ic.item_id
and item_name in ('1R545710 B 6M', '1R545710 B 9M')
and batch_nbr = 'EC002'
and stat_code < 90;


-- Check the INTs for a certain case
select unique cntr_nbr, invn_need_type, carton_nbr, task_genrtn_ref_nbr, stat_code, create_date_time, mod_date_time
from alloc_invn_dtl
where cntr_nbr in ('EXC_170824_001244623'  )
--and stat_code < 90
and mod_date_time > sysdate - 2
order by mod_date_time desc;


-- Find allocations with oLPNs
select unique cntr_nbr, invn_need_type, carton_nbr, stat_code
from alloc_invn_dtl
where carton_nbr in ('00000197181307595590'  )
and stat_code < 90;

    
-- Find tasks with oLPN
select unique cntr_nbr, task_cmpl_ref_nbr, task_id, invn_need_type, stat_code
from task_dtl
where carton_nbr in ('00000197181307595590'  )
and stat_code < 90;


-- Find the INTs for the oLPN
select unique cntr_nbr, task_cmpl_ref_nbr, invn_need_type, stat_code, user_id
from task_dtl
where carton_nbr in ('00000197181307595590'  );


-- Check to see if there is any oLPNs that have uncompleted allocations
select cntr_nbr, carton_nbr, task_genrtn_ref_nbr, invn_need_type, stat_code
from alloc_invn_dtl aid
where exists (select 1 from task_dtl td where aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id)
and stat_code < 90;


-- Check wave number for iLPN/tote
select cntr_nbr, task_genrtn_ref_nbr, task_cmpl_ref_nbr, carton_nbr, batch_nbr, stat_code, create_date_time, mod_date_time
from alloc_invn_dtl 
where cntr_nbr = '99002155' 
and stat_code < 90;


-- Check PTS cases
select tc_lpn_id, lpn_facility_status, total_lpn_qty, dsp_locn 
from lpn lp, locn_hdr lh 
where lp.curr_sub_locn_id = lh.locn_id
and lp.lpn_facility_status < '20' and tc_lpn_id in 
(select to_char(substr(data,49,20))
from cl_message cl, cl_endpoint_queue cq
where cl.msg_id = cq.msg_id
and cl.source_id = 'WCS_PTS_CartonClose'
and cq.status = '6')
order by dsp_locn asc;


--Clean up PTS--
select tc_lpn_id, lpn_facility_status, total_lpn_qty, dsp_locn 
from lpn lp, locn_hdr lh 
where lp.curr_sub_locn_id = lh.locn_id
and lp.lpn_facility_status < '20' 
and tc_lpn_id in (select to_char(substr(data,49,20))
                  from cl_message cl, cl_endpoint_queue cq
                  where cl.msg_id = cq.msg_id
                  and cl.source_id = 'WCS_PTS_CartonClose'
                  and cq.status = '6')
order by dsp_locn asc;


---Needs a 6691
SELECT
--*
 DISTINCT
    ( tmm.carton_nbr )
FROM
    twcc_mhe_message tmm
WHERE
    tmm.divert = 'SCNMDL'
    AND tmm.carton_nbr LIKE '0000%'
    AND tmm.carton_nbr IN (
        SELECT
            cntr_nbr
        FROM
            alloc_invn_dtl
        WHERE
            invn_need_type = '60'
            AND stat_code = '0'
    )
    AND tmm.mod_date_time > sysdate - 4 / 24
    AND NOT EXISTS (
        SELECT
            e.ek_ilpn_nbr
        FROM
            event_message e
        WHERE
            tmm.carton_nbr = e.ek_ilpn_nbr
            AND e.event_id = '6691'
    );


---New stuff that will jackpot if it has this issue, try to catch it before it jackpots Put to store RF to allocate then 6691 to give destinations
SELECT
    td.task_id,
    td.cntr_nbr,
    td.task_genrtn_ref_nbr,
    td.create_date_time,
    locn_class,
    td.stat_code,
    lh.dsp_locn
FROM
    task_dtl td,
    lpn l,
    locn_hdr lh
WHERE
    lh.locn_id = l.curr_sub_locn_id
    AND td.cntr_nbr = l.tc_lpn_id
    AND td.invn_need_type = '53'
    AND td.stat_code = '90'
    AND l.lpn_facility_status = '30'
    AND l.tc_lpn_id NOT IN (
        SELECT
            cntr_nbr
        FROM
            alloc_invn_dtl
        WHERE
            invn_need_type = '60'
    )
    AND td.task_genrtn_ref_nbr > '202402230030'
    AND NOT EXISTS (
        SELECT
            e.ek_ilpn_nbr
        FROM
            event_message e
        WHERE
            e.ek_ilpn_nbr = td.cntr_nbr
            AND e.event_id = '6691'
    )
ORDER BY
    task_genrtn_ref_nbr ASC;


-- Find cases that do not have the same allocated quantity as the wm allocated quantity
select td.task_id, td.invn_need_type, td.stat_code, td.qty_alloc, wi.wm_allocated_qty, wi.wm_allocated_qty - ld.size_value, wi.tc_lpn_id, wi.wm_inventory_id, 
       wi.item_id, wi.batch_nbr, wi.lpn_id, wi.lpn_detail_id, ld.size_value
from task_dtl td, wm_inventory wi, lpn_detail ld
where td.cntr_nbr = wi.tc_lpn_id
and ld.lpn_id = wi.lpn_id
and cntr_nbr in ('PDF0221B03')
--and td.task_id = '75649165'
--and td.stat_code = '40'
and td.qty_alloc - wi.wm_allocated_qty <> 0;


-- Get the barcodes for a specific task for chutes
-- This is needed whenever the chute closer is having issues closing out the chute
-- Use the PCK task group when completing the task
select task_seq_nbr, task_id, item_name, item_bar_code, lh.dsp_locn
from task_dtl td, item_cbo ic, locn_hdr lh
where td.item_id = ic.item_id
and td.pull_locn_id = lh.locn_id
and td.stat_code < 90
and task_id = '89098336'
order by task_seq_nbr;


-- Find the task that was created for OSR location
select * from task_hdr where task_genrtn_ref_nbr = '';
    
    
-- Find the tasks associated with the the specific wave number
select unique (cntr_nbr), invn_need_type, task_id, stat_code
from task_dtl
where task_genrtn_ref_nbr = '202305070050' -- Change depending on your problem wave
--and task_type = '93'
and stat_code < '90';


-- Check to see if the task was split into several totes
select td.task_id,
       aid.cntr_nbr,
       aid.invn_need_type,
       aid.stat_code,
       td.stat_code,
       aid.qty_alloc,
       aid.qty_pulld
from alloc_invn_dtl aid
inner join task_dtl td
on aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id
where task_id = '';


-- Find task from item and location
select t.task_id, t.cntr_nbr, t.batch_nbr, t.invn_need_type, t.task_genrtn_ref_nbr, t.task_cmpl_ref_nbr, t.stat_code, l.locn_brcd, i.item_name, i.description
from task_dtl t, locn_hdr l, item_cbo i
where t.dest_locn_id = l.locn_id
and t.item_id = i.item_id
and l.dsp_locn = 'PDF0221B03'
-- and i.item_name = '2O934710 IVY 2T'
and  stat_code < 90;


-- Find the open allocation with a specific location and item
select aid.cntr_nbr, aid.invn_need_type, aid.task_genrtn_ref_code, aid.task_cmpl_ref_code, i.item_name, lh.dsp_locn, lh.create_date_time
from alloc_invn_dtl aid, locn_hdr lh, item_cbo i
where aid.pull_locn_id = lh.locn_id
and aid.item_id = i.item_id
and lh.dsp_locn in ('PDF0221B03')
--and item_name = '1P291710 ASST 18M'
and stat_code < 90;

-------------------------------------------------------------------------------------------------------------------------------- Locations ----------------------------------------------------------------------------------------------------------------------------------------    

alter session set current_schema = DM;

select * from locn_hdr;
select * from lpn;
select * from alloc_invn_dtl;


select * from int_path_defn where nxt_work_area = 'PSG1' order by create_date_time desc;

select * from int_path_defn where invn_need_type = '2' order by create_date_time desc;


-- Check location TBF quantity
select lh.dsp_locn, 
       ic.item_name, 
       ic.description, 
       wi.tc_lpn_id, 
       wi.on_hand_qty, 
       wi.wm_allocated_qty, 
       wi.to_be_filled_qty
from locn_hdr lh
inner join wm_inventory wi
on lh.locn_id = wi.location_id
inner join item_cbo ic
on wi.item_id = ic.item_id
where dsp_locn = 'PE23501A04';


-- Pick locations 
select locn_brcd, dsp_locn, locn_pick_seq, last_frozn_date_time, last_cnt_date_time, cycle_cnt_pending, prt_label_flag, user_id
from locn_hdr
where locn_brcd in ('PE23501A04?', 'PE23501A04?');


-- Resevere locations
select locn_id, locn_brcd, dsp_locn, locn_pick_seq, last_frozn_date_time, last_cnt_date_time, cycle_cnt_pending, prt_label_flag, user_id
from locn_hdr
where LOCN_BRCD between 'RPT3206F02?' and 'RPT3206F02?';


-- Get the list of locations with quantity inside of them
select distinct dsp_locn
from locn_hdr lh 
inner join wm_inventory wi
on lh.locn_id = wi.location_id
where locn_brcd between 'RPT1715A01?' and 'RPT1715A01?'
order by 1;


-- Check to see which locatoin has a task. 
-- If you're rebuilding a location(s) the process is the same: check for any tasks, complete the tasks then rebuild the location.
select t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.last_cnt_date_time, l.user_id
from task_dtl t, locn_hdr l
where t.pull_locn_id = l.locn_id
and l.dsp_locn in ('PE23501A04'  )
and t.stat_code < 90;


-- 
select t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, i.item_name, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.last_cnt_date_time, l.user_id
from task_dtl t, locn_hdr l, item_cbo i
where t.pull_locn_id = l.locn_id
and t.item_id = i.item_id
and l.dsp_locn in ('PE40809B01'  )
and i.item_name = '1Q135210 ASST 24M'
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
and lh.dsp_locn in ('PE13503A07');
--and i.item_name = '3P441010 GY 5';

-------------------------------------------------------------------------------------------------------------------------------- LPNS & Items ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from lpn;
select * from lpn_detail;
select * from lpn_facility_status;
select * from item_cbo;


-- Get ASNs for the following iLPNs
select l.tc_lpn_id, a.tc_asn_id
from lpn l, asn a
where l.tc_asn_id = a.tc_asn_id
and l.tc_lpn_id in ('00006644541894037692', '00006644541894042597', '00006644541894042580', '00006644541894041448', '00006644541894041828', '00006644541894037692');


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
    
    
-- Error labels during routing
select l.tc_lpn_id, 
       l.lpn_facility_status, 
       o.tc_order_id, 
       l.tracking_nbr,
       l.wave_nbr,
       l.ship_via, 
       o.lane_name, 
       o.ref_field_3,
       l.lpn_label_type,
       o.d_address_1,
       o.d_address_2,
       o.pickup_start_dttm, 
       o.pickup_end_dttm,
       o.delivery_start_dttm,
       o.delivery_end_dttm,
       o.order_date_dttm
from lpn l, orders o
where o.tc_order_id = l.tc_order_id
-- and d_address_1 like '%%'
-- and wave_nbr = ''
-- and o.tc_order_id in (  )
and d_city = 'APO'
and l.lpn_facility_status < 90
and o.ref_field_3 = 'EC';
-- snd tc_lpn_id = ''
-- and ship_via = 'CALL'
-- and d_address_1 in (  );

-------------------------------------------------------------------------------------------------------------------------------- Waves ----------------------------------------------------------------------------------------------------------------------------------------

alter session set current_schema = DM;

select * from wave_task_crit;
select * from wave_queue;
select * from wave_parm;
select * from arch_wave_parm;
select * from lpn;
select * from item_cbo;

select * from cl_message where data like '%970902504871%' order by when_created desc;

-- Check the MHE Flag for OSR waves, if the MHE flag is set to 'Y' then run sys code "MHE-FLAG" to set it to 'N'
select wave_nbr, wave_desc, mhe_flag from wave_parm where wave_nbr in ('202406160007');

select * from task_dtl where carton_nbr = '00000197180446733238';

-- Checks to see who relesaed the wave
select * from event_message
where ek_wave_nbr = '202409010080'
--and user_id = 'yangj'
--where ek_ilpn_nbr = '00000197180104880649'
order by mod_date_time desc;


select wave_nbr from lpn where tc_lpn_id = '970902504090';
select * from wave_parm;


select task_id, task_type, stat_code, user_id, create_date_time, mod_date_time 
from task_dtl 
where task_genrtn_ref_nbr like '202409010080%' 
and stat_code < 90
order by mod_date_time desc;

select count(*) number_of_tasks, stat_code, task_type 
from task_dtl 
where task_genrtn_ref_nbr = '202409010080' 
group by stat_code, task_type;

select * from task_hdr where task_genrtn_ref_nbr = '202406150049001';

select * from task_dtl where task_id = '86818484';

select * from wave_parm where wave_nbr = '202406010022';
select count(*), stat_code from task_dtl where task_genrtn_ref_nbr = '202406010023' group by stat_code;
    
    
-- Check history for released waves
select * from event_message_history
where ek_wave_nbr = '202406010023'
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


-- Check the latest orders bridging in
select o.last_updated_dttm, o.* from orders o order by o.last_updated_dttm desc;


-- Find the company name for a certain LPN
select l.tc_lpn_id, o.bill_to_name
from orders o, lpn l
where o.tc_order_id = l.tc_order_id
and tc_lpn_id = '00000197180455361835';


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


-- Check weight
select ord.tc_order_id, oli.created_dttm, ic.item_name, oli.unit_vol, oli.unit_wt 
from order_line_item oli, orders ord, item_cbo ic 
where oli.ITEM_NAME in ('1Q539210 P 18M')
--oli.item_id = '3101608'
and ord.order_id = oli.order_id
and ic.item_id = oli.item_id
--and wave_nbr = '202210260002'
and oli.is_chase_created_line is null
order by oli.created_dttm desc;

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
select tc_order_id, tc_lpn_id, lpn_facility_status, bol_nbr, ship_via 
from lpn 
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
and tc_lpn_id in ( '00000197181308166843' )
order by o.assigned_static_route_id;
    
    select * from msg_log where msg like '%00000197181308166843%';

-- LPNs with getting error during Routing
select tc_lpn_id, wave_nbr, lpn_facility_status, created_source, last_updated_source, created_dttm, last_updated_dttm
from lpn
where tc_lpn_id in ('00006644541794904223'  );

-------------------------------------------------------------------------------------------------------------------------------- MHEs & Messages ----------------------------------------------------------------------------------------------------------------------------------------
select * from locn_hdr;
select * from task_dtl;
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


-- Will have records for each oLPN getting routing
SELECT substr(msg, 1, 20) as olpn,
       mg.* 
FROM MSG_LOG mg 
WHERE module = 'LOGISTYX'
ORDER BY log_date_time DESC;

select o.last_updated_dttm, o.*
from orders o
order by o.last_updated_dttm desc;

select * from msg_log where msg like '%00000197181307664111%';
select * from cl_message;
select * from twcc_mhe_message;


-- Check the wave for all iLPNs located in Wavebank
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 5
--and regexp_substr(to_char(data), '[^/^]+', 1, 7) = '970902501506'
and cm.source_id = 'USS_INDUCT_MODE'
order by when_queued desc;


-- Check the wave for all iLPNs located in Wavebank
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 3
--and regexp_substr(to_char(data), '[^/^]+', 1, 7) = '970902509916'
and cm.source_id = 'WCS_USS_IND_CONSUMED'
order by when_queued desc;


-- Check the wave for all iLPNs located in Wavebank
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 2
--and regexp_substr(to_char(data), '[^/^]+', 1, 7) = '970902509916'
and cm.source_id = 'WCS_USS_PS_DIVERTED'
order by when_queued desc;


-- Check the wave for all iLPNs located in Wavebank
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 1/24
--and regexp_substr(to_char(data), '[^/^]+', 1, 7) = '970902508781'
and cm.source_id = 'WCS_SCANNERS'
order by when_queued desc;


-- Check the wave for all iLPNs located in Wavebank
select to_char(clq.msg_id) as msg_id,
       ce.name,
       clq.status as status_number,
       case when clq.status = '5' then 'Succeed'
            when clq.status = '6' then 'Failed'
            when clq.status = '2' then 'Ready'
            when clq.status = '10' then 'Busy'
            else 'Other'
        end as status,
        regexp_substr(to_char(data), '[^/^]+', 1, 7) as iLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 1/24
--and regexp_substr(to_char(data), '[^/^]+', 1, 7) = '00006644541785144362'
and cm.source_id = 'SDI_WB_DIVERTCONFIRM'
order by when_queued desc;


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
       regexp_substr(to_char(data), '[^/^]+', 1, 9) as user_id,
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
        regexp_substr(to_char(data), '[^/^]+', 1, 10) as oLPN,
        regexp_substr(to_char(data), '[^/^]+', 1, 4) as wave,
        regexp_substr(to_char(data), '[^/^]+', 1, 8) as location,
        regexp_substr(to_char(data), '[^/^]+', 1, 11) as puts,
        when_queued
from cl_endpoint ce
inner join cl_endpoint_queue clq on ce.endpoint_id = clq.endpoint_id
inner join cl_message cm         on clq.msg_id = cm.msg_id
--where when_queued between '13-JAN-24 06.30.00.000000000 PM' and '15-JAN-24 04.30.00.000000000 AM'
where when_queued >= sysdate - 1
and regexp_substr(to_char(data), '[^/^]+', 1, 10) = '00000197181307664111'
and cm.source_id = 'WCS_PTS_PickConfirm'
order by when_queued desc;


-- olPNs still in 'Packed' status after being scanned by SCNSHIP
select *
from twcc_mhe_message tmm
join lpn l on tmm.carton_nbr = l.tc_lpn_id
join orders o on l.tc_order_id = o.tc_order_id
left join lpn_lock ll on l.lpn_id = ll.lpn_id
join cl_message cm on tmm.msg_id = cm.msg_id
where tmm.msg_id = cm.msg_id
and tmm.source_id = 'WCS_R/S_Scanned'
and tmm.divert = 'SCNSHIP'
and l.lpn_facility_status = '20'
and l.inbound_outbound_indicator = 'O'
--and o.lane_name = 'BOSS'
--and l.tracking_nbr like '%1LS%'  --LaserShip
and tmm.weight like '%*****%'
--and tmm.create_date_time between to_timestamp('05/15/2023' 18:30:00', 'MM/DD/YYYY HH24:MI:SS') and to_timestamp('05/15/2023' 04:30:00', 'MM/DD/YYYY HH24:MI:SS')
and tmm.create_date_time > '17-FEB-24 06.30.00.000000000 PM'
order by create_date_time desc;


-- Tote Failed To Enter OSR And Not Consumed ... New & Improved??--
select to_substr(data,49,8)) as TOTE, source_id, when_created, cl.msg_id
from cl_message cl, cl_endpoint_queue cq
where cl.msg_id = cq.msg_id
and cl.when_created > sysdate - 1/24
and source_id = 'OSR_CONTAINERSTATUSGTPCONSUMED'
and status = '6'
and to_char(substr(data,49,8)) in (select tc_lpn_id from lpn where lpn_facility_status < '90')
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
       event_id,
       regexp_substr(to_char(data), '[^/^]+', 1, 12) as TOTE,       
       regexp_substr(to_char(data), '[^/^]+', 1, 13) as QTY,
       regexp_substr(to_char(data), '[^/^]+', 1, 8) as ITEM,
       regexp_substr(to_char(data), '[^/^]+', 1, 11) as ITEM_BARCODE,
       regexp_substr(to_char(data), '[^/^]+', 1, 9) as LOT_CODE,
       regexp_substr(to_char(data), '[^/^]+', 1, 16) as VOLUME,
       when_created
from cl_message
where regexp_substr(to_char(data), '[^/^]+', 1, 12) in ('99033184')
and when_created > sysdate - 5
and event_id = '6692';


--CHUTE
---Finding failing messages
SELECT cle.name,
       TO_CHAR(cleq.msg_id) msg_id,
       when_queued,
       DECODE(cleq.status, '5', 'Succeed', '6', 'Failed','10', 'Busy', '2', 'Ready') AS status,cleq.status,
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 4) "WAVE",
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 6) "TASK1",
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 7) "TASK",
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 9) "CHUTE",
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 10) "iLPN",
--       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 11) ,
--       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 12),
       regexp_substr(TO_CHAR(data), '[^/^]+', 1, 14) "User",
       cm.source_id,
       data
FROM cl_endpoint cle,
     cl_endpoint_queue cleq,
     cl_message cm
--    ,lpn l
WHERE cle.endpoint_id = cleq.endpoint_id
AND cleq.msg_id = cm.msg_id
AND cm.source_id = 'WCS_USorter_ToteChute'
--and regexp_substr(TO_CHAR(data), '[^/^]+', 1, 10) like '%970906715469%' -----change tote
--AND regexp_substr(TO_CHAR(data), '[^/^]+', 1, 14) in('308501') ---change User name 
--and cleq.status in('6','10','2')
AND cm.when_created > SYSDATE -  1/24 -------change time interval
--and   regexp_substr(TO_CHAR(data), '[^/^]+', 1, 9)   in ('3U56','3L56')
--and  regexp_substr(TO_CHAR(data), '[^/^]+', 1, 9) like '3%'
--AND l.lpn_facility_status = '50'
--AND cm.source_id = '9001_9002_User_Interface' 
ORDER BY when_queued DESC;

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


-- Find all the multisku iLPN on the asn and valdiate the LPN on the correct xml.
select lpn, count(lpn) as number_of_lpns
from ASNDBA.asn_intransit_lpn@wms12_to_omnia 
where asn_number ='221583652' 
group by lpn
having count(lpn) > 1;


/* DC12 gets foreign trailers now, we need to make sure that the asn we fix are done correctly the first time around. 
   Here is the query to validate if the trailer is part of FTZ. 
*/
-- FTZ uses invoice to file duty payments
-- Any invoice flagged with Y are FTZ
select tc_lpn_id, iiff.* 
from ip_invoice_ftz_flag iiff
join lpn_detail ld on iiff.invoice_booking_number = ld.cut_nbr
join lpn l on ld.lpn_id = l.lpn_id
join asn a on a.tc_asn_id = l.tc_asn_id
where a.trailer_number = 'CAAU5395875';


-- Check for database locks
select c.status,
       OS_USER_NAME "Terminal",
       a.PROCESS "UNIX proccess",
       substr(ORACLE_USERNAME,1,10) "Locker",
       substr(PROGRAM,1,99) "Program",
       NVL(lockwait,'ACTIVE') "Wait",
       substr(DECODE(LOCKED_MODE,2,'ROW SHARE',3, 'ROW EXCLUSIVE',4, 'SHARE',5,'SHARE ROW EXCLUSIVE',6, 'EXCLUSIVE',  'UNKNOWN'),1,12) "Lockmode",
       OBJECT_TYPE "Object Type",
       object_name "Object Name",
       SESSION_ID "Session ID",
       "SERIAL#" "Serial",
       substr(c.SID,1,6) "SID",
       c.sql_id,
       logon_time, seconds_in_wait
FROM  SYS.V_$LOCKED_OBJECT A,  SYS.ALL_OBJECTS B,   SYS.V_$SESSION c
where A.OBJECT_ID = B.OBJECT_ID
and object_name not in ('PROC_LOCK','LABOR_MSG') 
and object_name not like '%TMP%' 
and object_name not like '%$%'
and c.program like 'Pk%'
and C.SID = A.SESSION_ID  and seconds_in_wait > 300;


SELECT ASN_NUMBER, lpn, QUANTITY, asn_intransit_lpn.*
from ASNDBA.asn_intransit_lpn@wms12_to_omnia
where lpn in ('00006644541888263588');


-- Checking ASN info header
SELECT wmo1.id,
       ltrim(wmo1.asn_number,0) asn /*, 
       PO_NUMBER, LINE_NUMBER*/, 
       CONTAINER_NUMBER,suM(wmo1.QUANTITY ), 
       count(DISTINCT wmo1.PRODUPC), 
       count( wmo1.lpn), 
       count( DISTINCT wmo1.lpn), 
       min(wmo1.lpn), 
       max(wmo1.lpn), 
       wmo1.STATUS, 
       wmo1.asn_number
from ASNDBA.asn_intransit_lpn@wms12_to_omnia wmo1
left join prodskus@wms12_to_omnia wmo2
on wmo1.id = wmo2.id
--WHERE CONTAINER_NUMBER LIKE '%155166%'
--WHERE po_number = '19077144'
WHERE ltrim(asn_number,0) in ('546770797')
--AND STATUS <> 'OPEN'
GROUP BY  wmo1.id,
          ASN_NUMBER/*, 
          PO_NUMBER, 
          LINE_NUMBER*/, 
          CONTAINER_NUMBER, 
          STATUS;

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%PRODUPC%' AND OWNER = 'DM';

select * from ASNDBA.asn_intransit_lpn@wms12_to_omnia;
select * from prodskus@wms12_to_omnia;
SELECT * FROM ALL_DB_LINKS;
select * from msg_log where msg like '%847945895%';
