{{ config(materialized='view') }}

with orders as (

    select
        customer_id,
        order_id,
        amount,
        upper(status) as status
    from {{ source('raw_ecommerce', 'raw_orders') }}
    where order_id is not null

),

customers as (

    select
        customer_id,
        first_name,
        last_name,
        country
    from {{ source('raw_ecommerce', 'raw_customers') }}
    where status = 'active'

)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country,
    count(o.order_id) as nb_orders

from customers c
left join orders o
    on c.customer_id = o.customer_id

group by
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country