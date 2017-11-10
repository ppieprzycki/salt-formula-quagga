{% from "quagga/map.jinja" import map with context %}                                                                                                           

include:
  - quagga

{% set quagga = pillar.get('quagga', {}) %}
{% set bgpd   = quagga.get('bgpd', False) %}
{% set zebra  = quagga.get('zebra', False) %}
{% set prefix_list = quagga.get('prefix_list', False) %}
{% set route_map = quagga.get('route_map', False) %}


quagga_daemons:
  file.managed:
    - name: {{ map.config_destination_dir }}/daemons
    - user: {{ map.user }}
    - group: {{ map.group }}
    - mode: {{ map.mode }}
    - template: jinja
    - source:   salt://{{ map.config_source_dir }}/daemons.jinja
    - context:
      bgpd:  {{ bgpd }}

{% if bgpd %}
quagga_bgpdconf:
  file.managed:
    - name: {{ map.config_destination_dir }}/bgpd.conf
    - user: {{ map.user }}
    - group: {{ map.group }}
    - mode: {{ map.mode }}
    - template: jinja
    - source:   salt://{{ map.config_source_dir }}/bgpd.conf.jinja
    - context:
      bgpd:  {{ bgpd }}
      log_dir: {{ map.log_dir }}
      prefix_list: {{ prefix_list }}
      route_map: {{ route_map }}
{% endif %}

quagga_zebraconf:
  file.managed:
    - name: {{ map.config_destination_dir }}/zebra.conf
    - user: {{ map.user }}
    - group: {{ map.group }}
    - mode: {{ map.mode }}
    - template: jinja
    - source: salt://{{ map.config_source_dir }}/zebra.conf.jinja
    - context:
      log_dir: {{ map.log_dir }}
      zebra: {{ zebra }}


{% if grains['os_family'] == 'Debian' %}
quagga_debianconf:
  file.managed:
    - name: {{ map.config_destination_dir }}/debian.conf
    - user: {{ map.user }}
    - group: {{ map.group }}
    - mode: {{ map.mode }}
    - template: jinja
    - source: salt://{{ map.config_os_source_dir }}/debian.conf.jinja
{% endif %}

