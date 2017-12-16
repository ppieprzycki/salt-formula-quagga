{% from "quagga/map.jinja" import map with context %}

include:
  - quagga.config

quagga:
  pkg.installed:
    - pkgs: {{ map.pkgs|json }}
  service.running:
    - name: {{ map.service }}
    - enable: True
    - reload: True
    - require:
      - sls: quagga.config
