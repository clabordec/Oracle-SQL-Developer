alter session set current_schema = dm;


SELECT 
--DISTINCT
--    ( o.d_address_1 ),
    o.order_date_dttm,
    l.container_size,
    o.tc_order_id,
    l.tc_lpn_id,
    l.tracking_nbr,
    o.d_address_1,
    o.d_address_2,
    o.bill_to_fax_number,
    o.d_contact,
    o.dc_ctr_nbr,
    o.d_city,
    o.d_state_prov,
    o.d_postal_code,
    o.bill_to_phone_number,
    o.bill_to_name,
    0.bill_to_email,
    o.has_split,
    o.chute_id,
    o.o_phone_number,
    o.d_name,
    o.lane_name,
    l.ship_via,
    l.lpn_label_type
--    *
FROM
    orders o,
    lpn l
WHERE
    o.tc_order_id = l.tc_order_id
    AND dc_ctr_nbr LIKE '249380%'
--    AND dc_ctr_nbr IN (
--        '249380-1026', ---"Problem store" 1255 RARITAN RD, CLARK, NJ 07066 US
--        '249380-0891', ---"Problem store" 3131 KENNEDY BLVD, NORTH BERGEN, NJ 07047 US
--        '249380-1150', ---"Good store"    2524 BERRYHILL RD , MONTGOMERY, AL 36117 US
--        '249380-0567' ---"Good store"     6216 S WESTNEDGE AVE, PORTAGE, MI 49002 US
--    )
--    AND o.order_date_dttm > SYSDATE - 14
    AND l.lpn_facility_status < 90
--    AND l.lpn_facility_status = '20'
--        AND l.container_size = 'C13' --Parent cartons
--    AND l.container_size != 'C13' -- child cartons
    AND o.tc_order_id LIKE 'CAR%'
ORDER BY
    o.bill_to_fax_number DESC;