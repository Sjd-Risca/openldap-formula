{% from 'openldap/map.jinja' import openldap with context %}
ldap-server:
  pkg.installed:
    - name: {{ openldap.server_pkg }}
  file.managed:
    - name: {{ openldap.server_config }}
    - source: salt://openldap/files/slapd.conf
    - template: jinja
    - user: root
    - group: {{ openldap.su_group }}
    - mode: 644
    - makedirs: True
    - require:
      - pkg: ldap-server
  service.running:
    - name: {{ openldap.service }}
    - enable: True

ldap-server-default:
  file.managed:
    - name: /etc/default/slapd
    - source: salt://openldap/files/default.conf
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: ldap-server
