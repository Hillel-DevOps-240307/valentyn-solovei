[web]

%{ for i in range(length(app_names)) ~}
${app_names[i]} ansible_host=${app_ips[i]} ansible_user=${user}
%{ endfor ~}

[db]

%{ for i in range(length(tolist([db_names]))) ~}
${tolist([db_names])[i]} ansible_user=${user}
%{ endfor ~}

[db:vars]
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ubuntu@${app_names[0]}"'
