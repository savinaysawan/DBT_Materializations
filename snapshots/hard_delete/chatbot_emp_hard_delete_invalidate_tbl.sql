{% snapshot chatbot_emp_hard_delete_invalidate_tbl %}
  {{
    config(
      unique_key='emp_id',
      strategy='timestamp',
      updated_at='raw_data_update_at',
      hard_deletes='invalidate'
    )
  }}

SELECT * 
FROM {{ source('RAW_DATA', 'chatbot_emp') }}

{% endsnapshot %}