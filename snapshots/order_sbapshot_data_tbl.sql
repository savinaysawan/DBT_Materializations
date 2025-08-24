{% snapshot order_snapshot_data_tbl %}
  {{
    config(
      unique_key='order_id',
      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('RAW_DATA', 'orders_source') }}
{% endsnapshot %}