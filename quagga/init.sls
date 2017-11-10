{% from "quagga/map.jinja" import map with context %}

quagga:
  pkg.installed:
    - pkgs: {{ map.pkgs|json }}
  service.running:
    - name: {{ map.service }}
    - enable: True
    - reload: True
