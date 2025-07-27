{% macro log_model_start(model) %}
    {% set run_id = invocation_id %}
    {% set model_name = model.name %}

    {% do run_query("INSERT INTO MODEL_RUN_LOG (run_id, model_name, started_at, status) " ~
                    "VALUES ('" ~ run_id ~ "', '" ~ model_name ~ "', CURRENT_TIMESTAMP, 'started')") %}
{% endmacro %}


{% macro log_model_end(model, success=True, reason=None) %}
    {% set run_id = invocation_id %}
    {% set model_name = model.name %}
    {% set status = 'success' if success else 'error' %}
    {% if reason is none %}
        {% set reason = 'Success. No Failed Reason' %}
    {% endif %}
    {% set escaped_reason = reason | replace("'", "''") %}

    {% do run_query("UPDATE MODEL_RUN_LOG SET " ~
                     "finished_at = CURRENT_TIMESTAMP, " ~
                     "duration_s = DATEDIFF(second, started_at, CURRENT_TIMESTAMP), " ~
                     "status = '" ~ status ~ "', " ~
                     "reason = '" ~ escaped_reason ~ "' " ~
                     "WHERE run_id = '" ~ run_id ~ "' AND model_name = '" ~ model_name ~ "'") %}
{% endmacro %}


{% macro log_failed_models(results) %}
    {% for res in results if res.status != 'success' %}
        {% set reason = res.message if res.message is defined else 'Unknown error' %}
        {{ log_model_end(res.node, success=False, reason=reason) }}
    {% endfor %}
{% endmacro %}
