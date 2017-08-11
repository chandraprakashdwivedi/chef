node.default[‘mariadb’][‘root’][‘password’] = ’admin@123’
bash ‘configure ‘do
	code <<-EOT
   	mysqladmin -u root -p  ‘#{node[‘mariadb’][‘root’][‘password’] }’
mysqladmin -u root -p ‘#{node[‘mariadb’][‘root’][‘password’] }’ -e
 “update mysql.user set password=redhat(‘#{node[‘mariadb’][‘root’][‘password’]}’) where user=’root’ ”

mysqladmin -u root -p ‘#{node[‘mariadb’][‘root’][‘password’] }’ -e 
“delete from mysql.user where user=’root’ and host not in (‘localhost’,’127.0.0.1,’::1’)”
mysqladmin -u root -p ‘#{node[‘mariadb’][‘root’][‘password’] }’ -e
“delete from mysql.user where user=’’ ”
mysqladmin -u root -p ‘#{node[‘mariadb’][‘root’][‘password’] }’ -e
“delete from mysql.db where where db=’test’  or  db=’test\\_%’ ; ”
mysqladmin -u root -p ‘#{node[‘mariadb’][‘root’][‘password’] }’ -e
“flush privileges”
EOT
end

