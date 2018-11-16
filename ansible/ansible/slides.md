---
title: Ansible
separator: "^\n\n\n\n"
verticalSeparator: "^\n\n\n"
revealOptions:
  transition: slide
  progress: true
  controls: false
  slideNumber: c/t
---
# Ansible




## Overview




### What is it good for?
* Provisioning and Configuration Management
* Application Deployment
* Orchestration
* Plays nicely with Docker and most Cloud Providers

So, it covers most of your needs for a typical web app



### What is it?
* An IT automation tool
* Written in `Python`
* Configured with templated `YAML` and fancy `INI-like` syntax
* Declarative approach
* Masterless, utilizes `Push` instead of `Pull` idiom
* Mostly targeted at *NIX, has limited Windows support
* Uses SSH (or Remote PowerShell for Windows) to communicate with managed hosts



### Pushing instead of Pulling
Ansible relies on Push idiom: you push changes to managed nodes,
instead of nodes pulling changes from a master.

* Greatly simplifies Orchestration
* Goes nicely with modern Continuous Integration pipelines.
* Doesn't scale quite as well (in the free version)



### Requirements
Host:
* Python 2.6+

Managed nodes (one of): 
* Python 2.5
* Python 2.4 with `python-simplejson`
* Nothing for `raw` or `script` modules



### Related resources
* [Ansible Tower](http://docs.ansible.com/ansible/latest/tower.html) - Enterprise-scale Ansible
* [Ansible Vault](http://docs.ansible.com/ansible/latest/playbooks_vault.html) - Managing "secrets" with Ansible
* [Ansible Galaxy](http://docs.ansible.com/ansible/latest/galaxy.html) - Collection of open-source roles




## Installation



Ubuntu
```bash
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

Debian
```bash
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | sudo tee >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt-get update
sudo apt-get install ansible
```



RedHat, Centos, Fedora - Add EPEL repository (enable `testing` for newer versions)
```bash
yum install ansible
```




## Key Concepts
* `Inventory` - a list of all managed hosts, possibly divided into groups
* `Module` - a unit responsible for configuring one specific system aspect (managing a file or service)
* `Task` - a configured application of Module
* `Role` - a collection of Tasks responsible for setting up a "logical unit" of configuration. The specificity
is up to you: a "mysql" role can coexist with broader "database" role
* `Play` - a collection of Tasks and Roles applied to a set of hosts from inventory




## Inventory file
The core part of every Ansible setup



Inventory files use an `INI-like` syntax to define managed hosts, optionally divided into groups
```ini
mail.example.com

[webservers]
web1.example.com
web2.example.com

[dbservers]
db1.example.com
db2.example.com
```



Feel free to use hostnames, ip addresses and specify non-default ports
```ini
example.com:22200
195.66.141.75
```

Numeric and Alphabetical ranges are supported
```ini
[webservers]
192.168.1.[1:255]
www[01:50].example.com

[databases]
db-[a:f].example.com
```



Groups may include other groups with special `:children` syntax
```ini
mail.example.com

[webservers]
web1.example.com
web2.example.com

[dbservers]
db1.example.com
db2.example.com

[appservers:children]
webservers
dbservers
```



Note, that two groups are always present:
* `all` - includes all hosts
* `ungrouped` - includes hosts without group



### Inventory parameters
You may specify additional parameters to alter Ansible's default connection parameters or to create host aliases
```ini
loadbalancer    ansible_port=22200    ansible_host=192.168.0.2

localhost       ansible_connection=local

192.168.1.1     ansible_user=vagrant
```
[Full list of inventory parameters](http://docs.ansible.com/ansible/latest/intro_inventory.html#list-of-behavioral-inventory-parameters)



Parameters may be applied on per-group basis with `:vars` section
```ini
[webservers]
web1.example.com
web2.example.com

[webservers:vars]
ansible_user=maintenance
```



All non-reserved parameters will be passed for you to use later in playbooks as variables
```ini
[webservers]
web1.example.com    proxy_host=fallback.example.com
web2.example.com

[webservers:vars]
proxy_host=proxy.example.com
proxy_port=8081
```



Preferred way to define parameters is by splitting them into separate files:
```ini
├── inventory
├── group_vars
│   ├── all.yml              <- Vars for all hosts
│   ├── webserver.yml        <- Vars for all hosts on webserver group
│   └── dbserver.yml         <- and so on
└── host_vars
    └── mail.example.com.yml <- vars only for this host
```
Note that this approach only supports `YAML` or `JSON` syntax for parameter definition



### Using inventory and groups
To specify which inventory file to use, supply the `-i` option
```bash
ansible -i inventory
```

You can also supply a host-matching pattern as a first unnamed parameter
```bash
ansible webservers -i inventory
ansible *.example.com -i inventory
```



Patterns are very flexible:
* Include hosts from both groups
```bash
webservers:dbservers
```
* Exclude hosts from another group
```bash
webservers:!old
```
* Intersect groups (use hosts present in both groups)
```bash
webservers:&old
```



Combine them
```bash
webservers:dbservers:&old:!provisioning
```



You can mix-and-match different types of patterns
```
*.example.com:&webservers
```



And use regular expressions
```bash
~(web|db).*\.example\.com
```



### Dynamic inventories
If the inventory file is marked as executable, it will be treated as a python script
which output will be used to construct actual inventory file.

For example, setting up Amazon EC2 inventory script
```
wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
chmod +x ec2.py

export AWS_ACCESS_KEY_ID='AK123'
export AWS_SECRET_ACCESS_KEY='abc123'

ansible -i ec2.py
```
[More on inventory scripts](http://docs.ansible.com/ansible/latest/dev_guide/developing_inventory.html)



If a directory is supplied as inventory, all files in it will be treated as inventory files:
* Executable files as dynamic inventories
* Other files as static inventories
* `.orig, .bak, .ini, .cfg, .retry, .pyc, .pyo` will be ignored



```
└── inventories
    ├── host_vars
    │   └── ...
    ├── group_vars
    │   └── ...
    ├── ec2.py
    └── inventory
```

```
ansible -i ./inventories
```
Will result in Ansible using both static and dynamic inventories.

Host and Group variables will still work as expected.




## Modules
You can find a list of available modules [online](http://docs.ansible.com/ansible/latest/modules_by_category.html)



### Offline documentation
List all modules with
```bash
ansible-doc -l
```

Look up documentation on specific module with
```bash
ansible-doc <module>
```



### Ad-hoc commands
Having only inventory file, you may already run modules across your hosts using
```bash
ansible [...] -m <module> -a "<params>"
```



For example:
* Pinging all hosts
```bash
ansible -i inventory -m ping
```
* Get uptime for dbservers group
```bash
ansible webservers -i inventory -m command -a "uptime"
```
* Restart httpd service on all hosts in webservers group
```bash
ansible webservers -i inventory -m service -a "name=httpd state=restarted"
```




## YAML
Yet Another Markup Language



YAML is used to represent structured data and consists of:
* Basic types: strings, numbers, booleans, null
* Arrays
* Hashes (also known as dictionaries)



### Strings
Strings are usually written as-is, even with spaces
```yaml
string value
```

But have to be quoted if they contain control-characters, like ":", "{" or "["
```yaml
"string[value]"
```



### Arrays
Short syntax - strings are always quoted
```yaml
['value1', 'value2', 'value3']
```

Expanded syntax
```yaml
- value1
- value2
- value3
```



### Hashes
Keys are always strings, values can be of arbitrary type

Short syntax
```yaml
{key1: value1, key2: value2}
```

Expanded syntax
```yaml
key1: value1
key2: value2
```



### Combining expanded syntax
Nested expanded syntax is denoted with a tab.

Array in hash
```yaml
hashKey: hashValue
hashArray:
  - arrayItem1
  - arrayItem2
anotherHashKey: hashValue
```

Hash as element of an array
```yaml
- arrayItem1
- 
  hashKey: hashValue
  hashKey2: hashValue2
- arrayItem3
```



### Summing up
Every YAML file starts with a `---`.

So, a full example would be
```yaml

---
typicalKey: string value
anotherKey: "complex:string{value}"
expandedHash:
  hashKey1: hashValue1
  nestedHash:
    nestedArray:
      - stringValue
      - 
        anotherHashKey: anotherHashValue
        anotherHashKey2: anotherHashValue2
      - ['array inside array']
  hashKey2: yet another string value
shortHash: {hashKey1: hashValue1, nestedArray: ['0', '1', '2']}
```




## Playbooks
Setting things in motion



A single play is defined by:
* Pattern of hosts
* Tasks and Roles to apply



For example
```yaml

---
- hosts: webservers
  tasks:
    - name: ensure httpd is at the latest version
      yum:
        name: httpd
        state: latest
    - name: ensure httpd is running (and enable it at boot)
      service:
        name: httpd
        state: started
        enabled: yes
```



`Playbook` is a set of `plays` potentially targeting different host groups.

You are encouraged to have more than one playbook -- as many as needed. You may have a configuration playbook,
a deployment playbook, separate them by roles, etc.



A playbook may contain one or more plays
```yaml
- hosts: webservers
  tasks:
    - name: ensure httpd is at the latest version
      yum:
        name: httpd
        state: latest
    - name: ensure httpd is running (and enable it at boot)
      service:
        name: httpd
        state: started
        enabled: yes
      
- hosts: dbservers
  tasks:
    - name: ensure mysql is at the latest version
      yum:
        name: mysql
        state: latest
    - name: ensure mysql is running (and enable it at boot)
      service:
        name: mysql
        state: started
        enabled: yes
```



To test playbook syntax, run
```
ansible-playbook playbook.yml --syntax-check
```

To apply a playbook, run
```bash
ansible-playbook playbook.yml -i inventory
```

`ansible-playbook` accepts most of parameters `ansible` does




## Variables



### Using variables
Both playbook and template files are processed by Python's `Jinja2` templating system.

To use a variable, you surround it with `"{{ }}"`:
```
"{{ var_name }}"
```



For example, we have a `package_name` variable defined in `group_vars`
```yaml
# ./group_vars/dbservers.yml
package_name: mysql
```

Then, you can include it into your plays and tasks
```yaml
# ./playbook.yml
- hosts: dbservers
  tasks:
    - name: ensure mysql is at the latest version
      yum:
        name: "{{package_name}}"
        state: latest
    - name: ensure mysql is running (and enable it at boot)
      service:
        name: "{{package_name}}"
        state: started
        enabled: yes
```



Accessing nested arrays or dictionaries properties is supported like in Python
```yaml
# ./group_vars/dbservers.yml
package:
  name: mysql
  versions: ['5.5', '5.6']
```

```yaml
"{{package.name}} - {{package.versions[0]}}"
```



Variables are separated in following categories:
* Predefined variables (host_vars, group_vars, role defaults, play and task variables, etc.)
* Facts (hosts information) gathered by `setup` module
* Dynamic variables that were defined during task execution



Variable precedence (last has the most priority):
* Role defaults
* group_vars
* host_vars
* Facts
* Play variables
* Role variables
* Task variables
* Registered (dynamic) variables
* Extra vars



You may additionally pass variables from command line
```bash
ansible-playbook playbook.yml -i inventory --extra-vars="deploy_version=1.0.1"
```



You may define variables on task and play levels to save some typing or as preparation to branching it into a role
```yaml

- hosts: dbservers
  vars:
    package_name: mysql
  tasks:
    - name: ensure mysql is at the latest version
      yum:
        name: "{{package_name}}"
        state: latest
    ...
```



### Facts
Ansible facts are provided by `setup` module, so you can easily check the full list with
```bash
ansible localhost --connection=local -m setup
```

The best part is, facts of all hosts acting in current play are always available as `hostvars`



### Filters
Ansible provides [a lot of useful filters](http://docs.ansible.com/ansible/latest/playbooks_filters.html)
to process your variables in-place.

You can apply filter by "piping" a variable into it, just like in bash.
```yaml
"{{variable | filter(param) | anotherFilter}}"
```



For example
* Setting a default value if variable is not defined
```yaml
"{{package_name | default(mysql)}}"
```
* Hashing a string
```yaml
"{{password | hash(sha1)}}"
```
* Extract ip addresses of hosts in dbservers group

```yaml
"{{groups['dbservers'] | map('extract', hostvars, ['ansible_default_ipv4', 'address']) | list}}"
```



### Loops



A task can be run multiple times with items from an array using `with_items`
```yaml
name: ensure packages are installed
yum:
  name: "{{item}}"
  state: latest
with_items:
  - vim
  - wget
  - screen
```



Or with items from dictionary using `with_dict`
```yaml
name: ensure packages are in required state
vars:
  packages:
    vim: latest
    wget: present
    screen: absent
yum:
  name: "{{item.key}}"
  state: "{{item.value}}"
with_dict: "{{ packages }}"
```



### Conditions
Use `when` paired with Python boolean expression to run task conditionally

```yaml
tasks:
  - name: "Use apt for debian"
    apt:
      name: nginx
      state: present
    when: ansible_os_family == "Debian"
  - name: "Use yum for CentOS"
    yum:
      name: nginx
      state: present
    when: ansible_os_family == "CentOS"
```



`when` can also be used to filter out `with_items` or `with_dict`

```yaml
name: "Use apt for debian"
command: "echo {{ item }}"
with_items: [0, 1, 2, 3, 4, 5]
when: item > 3
```




## Handlers
Handlers are special tasks, that are triggered by other tasks using `notify`.



For example, restarting apache after its configuration has changed
```yaml

---
- hosts: webservers
  tasks:
  - name: write the apache config file
    template:
      src: /srv/httpd.j2
      dest: /etc/httpd.conf
    notify:
    - restart apache
  handlers:
    - name: restart apache
      service:
        name: httpd
        state: restarted
```



* Handlers never run unless notified
* Handlers run only once if notified multiple times
* Handlers are run in the very end of the play




## Become
`become` is Ansible's `sudo/su`



`become` can be used to temporarily switch to another user at global, play, role or task levels.



For example:
* You need root to manage apache
* You need to manage php application with ssh user

```yaml

---
- hosts: webservers
  become: true
  tasks:
  - name: write the apache config file
    template:
      src: /srv/httpd.j2
      dest: /etc/httpd.conf
    notify:
    - restart apache
  - name: clear php app cache
    become: false
    command: "/var/www/app/bin/console cache:clear"
  handlers:
    - name: restart apache
      service:
        name: httpd
        state: restarted
```




## Register
Capturing task output as a variable



For example, there is a clever tool that outputs path to its configuration in JSON format
and you need to manage this configuration. Essentially, you need to "lift" data that tool outputs into your play.



The tool outputs something along the lines
```json
{"configuration_path": "/etc/tool/revision-hash/202cb962ac59075b964b07152d234b70/config"}
```



To capture its output into variable, use register
```yaml
tasks:
  - command: /bin/tool --config
    register: tool_output
  - name: write the tool config file
    template:
      src: /srv/tool.j2
      dest: "{{tool_output.stdout | from_json | json_query('configuration_path')}}"
```
[Docs on what you can find in registered result](http://docs.ansible.com/ansible/latest/common_return_values.html)




## Error Handling
By default, Ansible can tell if a task has failed by looking up the process exit code



### Error conditions
However, you may sometimes want to define your own error conditions



For example, another tool prints "FAILED" when it fails, but returns a successful exit code
```yaml
- name: this command prints FAILED when it fails
  command: /usr/bin/example-command -x -y -z
  register: command_result
  failed_when: "'FAILED' in command_result.stderr"
```



Or, a tool reports failure exit code on successful run:
```yaml
- name: this command prints SUCCESS when it succeeds
  command: /usr/bin/example-command -x -y -z
  register: command_result
  ignore_errors: true
  failed_when: "'SUCCESS' not in command_result.stdout"
```



### Aborting the play
You can abort the play from task using `fail` syntax
```yaml
- name: Unexpected Error
  fail: msg="Something went wrong"
  when: result|failed
```

Or, you can abort the play on any error by default using
```yaml
- hosts: somehosts
  any_errors_fatal: true
  tasks:
    ...
```



### Fallback steps
Now, you may actually handle the error.
For example, enabling a new apache virtual host with rollback steps if configuration is somehow invalid.
```yaml
- hosts: webservers
  tasks:
    - name: Push future default virtual host configuration
      copy: src=files/awesome-app dest=/etc/apache2/sites-available/ mode=0640
      
    - name: Activates our virtualhost
      command: a2ensite awesome-app
      
    - name: Check that our config is valid
      command: apache2ctl configtest
      register: result
      ignore_errors: true
      
    - name: Rolling back - Restoring old default virtualhost
      command: a2ensite default
      when: result|failed
      
    - name: Rolling back - Removing our virtualhost
      command: a2dissite awesome-app
      when: result|failed
      
    - name: Rolling back - Ending playbook
      fail: msg="Configuration file is not valid. Please check that before re-running the playbook."
      when: result|failed
```




## Serial
Serial allows you to define batches in which play should be executed



It accepts a number, a percentage value or an array of those.

For example, updating one, then 10% of servers left each batch
```yaml
- hosts: webservers
  serial:
   - 1
   - 10%
```



You may also set maximum failed hosts threshold
```yaml
- hosts: webservers
  max_fail_percentage: 5
  serial: 10
```



### Run Once
A task can be marked as run once.
```yaml

---
# ...
  tasks:
    # ...
    - command: /var/www/app/bin/console migrations:migrate
      run_once: true
    # ...
```



However, together with `serial` task will be executed for each batch.
Use when together with hostname to overcome this.
```yaml

---
# ...
  tasks:
    # ...
    - command: /var/www/app/bin/console migrations:migrate
      when: inventory_hostname == webservers[0]
    # ...
```




## Delegation
A host may delegate action to another host



```yaml
- hosts: webservers
  serial: 5
  tasks:
  - name: take out of load balancer pool
    command: /usr/bin/take_out_of_pool {{ inventory_hostname }}
    delegate_to: groups['loadbalancers'][0]
  - name: actual steps would go here
    yum: name=acme-web-stack state=latest
  - name: add back to load balancer pool
    command: /usr/bin/add_back_to_pool {{ inventory_hostname }}
    delegate_to: groups['loadbalancers'][0]
```



You may also use `local_action` for command machine itself
```yaml
  - name: take out of load balancer pool
    delegate_local: command /usr/bin/take_out_of_pool {{ inventory_hostname }}
```



### Delegated facts
Delegation may also be used to collect facts about other hosts
```yaml
- hosts: app_servers
  tasks:
    - name: gather facts from db servers
      setup:
      delegate_to: "{{item}}"
      delegate_facts: true
      with_items: "{{groups['dbservers']}}"
```
This way you can access facts of dbservers even when they were not part of the play




## Strategies
Ansible supports different strategies for executing plays



* linear (default): all hosts in a batch wait for every step to be finished by other hosts before moving to next step
* serial: all hosts in a batch run tasks as fast as they can and wait for last host before moving to next batch
* free: all hosts in a batch run tasks as fast as they can



You can specify strategy on per-play basis
```yaml
- hosts: all
  strategy: free
  tasks:
  ...
```



There's also one special [debugger](http://docs.ansible.com/ansible/latest/playbooks_debugger.html) strategy to help you in developing.




## Roles
Reusable logical units



### Role structure
```
.
└── my_new_role
    ├── README.md
    ├── defaults      <- Role configuration interface
    │   └── main.yml
    ├── files         <- static files
    ├── handlers      <- post run commands, notified by tasks
    │   └── main.yml
    ├── meta          <- informations about role. Author, dependencies, etc.
    │   └── main.yml
    ├── tasks         <- Main part of the role
    │   └── main.yml
    ├── templates     <- Jinja2 file templates
    ├── tests         <- Tests for role
    │   ├── inventory
    │   └── test.yml
    └── vars          <- internal configuration
        └── main.yml
```
You can safely delete any of the unused parts



Use `ansible-galaxy` to bootstrap a new role
```bash
ansible-galaxy init --init-path=roles/ --offline my_new_role
```



defaults:
* Configuration, exposed to the user
* Some kind of parameters, you can use for the role

vars:
* Configuration inside the role
* Typically environment specific and loaded by facts



### Importing roles
Ansible Galaxy has a vast selection of roles



When using imported roles, always create a requirements.yml file to list them

Roles may be imported by name or from git
```yaml
# requirements.yml
- geerlingguy.jenkins # short name for roles from ansible galaxy

- src: https://github.com/bennojoy/nginx
  version: master
  name: nginx
```



Always have a separate directory for imported roles and configure it
```ini
# ansible.cfg
[defaults]
roles_path = ./galaxy_roles:./roles
```



Finally, fetch the roles using `ansible-galaxy`
```bash
ansible-galaxy install -r=requirements.yml -p=galaxy_roles
```



## Includes
Code reusage is achieved though gradual inclusion of smaller files.



You can include:
* Playbooks into playbooks
* Roles into play
* Tasklists into role and play
* Vars into everything above



### Including playbooks
Playbook includes are listed at the root of playbook and may be mixed with definition of play
```yaml
- include: initplays.yml

- hosts: localhost
  tasks:
    ...

- include: otherplays.yml
```



### Including roles
Roles can be included with `role` syntax, optionally overriding role default parameters
```yaml
- hosts: webservers
  roles:
    - common
    
    - role: test_app_a
      app_dir: '/opt/a'
      app_port: 5000
      
    - role: test_app_b
      dir: '/opt/b'
      app_port: 5001
```



### Tasklists
A Tasklist is a .yml containing one or more tasks
```yaml
# service_task.yml
---
- name: install service
  apt:
    name: "{{service_name}}"
    state: present
- name: enable service
  service:
    name: "{{service_name}}"
    state: started
    enabled: yes
```



Tasklists can also be included optionally overriding their parameters
```yaml
- hosts: webservers
  tasks:
    - include: service_task.yml
      vars:
        service_name: my_service
```



Tasklist includes can also be looped
```yaml
- hosts: webservers
  tasks:
    - include: service_task.yml service_name={{item}}
      with_items:
        - nginx
        - mysql
```



### Vars
Vars can be included anywhere with `include_vars` module

For example
```yaml
# vars/services.yml
---
- nginx
- mysql
```

```yaml
- hosts: webservers
  include_vars:
    file: vars/services.yml
    name: services
  tasks:
    - include: service_task.yml service_name={{item}}
      with_items: "{{services}}"
```



## Architecture
Examples of structuring your Ansible site




```
├── production        # inventory file for production servers
├── staging           # inventory file for staging environment
│
├── group_vars
│   ├── group1        
│   └── group2        
├── host_vars
│   ├── hostname1     
│   └── hostname2     
│
├── site.yml          # master playbook
├── webservers.yml    # playbook for webserver tier
├── dbservers.yml     # playbook for dbserver tier
│
└── roles
    ├── common
    └── webtier
```



```
├── inventories
│   ├── production
│   │   ├── hosts
│   │   ├── group_vars
│   │   │   ├── group1
│   │   │   └── group2
│   │   └── host_vars
│   │       ├── hostname1
│   │       └── hostname2
│   │
│   └── staging
│       ├── hosts
│       ├── group_vars
│       │   ├── group1
│       │   └── group2
│       └── host_vars
│           ├── stagehost1
│           └── stagehost2
│    
├── site.yml
├── webservers.yml
├── dbservers.yml
│
└── roles
    ├── common
    ├── webtier
    ├── monitoring
    └── fooapp
```



Note that vars includes and tasklist into play includes are heavily discouraged.

It's okay to use them during development, but be sure to move them into a role.




## Practice
Roll out an ansible playbook with:
* Nginx as front-tier cache
* Apache with php-fpm
* Mysql
* A default WordPress installation
* UFW Firewall




## What to go for



[Ansible Docs](http://docs.ansible.com/ansible/latest/index.html)

Skim through modules list, there are a lot of unexpected pleasantries



Learn about typical deployment paths for:
* JavaEE
* Node.js
* Python
* Ruby
* PHP
* Golang



Learn about logging and monitoring solutions:
* ELK Stack
* Nagios
* Grafana + Zabbix



Learn about what DevOps became for industry leaders:

[Site Reliability Engineering](https://landing.google.com/sre/book/index.html)
