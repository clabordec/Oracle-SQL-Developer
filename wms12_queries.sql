ALTER SESSION SET current_schema = DM;


-- Find certain columns with the owner as DM
SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME = 'CNTR_NBR' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE COLUMN_NAME LIKE '%MSG_LOG%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'RES%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE 'BATCH_NBR%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%TRACKING%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%QTY%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE COLUMN_NAME LIKE '%XML%' AND OWNER = 'DM';


-- Find certain tables with the owner as DM
SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'LPN' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'ALLOC_INVN_DTL' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'ORDERS' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'PROD_TRKG_TRAN' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'task_DTL' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'TMP_task_CREATION_LM_task_DTLS' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'TMP_task_CREATION_SELECTED_AID' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'TWCC_TOTE_AUDIT' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'OPTIMAL_KINDRED_TOTE' AND OWNER = 'DM';

SELECT * FROM All_TAB_COLS WHERE TABLE_NAME = 'TWCC_BOSS_PACK_ROUTE' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%TWCC%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ASN%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ARCHIVE%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LOG%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'MSG%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%MANIFEST%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE 'PICKING%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%USER%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%WAVE%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%SYS%' AND OWNER = 'SYS';


-- Find certain tables AND columns with the owner as DM
SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'SHIPMENT' AND COLUMN_NAME LIKE '%GROUP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'SHIPMENT' AND COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'ORDERS' AND COLUMN_NAME LIKE '%SHIP%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ARCH%' AND COLUMN_NAME LIKE '%LPN%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LPN%' AND COLUMN_NAME LIKE '%MANIFEST%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LPN%' AND COLUMN_NAME LIKE '%STATUS%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%ORDERS%' AND COLUMN_NAME LIKE '%PO%' AND OWNER = 'DM';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%LPN%' AND COLUMN_NAME LIKE '%PALLET%' AND OWNER = 'DM';


-- Find certain tables
SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%SYS%';

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%CLIENT%';

-------------------------------------------------------------------------------------------------------------------------------- Users ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

SELECT * FROM role;
SELECT * FROM ucl_user;
SELECT * FROM app_instance;
SELECT * FROM access_cONtrol;
SELECT * FROM user_default;


-- Find user with their first and last name
SELECT user_name, user_first_name, user_lASt_name, is_active
FROM ucl_user
WHERE user_first_name like '%Claudia%'
AND user_last_name like '%Gutierrez Carbajal%';


-- Find the user WITH user name
SELECT user_name, user_first_name, user_last_name, is_active
FROM ucl_user
WHERE user_name in ('361774', '361688');


-- 
SELECT distinct(uu.user_name)"USER_ID", cONcat(cONcat(cONcat(uu.USER_FIRST_NAME,' '),uu.USER_MIDDLE_NAME),uu.USER_LAST_NAME)"USER_FULL_NAME", uu.created_source "USER_CREATED_BY", TO_CHAR(uu.created_dttm, 'MON-DD-YYYY') "USER_PROFILE_CREATED_DATE",
CASE WHEN r.role_name IS NULL THEN 'NO ROLES ASSIGNED' 
     WHEN ud.parameter_value = '-1' THEN 'CHECK USER DEFAULTS'
END AS USER_PROFILE_ISSUE
FROM ucl_user uu
full outer JOIN access_cONtrol ac ON uu.ucl_user_id = ac.ucl_user_id
full outer JOIN role r ON ac.role_id = r.role_id
full outer JOIN user_default ud ON uu.ucl_user_id = ud.ucl_user_id
WHERE uu.is_active = '1'
AND (uu.user_name not in ('2_DC SYSTEMS','2_DF','2_ECOM PICK','2_ENGINEERING','2_VAS','3_REPLEN','1_FLEX','4_PTS','4_OSR','4_DF','1_REPLEN','3_OUTBOUND','2_IC','1_WAVING','3_COMPLIANCE','3_DF','1_PULL','2_ROUTING','3_ECOM PICK','1_ECOM PICK','4_WAVING','4_ROUTING','4_PULL','4_INBOUND','4_IC','5_ENGINEERING','2_ECOM PACK','2_FLEX','2_HR','3_OSR','2_PULL','3_PULL','1_ECOM PACK','1_IC','3_DC SYSTEMS','1_OUTBOUND','2_PTS','3_WAVING','4_ECOM PACK','1_VAS','3_HR','2_OUTBOUND','1_OSR','2_WAVING','4_VAS','4_REPLEN','5_FINANCE','slotfinal','2_OSR','1_PTS','2_REPLEN','3_ENGINEERING','3_VAS','1_ENGINEERING','3_ROUTING','4_HR','slotprep','1_ROUTING','3_IC','3_PTS','2_INBOUND','2_COMPLIANCE','1_HR','3_ECOM PACK','3_FLEX','4_OUTBOUND','4_COMPLIANCE','4_FLEX PLT','4_SORTRAK','4_DC SYSTEMS','system','slotslot','5_HR','4_ENGINEERING','1_INBOUND','5_ROUTING','4_ECOM PICK','slotrank','OSR')
AND r.role_name is null
or ud.parameter_value = '-1')
AND uu.created_dttm >= sysdate - 9999
AND uu.user_first_name not like 'TERM%'
ORDER BY USER_ID;

-------------------------------------------------------------------------------------------------------------------------------- Allocations & tasks ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

SELECT * FROM alloc_invn_dtl;
SELECT * FROM locn_hdr;
SELECT * FROM task_dtl;
SELECT * FROM task_hdr;
SELECT * FROM prod_trkg_tran;


-- Find Totes
-- cntr_nbr = iLPNs
-- task_cmp_ref_nbr = oLPNs
-- stat_code < 90 to check for open allocations
-- Find allocatiONs WITH tote number        
SELECT unique cntr_nbr, invn_need_type, cartON_nbr, stat_code
FROM alloc_invn_dtl
WHERE cntr_nbr in ( '99001794' )
AND stat_code < 90
AND invn_need_type = '60';


-- FInd all INT 52s AND sEND the oLPNs that are tied to the EXC totes to operatiONs
-- They will then have to sEND the list to Problem Res
-- Problem Res will then submit chASe allocatiONs 
SELECT unique cntr_nbr, carton_nbr, invn_need_type, stat_code
FROM alloc_invn_dtl
WHERE cntr_nbr in ( '99001794' )
AND stat_code < 90
AND invn_need_type = '52';

SELECT * FROM locn_hdr;
SELECT * FROM task_dtl;


-- Find tasks for iLPN/totes
SELECT task_seq_nbr, 
       cntr_nbr, 
       task_id, 
       task_genrtn_ref_nbr, 
       task_cmpl_ref_nbr,
       lh.dsp_locn as current_destination,
       lh2.dsp_locn as destination_location,
       carton_nbr, 
       item_name, 
       item_bar_code, 
       invn_need_type, 
       task_type, 
       td.stat_code, 
       td.create_date_time, 
       td.mod_date_time
FROM task_dtl td
JOIN item_cbo ic
ON td.item_id = ic.item_id
JOIN locn_hdr lh
ON td.pull_locn_id = lh.locn_id
JOIN locn_hdr lh2
ON td.dest_locn_id = lh2.locn_id
AND cntr_nbr in ( '99001989' ) 
AND stat_code < 90
ORDER BY task_seq_nbr ASC;


-- Find item that is not assigned to a tote for task
SELECT td.task_id, td.cntr_nbr, im.item_name, im.item_bar_code, td.batch_nbr, td.qty_alloc, td.stat_code, td.user_id, td.mod_date_time,
        (SELECT MAX(cntr_nbr) ||', '||MIN(cntr_nbr) 
         FROM task_dtl td2 
         WHERE td2.task_id = td.task_id 
         AND td2.cntr_nbr is not null 
         AND td2.stat_code = 40) "EXPECTED TOTE NBR"
FROM task_hdr th, task_dtl td, item_cbo im 
WHERE th.task_id = td.task_id 
AND td.item_id = im.item_id
AND th.task_type = '93' 
AND td.stat_code = 40 
AND td.invn_need_type = 3 
AND td.cntr_nbr is null;


-- Check the INTs for a certain CASE
SELECT unique cntr_nbr, invn_need_type, cartON_nbr, task_genrtn_ref_nbr, stat_code, create_date_time, mod_date_time
FROM alloc_invn_dtl
WHERE cntr_nbr in ('99032043'  )
--AND stat_code < 90
AND mod_date_time > sysdate - 2
--AND cartON_nbr = '00000197180508023581'
ORDER BY mod_date_time DESC;


-- Find the 07 task with the wave number and location
SELECT td.task_seq_nbr, td.task_id, aid.invn_need_type, aid.cntr_nbr, ic.item_name, ic.item_bar_code, td.task_genrtn_ref_nbr, ic.item_name, td.stat_code, lh.dsp_locn AS pull_locatiON, lh2.dsp_locn AS destinatiON_loactiON
FROM task_dtl td
JOIN locn_hdr lh
ON td.pull_locn_id = lh.locn_id
JOIN locn_hdr lh2
ON td.dest_locn_id = lh2.locn_id
JOIN item_cbo ic
ON td.item_id = ic.item_id
JOIN alloc_invn_dtl aid
ON td.alloc_invn_dtl_id = aid.alloc_invn_dtl_id
JOIN item_cbo ic
ON td.item_id = ic.item_id
WHERE task_id = '096017992'
-- WHERE td.task_genrtn_ref_nbr like '%202410230072%'
--WHERE lh.dsp_locn = 'PE52210C03'
AND lh.dsp_locn = 'PE21704A03'
AND td.stat_code < 90
ORDER BY task_seq_nbr;


-- Check to see if the tote(s) need to go to OSR
-- If so it needs an 6692 event message submitted
SELECT unique td.cntr_nbr, td.task_id, td.cartON_nbr, lh.dsp_locn, td.invn_need_type, td.task_type, td.stat_code, td.create_date_time, td.mod_date_time
FROM task_dtl td, locn_hdr lh
WHERE td.dest_locn_id = lh.locn_id
AND td.cntr_nbr in ( '99001989', '99035801' ) 
AND td.stat_code < 90
ORDER BY td.create_date_time DESC;


-- Get the most recent lpn
SELECT l.tc_lpn_id, ic.item_name, ic.item_bar_code, l.lASt_updated_dttm
FROM item_cbo ic, lpn l
WHERE ic.item_id = l.item_id
AND item_bar_code = '195862520992'
AND l.lASt_updated_dttm > sysdate - 1/24;


-- Check for open tasks for specified item(s)
SELECT task_id, item_name, item_bar_code
FROM task_dtl td, item_cbo ic
WHERE td.item_id = ic.item_id
AND item_name in ('1R006710 T 6M')
AND batch_nbr = 'EC002'
AND stat_code < 90;


-- Find allocations with oLPNs
SELECT unique cntr_nbr, invn_need_type, carton_nbr, stat_code
FROM alloc_invn_dtl
WHERE carton_nbr in ('00000197180545124944')
AND stat_code < 90;

    
-- Find tasks with oLPN
SELECT unique cntr_nbr, task_cmpl_ref_nbr, task_id, invn_need_type, stat_code
FROM task_dtl
WHERE cartON_nbr in ('00000197180545124944'  )
AND stat_code < 90;

SELECT tc_lpn_id, ship_wave_nbr, chase_wave_nbr FROM picking_short_item WHERE tc_lpn_id IN ('00000197180545124944');


-- Find the INTs for the oLPN
SELECT unique cntr_nbr, task_cmpl_ref_nbr, invn_need_type, stat_code, user_id
FROM task_dtl
WHERE cartON_nbr in ('00000197181313779380'  );


-- Check to see if there is any oLPNs that have uncompleted allocatiONs
SELECT cntr_nbr, cartON_nbr, task_genrtn_ref_nbr, invn_need_type, stat_code
FROM alloc_invn_dtl aid
WHERE exists (SELECT 1 FROM task_dtl td WHERE aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id)
AND stat_code < 90;


-- Check PTS cases
SELECT tc_lpn_id, lpn_facility_status, total_lpn_qty, dsp_locn 
FROM lpn lp, locn_hdr lh 
WHERE lp.curr_sub_locn_id = lh.locn_id
AND lp.lpn_facility_status < '20' AND tc_lpn_id in 
(SELECT TO_CHAR(SUBSTR(data,49,20))
FROM cl_message cl, cl_ENDpoint_queue cq
WHERE cl.msg_id = cq.msg_id
AND cl.source_id = 'WCS_PTS_CartONClose'
AND cq.status = '6')
ORDER BY dsp_locn ASc;


--Clean up PTS--
SELECT tc_lpn_id, lpn_facility_status, total_lpn_qty, dsp_locn 
FROM lpn lp, locn_hdr lh 
WHERE lp.curr_sub_locn_id = lh.locn_id
AND lp.lpn_facility_status < '20' 
AND tc_lpn_id in (SELECT TO_CHAR(SUBSTR(data,49,20))
                  FROM cl_message cl, cl_ENDpoint_queue cq
                  WHERE cl.msg_id = cq.msg_id
                  AND cl.source_id = 'WCS_PTS_CartONClose'
                  AND cq.status = '6')
ORDER BY dsp_locn ASc;


-- Needs a 6691
SELECT
--*
 DISTINCT
    ( tmm.carton_nbr )
FROM
    twcc_mhe_message tmm
WHERE
    tmm.divert = 'SCNMDL'
    AND tmm.cartON_nbr LIKE '0000%'
    AND tmm.cartON_nbr IN (
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
            tmm.cartON_nbr = e.ek_ilpn_nbr
            AND e.event_id = '6691'
    );


-- New stuff that will jackpot if it has this issue, try to catch it before it jackpots Put to store RF to allocate then 6691 to give destinations
SELECT td.task_id,
       td.cntr_nbr,
       td.task_genrtn_ref_nbr,
       td.create_date_time,
       locn_clASs,
       td.stat_code,
       lh.dsp_locn
FROM task_dtl td,
     lpn l,
     locn_hdr lh
WHERE lh.locn_id = l.curr_sub_locn_id
AND td.cntr_nbr = l.tc_lpn_id
AND td.invn_need_type = '53'
AND td.stat_code = '90'
AND l.lpn_facility_status = '30'
AND l.tc_lpn_id NOT IN (
        SELECT cntr_nbr
        FROM alloc_invn_dtl
        WHERE invn_need_type = '60'
    )
    AND td.task_genrtn_ref_nbr > '202402230030'
    AND NOT EXISTS (
        SELECT e.ek_ilpn_nbr
        FROM event_message e
        WHERE e.ek_ilpn_nbr = td.cntr_nbr
        AND e.event_id = '6691'
    )
ORDER BY
    task_genrtn_ref_nbr ASC;

select * 
from cl_message where event_id = 6333;


SELECT td.task_id, td.cntr_nbr, td.stat_code, ic.item_name, item_bar_code, lh.dsp_locn
FROM task_dtl td
JOIN item_cbo ic
ON td.item_id = ic.item_id
JOIN locn_hdr lh
ON td.pull_locn_id = lh.locn_id
JOIN locn_hdr lh2
ON td.dest_locn_id = lh2.locn_id
WHERE task_id = '96839198' 
AND stat_code < 90
ORDER BY dsp_locn;

SELECT * FROM cl_message WHERE data LIKE '%00001946540959185750%' AND when_created > sysdate - 1/24;


-- Check for USS missing message
-- Complete the task with task group PCK
-- Submit 6333 event message
WITH a AS (
    SELECT td.task_id, 
           ic.item_bar_code
    FROM task_dtl   td, task_hdr   th, item_cbo   ic
    WHERE td.task_id = th.task_id
    AND td.item_id = ic.item_id
    AND th.mod_date_time < sysdate -.01 / 24
    AND td.task_type = '16'
    AND td.invn_need_type = '50'
    AND td.stat_code = '0'
    AND th.stat_code IN ('40','30','15','13')
    AND EXISTS (
            SELECT event_id
            FROM event_message
            WHERE event_id = '6690'
        )
), b AS (
    SELECT task_id,
           task_cmpl_ref_nbr
    FROM task_dtl   td, lpn        l
    WHERE td.task_cmpl_ref_nbr = l.tc_lpn_id
    AND l.lpn_facility_status = '64'
    AND td.task_cmpl_ref_nbr LIKE '97%'
)
SELECT DISTINCT ( a.task_id ),
       b .task_cmpl_ref_nbr,
       a.item_bar_code
FROM a, b
WHERE a.task_id = b.task_id;


-- Find CASEs that do not have the same allocated quantity AS the wm allocated quantity
SELECT td.task_id, td.invn_need_type, td.stat_code, td.qty_alloc, wi.wm_allocated_qty, wi.wm_allocated_qty - ld.size_value, wi.tc_lpn_id, wi.wm_inventory_id, 
       wi.item_id, wi.batch_nbr, wi.lpn_id, wi.lpn_detail_id, ld.size_value
FROM task_dtl td, wm_inventory wi, lpn_detail ld
WHERE td.cntr_nbr = wi.tc_lpn_id
AND ld.lpn_id = wi.lpn_id
AND cntr_nbr in ('PDF0214D05')
--AND td.task_id = '75649165'
--AND td.stat_code = '40'
AND td.qty_alloc - wi.wm_allocated_qty <> 0;


-- Get the barcodes for a specific task for chutes
-- This is needed whenever the chute closer is having issues closing out the chute
-- Use the PCK task group when completing the task
SELECT task_seq_nbr, task_id, item_name, item_bar_code, lh.dsp_locn
FROM task_dtl td, item_cbo ic, locn_hdr lh
WHERE td.item_id = ic.item_id
AND td.pull_locn_id = lh.locn_id
AND td.stat_code < 90
AND task_id = '94398676'
ORDER BY task_seq_nbr;


-- Find a iLPN based off of the item barcode
SELECT *
FROM item_cbo ic, lpn l
WHERE ic.item_id = l.item_id 
AND item_bar_code = '197347082070' 
AND tc_lpn_id like '0000197%';

    
-- Find the tasks associated with the the specific wave number
SELECT unique (cntr_nbr), invn_need_type, task_id, stat_code
FROM task_dtl
WHERE task_genrtn_ref_nbr = '202421080038' -- Change depENDing ON your problem wave
--AND task_type = '93'
AND stat_code < '90';
select * from event_message where ek_ilpn_nbr = '970902500336';

-- Check to see if the task was split into several totes
SELECT td.task_id,
       aid.cntr_nbr,
       aid.invn_need_type,
       aid.stat_code,
       td.stat_code,
       aid.qty_alloc,
       aid.qty_pulld
FROM alloc_invn_dtl aid
INNER JOIN task_dtl td
ON aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id
WHERE task_id = '';


-- Find task from item and locatiON
SELECT t.task_id, t.cntr_nbr, t.batch_nbr, t.invn_need_type, t.task_genrtn_ref_nbr, t.task_cmpl_ref_nbr, t.stat_code, l.locn_brcd, i.item_name, i.DESCriptiON
FROM task_dtl t, locn_hdr l, item_cbo i
WHERE t.dest_locn_id = l.locn_id
AND t.item_id = i.item_id
AND l.dsp_locn = 'PDF0214D05'
-- AND i.item_name = '2O934710 IVY 2T'
AND  stat_code < 90;


select * from locn_hdr where dsp_locn = 'PDF0214D05';
select * from wm_inventory where location_id = '100337474';
select * from item_cbo where item_id = '3415013';

-- Find the open allocation with a specific locatiON AND item
SELECT aid.cntr_nbr, aid.invn_need_type, aid.task_genrtn_ref_code, aid.task_cmpl_ref_code, i.item_name, lh.dsp_locn, lh.create_date_time
FROM alloc_invn_dtl aid, locn_hdr lh, item_cbo i
WHERE aid.pull_locn_id = lh.locn_id
AND aid.item_id = i.item_id
AND lh.dsp_locn in ('PDF0214D05')
--AND item_name = '1P291710 ASST 18M'
AND stat_code < 90;

-------------------------------------------------------------------------------------------------------------------------------- Locations ----------------------------------------------------------------------------------------------------------------------------------------    

ALTER SESSION SET current_schema = DM;

SELECT * FROM locn_hdr;
SELECT * FROM lpn;
SELECT * FROM alloc_invn_dtl;


SELECT * FROM int_path_defn WHERE nxt_work_area = 'PSG1' ORDER BY create_date_time DESC;

SELECT * FROM int_path_defn WHERE invn_need_type = '2' ORDER BY create_date_time DESC;


-- Check location TBF quantity
SELECT lh.dsp_locn, 
       ic.item_name, 
       ic.DESCriptiON, 
       wi.tc_lpn_id, 
       wi.ON_hAND_qty, 
       wi.wm_allocated_qty, 
       wi.to_be_filled_qty
FROM locn_hdr lh
INNER JOIN wm_inventory wi
ON lh.locn_id = wi.locatiON_id
INNER JOIN item_cbo ic
ON wi.item_id = ic.item_id
WHERE dsp_locn = 'PDF0205B02';


-- Pick locations 
SELECT locn_brcd, dsp_locn, locn_pick_seq, lASt_frozn_date_time, lASt_cnt_date_time, cycle_cnt_pENDing, prt_label_flag, user_id
FROM locn_hdr
WHERE locn_brcd in ('PDF0205B02?', 'PDF0205B02?');


-- Resevere locations
SELECT locn_id, locn_brcd, dsp_locn, locn_pick_seq, lASt_frozn_date_time, lASt_cnt_date_time, cycle_cnt_pENDing, prt_label_flag, user_id
FROM locn_hdr
WHERE LOCN_BRCD between 'RPT5910A01?' AND 'RPT5958B03?';


-- Get the list of locations with quantity inside of them
SELECT distinct dsp_locn
FROM locn_hdr lh 
INNER JOIN wm_inventory wi
ON lh.locn_id = wi.locatiON_id
WHERE locn_brcd between 'RPT1715A01?' AND 'RPT1715A01?'
ORDER BY 1;


-- Check if the DF location has a DP lock on it
-- If not, then assign the following item that was provied in the email, if not then ask Wave Plan or IC for that item
-- Then lock the location with the Pick Locatins UI, lock name is: Dynamic Pick Lock
SELECT lh.dsp_locn, item_id, pikng_lock_code
FROM pick_locn_dtl pld,
     locn_hdr lh
WHERE pld .locn_id = lh.locn_id
AND dsp_locn = 'PDF0205D02';

-- Item ID for the DF location
SELECT * FROM item_cbo WHERE item_id = '3416465';


-- Checks tasks within a location. 
-- If you're rebuilding a location(s) the process is the same: check for any tasks, complete the tasks then rebuild the location.
SELECT t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.lASt_cnt_date_time, l.user_id
FROM task_dtl t, locn_hdr l
WHERE t.pull_locn_id = l.locn_id
AND l.dsp_locn in ('PDF0205B02'  )
AND t.stat_code < 90;


-- -- Check to see which locatoin has a task, with a specific item
SELECT t.task_id, t.cntr_nbr, t.task_cmpl_ref_nbr, t.task_genrtn_ref_nbr, i.item_name, t.batch_nbr, t.invn_need_type, t.stat_code, l.locn_brcd, l.dsp_locn, l.lASt_cnt_date_time, l.user_id
FROM task_dtl t, locn_hdr l, item_cbo i
WHERE t.pull_locn_id = l.locn_id
AND t.item_id = i.item_id
AND l.dsp_locn in ('PE21406C01'  )
AND i.item_name = '1R006710 T 6M'
AND t.stat_code < 90;


-- Find the orders, tasks, and item associated with the truck number
SELECT p.tran_type, p.tran_code, p.tran_nbr, p.cntr_nbr, p.nbr_of_CASEs, p.nbr_units, o.tc_order_id, o.order_status, t.task_id, i.item_name, i.DESCriptiON
FROM prod_trkg_tran p, orders o, task_dtl t, item_cbo i
WHERE o.tc_order_id = p.tc_order_id
AND t.task_id = p.task_id
AND i.item_id = p.item_id;


-- Find the lpn assocaited with location and item 
SELECT l.tc_lpn_id, l.lpn_status, l.lpn_facility_status, i.item_name, lh.dsp_locn, l.lpn_status_updated_dttm, lh.create_date_time, lh.lASt_frozn_date_time, lh.lASt_cnt_date_time,
       CASE WHEN l.lpn_facility_status = '96' then 'iLPN cONSUMed to Active' ELSE 'Other' END AS lpn_DESCriptiON,
       lfs.inbound_outbound_indicator
FROM locn_hdr lh, lpn l, item_cbo i, lpn_facility_status lfs
WHERE lh.locn_id = l.curr_sub_locn_id
AND l.item_id = i.item_id
AND l.lpn_facility_status = lfs.lpn_facility_status
AND lh.dsp_locn in ('PDF0205B02')
ORDER BY lpn_status_updated_dttm DESC;
--AND i.item_name = '3P441010 GY 5';

-------------------------------------------------------------------------------------------------------------------------------- LPNS & Items ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

SELECT * FROM lpn;
SELECT * FROM lpn_detail;
SELECT * FROM lpn_facility_status;
SELECT * FROM item_cbo;


-- Get ASNs for the following iLPNs
SELECT l.tc_lpn_id, a.tc_ASn_id
FROM lpn l, ASn a
WHERE l.tc_ASn_id = a.tc_ASn_id
AND l.tc_lpn_id in ('00006644541894037692', '00006644541894042597', '00006644541894042580', '00006644541894041448', '00006644541894041828', '00006644541894037692');


-- Find the allocations for the lpn associated with the specified wave
SELECT aid.cntr_nbr, aid.invn_need_type, aid.stat_code, l.tc_lpn_id, l.lpn_facility_status, l.lpn_status, aid.batch_nbr, w.wave_nbr
FROM alloc_invn_dtl aid, lpn l, wave_parm w
WHERE aid.task_cmpl_ref_nbr = l.tc_lpn_id
AND l.wave_nbr = w.wave_nbr
AND aid.cntr_nbr is not null;


-- Find the lpn status based on the item
SELECT l.lpn_id, l.tc_lpn_id, l.tc_reference_lpn_id, l.lpn_facility_status, ls.inbound_outbound_indicator, ls.DESCriptiON, i.item_name
FROM lpn l, lpn_facility_status ls, item_cbo i
WHERE l.lpn_facility_status = ls.lpn_facility_status
AND l.item_id = i.item_id
AND i.item_name in ('1P651810 DM 6M')
ORDER BY i.item_name ASc;


-- Check the date of LPN that ops is trying to manifest
SELECT sched_ship_dttm FROM lpn WHERE tc_lpn_id = '00000197180351349548';


-- Check the size of the container and make sure that it is getting deiverted to its destination
SELECT l.tc_lpn_id, l.cONtainer_size, m.mod_date_time, m.divert, m.weight
FROM lpn l, twcc_mhe_message m
WHERE l.tc_lpn_id = m.cartON_nbr
AND cONtainer_size between 'HC4' AND 'HC8'
AND divert = 'SCNMDL'
ORDER BY m.mod_date_time DESC;


-- Find item assocaited with the iLPN
SELECT cntr_nbr, cartON_nbr, item_name, item_bar_code, reqd_batch_nbr
FROM alloc_invn_dtl aid, item_cbo i
WHERE aid.item_id = i.item_id
AND cntr_nbr in ('00000197180356072991')
AND stat_code < 90;
    

-- How to check if tote is still on the floor
SELECT distinct(aid.cartON_nbr), aid.cntr_nbr, aid.BATCH_NBR, l.chute_id, ic.item_bar_code, ic.item_name, aid.qty_alloc, aid.stat_code, lfs.DESCriptiON
FROM item_cbo ic, alloc_invn_dtl aid, lpn l, lpn_facility_status lfs
WHERE aid.item_id = ic.item_id 
AND aid.cartON_nbr = l.tc_lpn_id
AND l.inbound_outbound_indicator = lfs.inbound_outbound_indicator 
AND l.lpn_facility_status = lfs.lpn_facility_status
AND aid.cntr_nbr in ('99022746')
AND aid.stat_code < '90'
ORDER BY aid.cartON_nbr ASc;
    
    
-- Finding item barcodes for units in allocated ilpns/olpns
SELECT IC.ITEM_ID, IC.ITEM_NAME, IC.DESCRIPTION, IC.ITEM_BAR_CODE, AID.CARTON_NBR, AID.CNTR_NBR, AID.BATCH_NBR, AID.STAT_CODE
FROM ITEM_CBO IC, ALLOC_INVN_DTL AID
WHERE IC.ITEM_ID = AID.ITEM_ID
AND AID.STAT_CODE < '90'
AND AID.CARTON_NBR = '00000197180356072991';
    
    
-- Error labels during routing
SELECT l.tc_lpn_id, 
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
       o.pickup_END_dttm,
       o.delivery_start_dttm,
       o.delivery_END_dttm,
       o.order_date_dttm
FROM lpn l, orders o
WHERE o.tc_order_id = l.tc_order_id
-- AND d_address_1 like '%%'
-- AND wave_nbr = ''
-- AND o.tc_order_id in (  )
AND d_city = 'APO'
AND l.lpn_facility_status < 90
AND o.ref_field_3 = 'EC';
-- snd tc_lpn_id = ''
-- AND ship_via = 'CALL'
-- AND d_address_1 in (  );

-------------------------------------------------------------------------------------------------------------------------------- Waves ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

SELECT * FROM wave_task_crit;
SELECT * FROM wave_queue;
SELECT * FROM wave_parm;
SELECT * FROM arch_wave_parm;
SELECT * FROM lpn;
SELECT * FROM item_cbo;


-- Check the MHE Flag for OSR waves, if the MHE flag is set to 'Y' then run sys code "MHE-FLAG" to set it to 'N'
SELECT wave_nbr, wave_DESC, mhe_flag FROM wave_parm WHERE wave_nbr in ('202501260066');


-- Checks to see who relesaed the wave
SELECT * FROM event_message
WHERE ek_wave_nbr = '202506220036'
--AND user_id = 'yangj'
--WHERE ek_ilpn_nbr = '00000197180104880649'
ORDER BY mod_date_time DESC;

SELECT * FROM wm_inventory WHERE location_id = '100337474';

select * from alloc_invn_dtl where task_genrtn_ref_nbr = '202504220030' order by stat_code asc;


-- Check history for released waves
SELECT * FROM event_message_history
WHERE ek_wave_nbr = '202504240070'
ORDER BY mod_date_time DESC;


-- Find tasks for Waves on the sorter
SELECT unique cntr_nbr, task_id, cartON_nbr, invn_need_type, task_type, stat_code, task_genrtn_ref_nbr, create_date_time, mod_date_time
FROM task_dtl 
WHERE task_genrtn_ref_nbr LIKE '202501240044%' 
AND stat_code < 90
ORDER BY create_date_time DESC;


SELECT task_id, task_type, stat_code, user_id, create_date_time, mod_date_time 
FROM task_dtl 
WHERE task_genrtn_ref_nbr like '202501260066%' 
AND stat_code < 90
ORDER BY mod_date_time DESC;

SELECT COUNT(*) number_of_tasks, stat_code, task_type 
FROM task_dtl 
WHERE task_genrtn_ref_nbr = '202501240044' 
GROUP BY stat_code, task_type;

SELECT * FROM task_hdr WHERE task_genrtn_ref_nbr = '202501260065';

SELECT * FROM task_dtl WHERE task_id = '86818484';

SELECT * FROM wave_parm WHERE wave_nbr = '202501260065';
SELECT COUNT(*), stat_code FROM task_dtl WHERE task_genrtn_ref_nbr = '202501260065' GROUP BY stat_code;


-- Find the chase wave that is tied to the oLPN(s), if NULL then have ops call a chase wave
SELECT tc_lpn_id, tc_order_id, ship_wave_nbr, chASe_wave_nbr, stat_code, created_dttm, lASt_updated_dttm
FROM picking_short_item
WHERE tc_lpn_id = '00000197180539291805';


-- Get the item name for the oLPNs located on the chase wall
SELECT psi.tc_lpn_id,
       psi.tc_order_id,
       ic.item_name,
       ic.item_bar_code,
       psi.ship_wave_nbr,
       psi.chase_wave_nbr
FROM picking_short_item psi
JOIN item_cbo ic
ON psi.item_id = ic.item_id
WHERE tc_lpn_id IN ('00000197180539291805');

-------------------------------------------------------------------------------------------------------------------------------- Orders ----------------------------------------------------------------------------------------------------------------------------------------                                

ALTER SESSION SET current_schema = DM;

SELECT * FROM orders;
SELECT * FROM order_line_item;
SELECT * FROM lpn;
SELECT * FROM tran_log;
SELECT * FROM tran_log_message;
SELECT * FROM lpn_facility_status;
SELECT * FROM lpn_status;

SELECT order_id, tc_order_id, do_status
FROM orders
WHERE tc_order_id = 'JCAR109641083_1';

SELECT * FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = 'ORDERS' AND COLUMN_NAME LIKE '%STATUS%' AND OWNER = 'DM';


-- Check the latest orders bridging in
SELECT o.last_updated_dttm, o.* FROM orders o ORDER BY o.last_updated_dttm DESC;


-- Find the company name for a certain LPN, amd place it in the "Contact" input box
SELECT l.tc_lpn_id, o.bill_to_name
FROM orders o, lpn l
WHERE o.tc_order_id = l.tc_order_id
AND tc_lpn_id = '00000197180524279429';


-- Retrieve the orders
SELECT unique o.tc_order_id, o.ext_purchASe_order, l.tc_lpn_id, l.lpn_status, lfs.DESCriptiON, l.lpn_status_updated_dttm, l.created_dttm, l.lASt_updated_dttm
FROM orders o, lpn l, lpn_facility_status lfs
WHERE o.order_id = l.order_id
AND l.lpn_status = lfs.lpn_facility_status
AND o.ext_purchase_order in ('JCAR91997307');


-- Find order with lpn
SELECT o.order_id, o.tc_order_id, l.tc_lpn_id, l.lpn_facility_status
FROM lpn l, orders o
WHERE l.tc_order_id = o.tc_order_id
AND l.tc_lpn_id = '00000197180484378019';


-- Check if the order came through with any errors or not.
SELECT * FROM tran_log tl, tran_log_message tlm
WHERE tlm.tran_log_id = tl.tran_log_id
AND msg_type = 'DistributionOrder'
AND TL.CREATED_DTTM between '11-JUN-23' AND '18-JUN-23'
AND msg_line_text like '%1216262316%';
    

-- Determine weather the LPNs are BOSS orders or not
-- If the DC_CTR_NBR column is NULL then it is not a BOSS order, if it is not null, then the column will have the retail store number
-- If the O_PHONE_NUMBER column hAS the letter "B" then the order needs to be cONsolidated, if not then it needs to be loaded ONto the truck to be shipped to the customer's chosen retail store
SELECT l.lpn_id, tc_lpn_id, o.tc_order_id, dc_ctr_nbr, o_phONe_number, w.wave_nbr, COUNT(*) over() AS lpns
FROM orders o, lpn l, wave_parm w
WHERE o.tc_order_id = l.tc_order_id
AND l.wave_nbr = l.wave_nbr
--AND l.tc_lpn_id in ('')
AND o_phONe_number = 'B';
--AND w.wave_nbr = '202304290054'
--AND w.create_date_time > sysdate - 2;
--AND l.inbound_outbound_indicator = 'O';


-- (STS)-Ship to Store
-- Checks to see if STS is ON for all stores
SELECT * FROM facility f, facility_aliAS fa
WHERE f.facility_id = fa.facility_id
AND SUBSTR(fa.facility_aliAS_id,1,6) = '249380'
AND f.ship_to_store = 0;


-- Checks to see if STS is OFF for all stores
SELECT * FROM facility f, facility_aliAS fa
WHERE f.facility_id = fa.facility_id
AND SUBSTR(fa.facility_aliAS_id,1,6) = '249380'
AND f.ship_to_store = 1;


-- Cancel order(s) that are in pre-releASed status
SELECT * FROM error_log WHERE order_id = '149217481';
delete FROM error_log WHERE order_id = '149217481';


-- Update the order to releASed status
SELECT * FROM orders WHERE tc_order_id = '1222318803';
update orders set do_status = '110' WHERE tc_order_id = '1222318803';;
SELECT * FROM order_line_item WHERE order_id = '149217481';
update order_line_item set do_dtl_status = '110' WHERE order_id = '149217481' AND do_dtl_status = '105';


-- Find all ordes that are tied to the totes
SELECT aid.cntr_nbr, aid.cartON_nbr, aid.task_genrtn_ref_nbr, o.tc_order_id, aid.invn_need_type, aid.stat_code
FROM alloc_invn_dtl aid INNER JOIN orders o
ON aid.tc_order_id = o.tc_order_id
WHERE cntr_nbr in ('970077760710','970077760709','970077760705','970077760706','970077760708','970077760707','970077760711')
AND stat_code < 90;


-- Check weight
SELECT ord.tc_order_id, oli.created_dttm, ic.item_name, oli.unit_vol, oli.unit_wt 
FROM order_line_item oli, orders ord, item_cbo ic 
WHERE oli.ITEM_NAME in ('1Q539210 P 18M')
--oli.item_id = '3101608'
AND ord.order_id = oli.order_id
AND ic.item_id = oli.item_id
--AND wave_nbr = '202210260002'
AND oli.is_chASe_created_line is null
ORDER BY oli.created_dttm DESC;


--
SELECT l.tc_lpn_id, l.lpn_facility_status, o.tc_order_id, l.tracking_nbr, l.ship_via, o.lane_name, o.ref_field_3, o.pickup_END_dttm, o.delivery_END_dttm, o.delivery_start_dttm
FROM lpn l, orders o
WHERE l.tc_order_id = o.tc_order_id
-- AND d_address_1 like '%%'
-- AND wave_nbr = ''
AND l.tc_lpn_id in ('00000197180484378019')
AND o.tc_order_id in ('CAR103459782_2')
-- AND d_state_prov = ''
-- AND d_city = ''
-- AND l.lpn_facility_status < 90
AND o.ref_field_3 = 'EC';

-------------------------------------------------------------------------------------------------------------------------------- Shipments ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

SELECT * FROM shipment;
SELECT * FROM twcc_mhe_message;

-- Manifest
-- THIS SHOULD RETURN ANY OLPNS THAT COULD BE PROBLEMATIC 
SELECT * FROM lpn lp, shipment sh 
WHERE sh.tc_shipment_id = lp.tc_shipment_id 
AND sh.shipment_status = '120' 
AND lp.lpn_facility_status = '40';
    
    
-- Check the weight of the boxes 
-- '******' means invalid weight meaning that the box will not recieve a destination
SELECT * FROM twcc_mhe_message 
WHERE divert = 'SCNSHIP'
ORDER BY mod_date_time DESC;

    
-- Enter in the oLPN that is giving the ship date error
SELECT tc_lpn_id, SCHED_SHIP_DTTM FROM lpn
WHERE tc_lpn_id = ''; -- Enter the olpn 
    

-- Updates the row to the current date added by ONe
update lpn
set sced_ship_dttm = to_date(sysdate) + 1
WHERE tc_lpn_id = ''; -- Enter the olpn
    
    
-- CONfirm that the shipments have been shipped, if the results come back empty, then you will need to ship cONfirm using the Ship CONfirmm Rules UI.
SELECT * FROM outpt_lpn
WHERE tc_shipment_id in ('CS85018005');
    
    
-- Checks for oLPNs that were shipped
SELECT tc_order_id, tc_lpn_id, lpn_facility_status, bol_nbr, ship_via 
FROM lpn 
WHERE tc_shipment_id = 'CS85018005' 
AND lpn_facility_status < 90;
    

-- Check the number of oLPNs that are in packed ststus FROM a shipment
SELECT COUNT(*) Number_of_LPNs FROM lpn 
WHERE tc_shipment_id = 'CS85018005'
AND lpn_facility_status = '30';


-- Find lpns that are not in Shipped status
SELECT tc_lpn_id, tc_order_id, lpn_facility_status FROM lpn 
WHERE manifest_nbr = 'UPS000050095' 
AND lpn_facility_status <> 90;


-- STS - Ship to Store
-- Checks to see if STS is on for all stores
SELECT * FROM facility f, facility_aliAS fa
WHERE f.facility_id = fa.facility_id
AND SUBSTR(fa.facility_aliAS_id, 1, 6) = '249380'
AND f.ship_to_store = 0;
    
    
-- Check to see if STS is off for all stores
SELECT * FROM facility f, facility_aliAS fa
WHERE f.facility_id = fa.facility_id
AND SUBSTR(fa.facility_aliAS_id, 1, 6) = '249380'
AND f.ship_to_store = 1;


-- Check the status of the appointment  
SELECT appointment_id, facility_id, appt_status FROM ilm_appointments 
WHERE tc_appointment_id = '101358626';
    

-- 80 stat code = delivered, 120 stat code = cancelled, 60 stat code = accepted, 20 stat code = available
SELECT * FROM shipment 
WHERE shipment_status = '60'
ORDER BY delivery_END_dttm DESC;


-- Appointments
SELECT * FROM ILM_APPT_DOCKS;
SELECT * FROM ILM_APPT_EQUIPMENTS;
SELECT * FROM ILM_APPT_SLOTS;
SELECT * FROM ILM_APPT_SLOT_UTILIZATION;


-- Find the status of the shipment tied to an lpn
SELECT l.tc_parent_lpn_id, s.tc_shipment_id, s.shipment_status, s.delivery_END_dttm
FROM shipment s, lpn l 
WHERE s.shipment_id = l.tc_shipment_id
AND s.shipment_status = '50'
ORDER BY s.delivery_END_dttm DESC;


-- update lpn set shipment_id = 2640240, tc_shipment_id = 'CS03607725' WHERE tc_lpn_id = '00000197181246626102';
    

-- FIND THE STATIC ROUTE BY CARTON NUMBER
SELECT l.tc_lpn_id, l.tc_parent_lpn_id, o.assigned_static_route_id, o.dsg_static_route_id, l.static_route_id, l.route_rule_id, l.shipment_id, l.tc_shipment_id, l.tracking_nbr, o.d_facility_aliAS_id, l.wave_nbr
FROM orders o, lpn l
WHERE o.tc_order_id = l.tc_order_id
AND tc_lpn_id in ('00000197181312762529' )
ORDER BY o.ASsigned_static_route_id;

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'LPN' AND COLUMN_NAME LIKE '%ROUTE%' AND OWNER = 'DM';
SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME = 'ORDERS' AND COLUMN_NAME LIKE '%ROUTE%' AND OWNER = 'DM';

-- LPNs WITH getting error during Routing
SELECT tc_lpn_id, wave_nbr, lpn_facility_status, created_source, lASt_updated_source, created_dttm, lASt_updated_dttm
FROM lpn
WHERE tc_lpn_id in ('00000197180484378019'  );

-------------------------------------------------------------------------------------------------------------------------------- MHEs & Messages ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;


SELECT * FROM cl_message;
SELECT * FROM msg_log;
SELECT * FROM event_message;
SELECT * FROM cl_endpoint_queue;
SELECT * FROM twcc_mhe_message;
SELECT * FROM twcc_tote_audit;
SELECT * FROM dmmsf.sys_code;
SELECT * FROM twcc_uss_wave_download;


SELECT * 
FROM dmmsf.sys_code
WHERE code_type = 'PLN'
AND to_char(substr(code_id, 1, 4)) = '2025';


-- Check DF Transactions
SELECT * FROM prod_trkg_tran ptt, locn_hdr lh
WHERE ptt.from_locn = lh.locn_id
AND dsp_locn LIKE '%PDF02%%'
AND ptt.mod_date_time > sysdate - 3/24;


-- Check DF picking by floor
SELECT ptt.wave_nbr,
       ptt.create_date_time,
       ptt.module_name,
       ptt.mod_date_time,
       ptt.user_id
FROM prod_trkg_tran ptt, locn_hdr lh
WHERE ptt.from_locn = lh.locn_id
AND lh.dsp_locn LIKE '%PDF03%%'
AND ptt.mod_date_time > sysdate - 3/24
ORDER BY mod_date_time DESC;


SELECT REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS oLPN,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 5) AS carton_status,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS wave,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) AS qty,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) AS location,
       CASE WHEN ceq.status = 2 THEN 'Ready'
            WHEN ceq.status = 5 THEN 'Success'
            WHEN ceq.status = 6 THEN 'Fail'
            ELSE 'Busy'
       END AS status_description,
       ceq.status,
       ceq.when_queued
FROM cl_endpoint_queue ceq
JOIN cl_endpoint ce
ON ceq.endpoint_id = ce.endpoint_id
JOIN cl_message cm
ON ceq.msg_id = cm.msg_id
WHERE cm.source_id = 'WCS_PTS_CartonClose'
AND ceq.when_queued > sysdate - 7/24
ORDER BY when_queued DESC;


-- Check the weight for each box
-- '*****' means invalid weight 
SELECT * FROM twcc_mhe_message 
WHERE divert = 'SCNMDL'
--AND weight like '%******%'
ORDER BY mod_date_time DESC;


-- Will have records for each oLPN getting routing
SELECT SUBSTR(msg, 1, 20) AS olpn,
       mg.* 
FROM MSG_LOG mg 
WHERE module = 'LOGISTYX'
ORDER BY log_date_time DESC;


SELECT * FROM msg_log WHERE msg like '%00000197181307664111%';
SELECT * FROM cl_message;
SELECT * FROM twcc_mhe_message;


-- Check the wave for all iLPNs located in Wavebank
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 5
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) = '970902501506'
AND cm.source_id = 'USS_INDUCT_MODE'
ORDER BY WHEN_queued DESC;


-- Check the wave for all iLPNs located in Wavebank
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 3
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) = '970902509916'
AND cm.source_id = 'WCS_USS_IND_CONSUMED'
ORDER BY WHEN_queued DESC;


-- Check the wave for all iLPNs located in Wavebank
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 2
AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) = '970902500336'
AND cm.source_id = 'WCS_USS_PS_DIVERTED'
ORDER BY WHEN_queued DESC;


-- Check the wave for all iLPNs located in Wavebank
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 1/24
AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) = '970902500336'
AND cm.source_id = 'WCS_SCANNERS'
ORDER BY WHEN_queued DESC;


-- Check the wave for all iLPNs located in Wavebank
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 1/24
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) = '00006644541785144362'
AND cm.source_id = 'SDI_WB_DIVERTCONFIRM'
ORDER BY WHEN_queued DESC;


-- Check the status for all oLPNs located in Mantissa
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
       END AS status,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 1) AS Message_Number,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS oLPN,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 6) AS weight,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS scanner,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS user_id,
       WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
WHERE cm.source_id = 'MANTISSA_INBOUND_WEIGHT'
--AND WHEN_queued > sysdate - 1/24
ORDER BY WHEN_queued DESC;


-- Check the status for all iLPNs located in PTS
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) AS oLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 8) AS locatiON,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) AS puts,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 1
AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) = '00000197181307664111'
AND cm.source_id = 'WCS_PTS_PickCONfirm'
ORDER BY when_queued DESC;


-- 
SELECT REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS oLPN,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 5) AS carton_status,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS wave,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) AS qty,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) AS location,
       CASE WHEN ceq.status = 2 THEN 'Ready'
            WHEN ceq.status = 5 THEN 'Success'
            WHEN ceq.status = 6 THEN 'Fail'
            ELSE 'Busy'
       END AS status_description,
       ceq.status,
       ceq.when_queued
FROM cl_endpoint_queue ceq
JOIN cl_endpoint ce
ON ceq.endpoint_id = ce.endpoint_id
JOIN cl_message cm
ON ceq.msg_id = cm.msg_id
WHERE cm.source_id = 'WCS_PTS_CartonClose'
AND ceq.when_queued > sysdate - 7/24
ORDER BY when_queued DESC;


-- Check the status for all iLPNs located in PTS
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) AS oLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 8) AS locatiON,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) AS puts,
        when_queued
FROM cl_endpoint ce
INNER JOIN cl_ENDpoint_queue clq ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 1
AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) = '970902500336'
AND cm.source_id = 'WCS_USorter_ToteChute'
ORDER BY WHEN_queued DESC;


-- olPNs still in 'Packed' status after being scanned by SCNSHIP
SELECT *
FROM twcc_mhe_message tmm
JOIN lpn l ON tmm.cartON_nbr = l.tc_lpn_id
JOIN orders o ON l.tc_order_id = o.tc_order_id
LEFT JOIN lpn_lock ll ON l.lpn_id = ll.lpn_id
JOIN cl_message cm ON tmm.msg_id = cm.msg_id
WHERE tmm.msg_id = cm.msg_id
AND tmm.source_id = 'WCS_R/S_Scanned'
AND tmm.divert = 'SCNSHIP'
AND l.lpn_facility_status = '20'
AND l.inbound_outbound_indicator = 'O'
--AND o.lane_name = 'BOSS'
--AND l.tracking_nbr like '%1LS%'  --LASerShip
AND tmm.weight like '%*****%'
--AND tmm.create_date_time between to_timestamp('05/15/2023' 18:30:00', 'MM/DD/YYYY HH24:MI:SS') AND to_timestamp('05/15/2023' 04:30:00', 'MM/DD/YYYY HH24:MI:SS')
AND tmm.create_date_time > '17-FEB-24 06.30.00.000000000 PM'
ORDER BY create_date_time DESC;


-- Totes That Failed To Enter OSR And Not Consumed
SELECT to_char(SUBSTR(data,49,8)) AS totes, cl.msg_id, source_id, when_created
FROM cl_message cl, cl_endpoint_queue cq 
WHERE cl.msg_id = cq.msg_id 
AND cl.when_created > sysdate - 7 
AND source_id = 'OSR_CONTAINERSTATUSGTPCONSUMED' 
AND status = '6' 
AND to_char(SUBSTR(data,49,8)) in (SELECT tc_lpn_Id FROM lpn WHERE lpn_facility_status < '90') 
AND when_created > (SELECT MAX(create_date_time) FROM alloc_invn_dtl WHERE cntr_nbr = TO_CHAR(SUBSTR(data,49,8))) 
ORDER BY when_created DESC;


-- Check the status of the wave, if status is 5 then the event message for SDI wAS sent out successfully, if not then there is a cONnectiON issue.
SELECT cl.msg_id, cl.event_id, cl.WHEN_created, eq.WHEN_status_changed, cl.data, eq.status
FROM cl_message cl, cl_ENDpoint_queue eq
WHERE cl.msg_id = eq.msg_id
AND cl.event_id like '%7029%'
AND cl.data like '%202306230040%'
AND cl.when_created > sysdate - 2
ORDER BY cl.when_created DESC;


-- Check the wave for all iLPNs located in OSR
SELECT TO_CHAR(clq.msg_id) AS msg_id,
       ce.name,
       clq.status AS status_number,
       CASE WHEN clq.status = '5' then 'Succeed'
            WHEN clq.status = '6' then 'Failed'
            WHEN clq.status = '2' then 'Ready'
            WHEN clq.status = '10' then 'Busy'
            ELSE 'Other'
        END AS status,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) AS iLPN,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) AS wave,
        REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) AS task_sequeance_number,
        WHEN_queued
FROM cl_ENDpoint ce
INNER JOIN cl_ENDpoint_queue clq 
ON ce.ENDpoint_id = clq.ENDpoint_id
INNER JOIN cl_message cm         
ON clq.msg_id = cm.msg_id
--WHERE WHEN_queued between '13-JAN-24 06.30.00.000000000 PM' AND '15-JAN-24 04.30.00.000000000 AM'
WHERE WHEN_queued >= sysdate - 10/24
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) = '99049296'
AND cm.source_id = 'GTPPICKCONFIRM'
ORDER BY WHEN_queued DESC;


-- Find 6692 messages for transport orders
SELECT msg_id,
       event_id,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 12) AS TOTE,       
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 13) AS QTY,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 8) AS ITEM,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) AS ITEM_BARCODE,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) AS LOT_CODE,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 16) AS VOLUME,
       WHEN_created
FROM cl_message
WHERE REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 12) in ('99034559')
AND WHEN_created > sysdate - 5
AND event_id = '6692';


--CHUTE
---Finding failing messages
SELECT TO_CHAR(cleq.msg_id) msg_id,
       WHEN_queued,
       DECODE(cleq.status, '5', 'Succeed', '6', 'Failed','10', 'Busy', '2', 'Ready') AS status,cleq.status,
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 4) "WAVE",
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 6) "task1",
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 7) "task",
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) "CHUTE",
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) "iLPN",
--       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 11) ,
--       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 12),
       REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 14) "User",
       cm.source_id
FROM cl_ENDpoint cle,
     cl_ENDpoint_queue cleq,
     cl_message cm
--    ,lpn l
WHERE cle.ENDpoint_id = cleq.ENDpoint_id
AND cleq.msg_id = cm.msg_id
AND cm.source_id = 'WCS_USorter_ToteChute'
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 10) like '%970906715469%' -----change tote
--AND REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 14) in('308501') ---change User name 
--AND cleq.status in('6','10','2')
AND cm.WHEN_created > SYSDATE -  1/24 -------change time interval
--AND   REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9)   in ('3U56','3L56')
--AND  REGEXP_SUBSTR(TO_CHAR(data), '[^/^]+', 1, 9) like '3%'
--AND l.lpn_facility_status = '50'
--AND cm.source_id = '9001_9002_User_Interface' 
ORDER BY WHEN_queued DESC;


-- MHE messages for OSR/461
-- Search for transport orders
select eq.msg_id,
       regexp_substr(to_char(m.data), '[^/^]+', 1, 8) as item
from cl_endpoint_queue eq, cl_message m
where m.msg_id = eq.msg_id
and eq.when_queued > sysdate - 4
and eq.endpoint_id = '461'
and eq.status = '5'
-- and regexp_substr(to_char(m.data), '[^/^]+', 1, 6) like '%990432%'
and m.data like '%99006691%'
-- and source_id = '6692_CC_INT9'
order by eq.when_status_changed desc;


-- EXC Totes
select *
from lpn l, 
     lpn_detail ld, 
     item_cbo ic, 
     locn_hdr lh,
     wm_inventory wi,
     lpn_facility_status lfs
where l.lpn_id = ld.lpn_id
and ic.item_id = ld.item_id
and ld.item_id = wi.item_id
and wi.location_id = lh.locn_id
and ld.batch_nbr = wi.batch_nbr
and l.lpn_facility_status = lfs.lpn_facility_status
-- and l.tc_lpn_id = aid.cntr_nbr
-- and aid.alloc_invn_dtl_id = td.alloc_invn_dtl_id
and l.lpn_facility_status in ('48', '50', '64')
and lfs.inbound_outbound_indicator = 'I';



-- 
SELECT DISTINCT ( td.task_id ) 
FROM task_dtl td, task_hdr th 
WHERE td.task_id = th.task_id 
AND td.invn_need_type = '50' 
AND td.task_type = '16' 
AND td.stat_code NOT IN ( '90', '99' ) 
AND th.stat_code <> '10' 
ORDER BY task_id DESC ;

-------------------------------------------------------------------------------------------------------------------------------- CCFs, DB Locks & sessions ----------------------------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET current_schema = DM;

-- Check database history
SELECT * FROM SYS.DBA_HIST_IC_DEVICE_STATS;


-- Ecom Backlot
WITH 
a AS(SELECT TRIM(TO_CHAR(SUM(order_qty), '999,999,999')) AS prereleASed FROM orders o, order_line_item oli WHERE o.order_id = oli.order_id AND order_type = 'EC' AND do_status < '110'),
b AS(SELECT TRIM(TO_CHAR(SUM(order_qty), '999,999,999')) AS releASed FROM orders o, order_line_item oli WHERE o.order_id = oli.order_id AND order_type = 'EC' AND do_status = '110'),
c AS(SELECT TRIM(TO_CHAR(SUM(order_qty), '999,999,999')) AS allocated FROM orders o, order_line_item oli WHERE o.order_id = oli.order_id AND order_type = 'EC' AND do_status in ('120','130')),
d AS(SELECT TRIM(TO_CHAR(SUM(order_qty), '999,999,999')) AS inpacking FROM orders o, order_line_item oli WHERE o.order_id = oli.order_id AND order_type = 'EC' AND do_status = '140'),
e AS(SELECT TRIM(TO_CHAR(SUM(order_qty), '999,999,999')) AS Total FROM orders o, order_line_item oli WHERE o.order_id = oli.order_id AND order_type = 'EC' AND do_status <= '140')
SELECT prereleASed,releASed,allocated,inpacking "IN PACKING",Total FROM a,b,c,d,e;


-- Find all the multisku iLPN ON the ASN and valdiate the LPN ON the correct xml.
SELECT lpn, COUNT(lpn) AS number_of_lpns
FROM ASNDBA.ASn_intransit_lpn@wms12_to_omnia 
WHERE ASn_number ='221583652' 
GROUP BY lpn
HAVING COUNT(lpn) > 1;


-- DC12 - SEV 1 >> > Duplicate Order Notes
-- This will cause "WAVE ABORTS".  Please investigate and process the duplicate order notes CCF to remove the duplicates
select order_id, note_seq, note_type, note, line_item_id, note_code from order_note
where order_id||'-'||line_item_id||'-'||note_seq in
(select order_id||'-'||line_item_id||'-'||note_seq from (
select ORDER_ID, LINE_ITEM_ID, NOTE_TYPE, note_code, max(note_seq) note_seq, COUNT(*)  from order_note
where order_ID IN
(select order_id from orders where do_status <= 130)
AND LINE_ITEM_ID <> 0
and note_type = 'VS'
GROUP BY ORDER_ID, LINE_ITEM_ID, NOTE_TYPE, note_code
HAVING COUNT(*) > 1));

-- Get the Distributed Order ID
SELECT DISTINCT tc_order_id FROM orders WHERE order_id IN ('180937676','180937677','180937677','180937677','180937677','180937677','180937676','180937677','180937677','180937677','180937677','180937677','180937677','180937676','180937677','180937676'
);


/* DC12 gets foreign trailers now, we need to make sure that the ASn we fix are dONe correctly the first time around. 
   Here is the query to validate if the trailer is part of FTZ. 
*/
-- FTZ uses invoice to file duty payments
-- Any invoice flagged WITH Y are FTZ
SELECT tc_lpn_id, iiff.* 
FROM ip_invoice_ftz_flag iiff
JOIN lpn_detail ld ON iiff.invoice_booking_number = ld.cut_nbr
JOIN lpn l ON ld.lpn_id = l.lpn_id
JOIN ASn a ON a.tc_ASn_id = l.tc_ASn_id
WHERE a.trailer_number = 'CAAU5395875';


-- Check for databASe locks
SELECT c.status,
       OS_USER_NAME "Terminal",
       a.PROCESS "UNIX proccess",
       SUBSTR(ORACLE_USERNAME,1,10) "Locker",
       SUBSTR(PROGRAM,1,99) "Program",
       NVL(lockwait,'ACTIVE') "Wait",
       SUBSTR(DECODE(LOCKED_MODE,2,'ROW SHARE',3, 'ROW EXCLUSIVE',4, 'SHARE',5,'SHARE ROW EXCLUSIVE',6, 'EXCLUSIVE',  'UNKNOWN'),1,12) "Lockmode",
       OBJECT_TYPE "Object Type",
       object_name "Object Name",
       session_ID "session ID",
       "SERIAL#" "Serial",
       SUBSTR(c.SID,1,6) "SID",
       c.sql_id,
       logON_time, secONds_in_wait
FROM  SYS.V_$LOCKED_OBJECT A,  SYS.ALL_OBJECTS B,   SYS.V_$session c
WHERE A.OBJECT_ID = B.OBJECT_ID
AND object_name not in ('PROC_LOCK','LABOR_MSG') 
AND object_name not like '%TMP%' 
AND object_name not like '%$%'
AND c.program like 'Pk%'
AND C.SID = A.session_ID  AND secONds_in_wait > 300;


SELECT ASN_NUMBER, lpn, QUANTITY, ASn_intransit_lpn.*
FROM ASNDBA.ASn_intransit_lpn@wms12_to_omnia
WHERE lpn in ('00006644541888263588');


-- Checking ASN info header
SELECT wmo1.id,
       lTRIM(wmo1.ASn_number,0) ASn /*, 
       PO_NUMBER, LINE_NUMBER*/, 
       CONTAINER_NUMBER,SUM(wmo1.QUANTITY ), 
       COUNT(DISTINCT wmo1.PRODUPC), 
       COUNT( wmo1.lpn), 
       COUNT( DISTINCT wmo1.lpn), 
       min(wmo1.lpn), 
       max(wmo1.lpn), 
       wmo1.STATUS, 
       wmo1.ASn_number
FROM ASNDBA.ASn_intransit_lpn@wms12_to_omnia wmo1
LEFT JOIN prodskus@wms12_to_omnia wmo2
ON wmo1.id = wmo2.id
--WHERE CONTAINER_NUMBER LIKE '%155166%'
--WHERE po_number = '19077144'
WHERE lTRIM(ASn_number,0) in ('546770797')
--AND STATUS <> 'OPEN'
GROUP BY  wmo1.id,
          ASN_NUMBER/*, 
          PO_NUMBER, 
          LINE_NUMBER*/, 
          CONTAINER_NUMBER, 
          STATUS;

SELECT * FROM ALL_TAB_COLS WHERE TABLE_NAME LIKE '%PRODUPC%' AND OWNER = 'DM';

SELECT * FROM ASNDBA.ASn_intransit_lpn@wms12_to_omnia;
SELECT * FROM prodskus@wms12_to_omnia;
SELECT * FROM ALL_DB_LINKS;
SELECT * FROM msg_log WHERE msg like '%847945895%';
