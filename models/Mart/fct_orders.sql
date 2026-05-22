{{ config(materialized='table') }}

with orders as (

    select
        order_id,
        customer_id,
        order_date,
        amount
    from {{ source('raw_ecommerce', 'raw_orders') }}
    where order_id is not null

),

daily_agg as (

    select
        date_trunc('day', order_date) as order_day,
        count(distinct order_id) as nb_orders,
        count(distinct customer_id) as nb_customers,
        sum(amount) as total_revenue,
        avg(amount) as avg_order_value
    from orders
    group by 1

)

select distinct *
from daily_agg