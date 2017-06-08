[[http]]
name = "influxdbrelay"
bind-addr = "0.0.0.0:9096"
output = [
    {% for key, value in environment('HTTP_BACKEND_') %}{ name = "{{ key }}", location = "http://{{ value }}/write" },
{% endfor %}
]
