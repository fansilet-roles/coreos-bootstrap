CoreOs BootStrap
=========

A very nice bootstrap for CoreOS with python and docker-compose

Requirements
------------

None

Role Variables
--------------

On default/main.yml you can set a few variables, like targets, user, universaltime and selective boolean tasks.
For example, you can change universaltime to ajdust the right TimeZone for your country, and you can change componize
to false to prevent docker-compose installation.

This role have 3 boolean selective install vars:
    * pyhtonize: true (install python, its true by defaults)
    * timeset: true   (adjust timezone, its america saopaulo by defaults)
    * componize: true (install docker-compose)

_By default python/compose/virtualenv whill be installed on "/opt/pyhton/bin"_
_It dosen't necessery set global $PATH for pyhton, this role whill be place a nice script called dotfile.sh on
"/etc/profile.d" and it whill be automaticaly be loaded when you login_

You must set your inventory vars with this python path:

[coreos:vars]
ansible_python_interpreter="/opt/python/bin/python"


Dependencies
------------

None

Example Playbook
----------------

In this playbook you are ajdusting timezone to New York and disabling python instalation.

```
---
  - name: "BootStrap CoreOS"
    hosts: coreos
    remote_user: core
    vars:
      universaltime: America/New_York
      pyhtonize: false
      timeset: true
    roles:
      - coreos-bootstrap
```


License
-------

BSD

Author Information
------------------

This role was create in 2017 by [Igor Brandao](https://isca.space)

