[web]

%{ for i in range(length(app_names)) ~}
${app_names[i]} ansible_host=${app_ips[i]} ansible_user=${user}
%{ endfor ~}

[db]

%{ for i in range(length(db_names)) ~}
${db_names[i]} ansible_host=${db_ips[i]} ansible_user=${user}
%{ endfor ~}
