## Ansible playbooks
You can use this command to run deploy_app playbook
It will create database on database hosts and install packages and latest app on web hosts
```
ansible-playbook -l all deploy_app.yml -i dev_hosts  --extra-vars '{"env":"dev"}' --ask-vault-pass
```


This one can be used to install packages and latest app on hosts
```
ansible-playbook -l all app_install.yml -i dev_hosts
```
This one for creating and configuring database on hosts
```
ansible-playbook -l all db_install.yml -i dev_hosts  --extra-vars '{"env":"dev"}' --ask-vault-pass
```

Vault pass is "asdfasdf"
