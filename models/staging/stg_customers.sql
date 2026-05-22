{{ config(materialized='view') }}

select
    customer_id,
    first_name,
    last_name,
    email,
    country,
    city,
    signup_date,
    upper(status) as status

from {{ source('raw_ecommerce', 'raw_customers') }}
