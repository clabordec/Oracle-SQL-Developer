alter session set current_schema = DM;

-- 
with cte as (
    select order_id,
           tc_order_id,
           o_facility_alias_id,
           o_address_1,
           o_city,
           o_state_prov,
           o_postal_code,
           o_country_code
           d_facility_alias_id,
           d_address_1,
           d_city,
           d_state_prov,
           d_postal_code,
           bill_to_name,
           (select count(*) from lpn l where o.order_id = l.order_id and lpn_facility_status = 20) as number_of_lpns
    from orders o
)
select * from cte where number_of_lpns > 500
order by order_id;


-- Confirm the records shown in the above query
select o.order_id,
       count(*) as number_of_lpns
from lpn l 
join orders o
on l.order_id = o.order_id
where l.lpn_facility_status = 20
group by o.order_id
having count(*) > 500
order by order_id;
