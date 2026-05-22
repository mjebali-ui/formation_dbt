{{config(materialized= 'view')}}

select 
    customer_id,
    order_id,
    amount,
    upper(status) as status
from {{ source('raw_ecommerce', 'raw_orders') }}
where order_id is not null
