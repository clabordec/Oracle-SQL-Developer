-- TEMPLATE

set echo on;
set heading on;
set linesize 3500;
-- Set log file date time
column date_column new_value filestamp
select to_char(sysdate,'YYYYMMDDHH24MISS') date_column from dual;

spool C:\ChangeControl\CCFxxx_&filestamp._&1..log;

-- Chaanyah Laborde: (Title)
-- Modify the CCF Number to match the correct CCF Number below ---
insert into setccf values ('CCF')   -- TO TURN ON
/

-- Body of SQL Script goes below this line


-- 

-- Modify the CCF Number to match the correct CCF Number below ---
insert into unsetccf values ('CCFxxx') -- TO TURN OFF
/

show errors;

/* ---------------------------- */
/*  If no errors are found:     */
/* Manually Perform a COMMIT    */
/* ---------------------------- */
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Update the quantity to 0, this will help operations merge other items with quantity
SELECT * FROM WM_INVENTORY WHERE LOCATION_ID = '100362147' AND WM_INVENTORY_ID IN ('463231815', '997007563') AND ITEM_ID = '2965234';

UPDATE WM_INVENTORY set on_hand_qty = '0' where location_id = '100362147' and wm_inventory_id in ('463231815', '997007563') and item_id = '2965234';

SELECT * FROM WM_INVENTORY WHERE LOCATION_ID = '100362147' AND WM_INVENTORY_ID IN ('463231815', '997007563') AND ITEM_ID = '2965234';


-- Set the tote to consumed status, so that operations can reuse the tote
SELECT * FROM alloc_invn_dtl 
WHERE alloc_invn_dtl_id IN ('662487563','662487567','662487578','662487582','662487586','662487587','662487590','662487593','662487735','662505312','662506631','662506674','662506675','662506642','662506646','662506649','662506650','662506651','662506654','662506661','662506664','662506665','662506666','662506668','662506670','662506671','662506672','662506673','662506639','662487559','662487565','662545868','662545876','662506678','662506680','662506681','662506682','662506683');

UPDATE alloc_invn_dtl SET stat_code = 99
WHERE alloc_invn_dtl_id IN ('662487563','662487567','662487578','662487582','662487586','662487587','662487590','662487593','662487735','662505312','662506631','662506674','662506675','662506642','662506646','662506649','662506650','662506651','662506654','662506661','662506664','662506665','662506666','662506668','662506670','662506671','662506672','662506673','662506639','662487559','662487565','662545868','662545876','662506678','662506680','662506681','662506682','662506683');
 
SELECT * FROM alloc_invn_dtl 
WHERE alloc_invn_dtl_id IN ('662487563','662487567','662487578','662487582','662487586','662487587','662487590','662487593','662487735','662505312','662506631','662506674','662506675','662506642','662506646','662506649','662506650','662506651','662506654','662506661','662506664','662506665','662506666','662506668','662506670','662506671','662506672','662506673','662506639','662487559','662487565','662545868','662545876','662506678','662506680','662506681','662506682','662506683');


-- Delete the pick location that does not have a batch number tied to it
SELECT * FROM wm_inventory WHERE location_id = '100402836' AND wm_inventory_id = '475012685' AND location_dtl_id = '33387513';

DELETE wm_inventory WHERE location_id = '100402836' AND wm_inventory_id = '475012685' AND location_dtl_id = '33387513';

SELECT * FROM wm_inventory WHERE location_id = '100402836' AND wm_inventory_id = '475012685' AND location_dtl_id = '33387513';
