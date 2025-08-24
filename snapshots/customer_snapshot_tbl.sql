{% snapshot customer_snapshot_tbl  %}
  {{
    config(
      unique_key='customer_id',
      strategy='check',
      check_cols=['country_state']
    )
  }}

  SELECT * 
  FROM {{ source('RAW_DATA', 'customers_src_tbl') }}

{% endsnapshot %}