{% if grains['os'] == "RedHat" %}
apache: httpd
{% elif grains['os'] == 'Debian' %}
apache: apache2
{% endif %}

PORT: 8080
