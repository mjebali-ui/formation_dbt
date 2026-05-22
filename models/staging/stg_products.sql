{{config(materialized= 'view')}}

select
    product_id,
    name,
    category,
    subcategory,
    price,
    cost,
    stock_quantity,
    supplier
from {{ source('raw_ecommerce', 'raw_products') }}
where is_active = true