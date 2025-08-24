{% snapshot chatbot_emp_full_data_tbl %}
  {{
    config(
      unique_key='emp_id',
      strategy='timestamp',
      updated_at='raw_data_update_at',
      invalidate_hard_deletes=true
    )
  }}

  SELECT * 
  FROM {{ source('RAW_DATA', 'chatbot_emp') }}
{% endsnapshot %}