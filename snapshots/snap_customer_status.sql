{% snapshot snap_customer_status %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',

        strategy='check',
        check_cols=['email', 'country']
    )
}}

SELECT
    customer_id,
    first_name,
    last_name,
    email,
    country,
    signup_date
FROM {{ ref('stg_customers') }}

{% endsnapshot %}