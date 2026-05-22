{{ config(materialized='view') }}

with customers as (

    select *
    from {{ ref('stg_customers') }}

),

orders as (

    select *
    from {{ ref('stg_orders') }}

)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.country,
    c.city,
    c.signup_date,
    c.status,

    count(o.order_id) as total_orders,
    sum(o.amount) as total_amount

from customers c
left join orders o
    on c.customer_id = o.customer_id

group by
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.country,
    c.city,
    c.signup_date,
    c.status