# Rolling releases with Ansible

Your task is creating an ansible playbook that manages zero-downtime deployment of a sample Node.js application.

## Setting up
Provided `Vagrantfile` defines 5 boxes by default:
* A `command` box from which you will run ansible (hostname: command, ip: 10.0.15.10)
* A `lb` box that will serve as load balancer (hostname: lb, ip: `10.0.15.11`)
* 3 `app` boxes (`app1`, `app2`, `app3`) that will serve the application itself (hostname: appN, ip: 10.0.15.2N)

Your initial task is:
* Set up a `nginx` or `haproxy` load balancer
* Deploy [sample Node.js application](https://bitbucket.org/ZaRDaK/devops-rolling-release) to app servers
* Wire everything up

## Rolling release
1. Take app server off load balancer
2. Stop the application
3. Update the application
4. Start the application
5. Ensure the application started correctly
6. Add app server to load balancer

If any step fails, abort the whole play

To test this, use `ab` command to simulate many requests while deploying:
```bash
ab -n <Toal number of requests> -c <Number of concurrent requests> <Load balancer ip>
```
