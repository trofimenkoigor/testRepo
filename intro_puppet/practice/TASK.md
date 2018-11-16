# Puppet practice

Configure a basic LAMP stack running Wordpress using masterless puppet.

## Setting up

```bash
vagrant up
vagrant ssh
cd /vagrant/site
sudo puppet apply site.pp
```

Then, start editing the `site/site.pp` manifest to complete the task.