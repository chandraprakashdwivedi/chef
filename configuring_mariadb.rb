node.default[‘mariadb’][‘root’][‘password’] = ’admin@123’   # mariadb root password act as the key for mariadb passoword
node.default[‘mariadb’][‘database’][‘name’] = ’codeignitor’
node.default[‘mariadb’][‘database’][‘user’] = ’webuser’
node.default[‘mariadb’][‘database’][‘password’] = ’password@123’

bash ‘configure mariadb‘ do
	code <<-EOT
   	mysqladmin -u root -p  ‘#{node[‘mariadb’][‘root’][‘password’] }’
mysqladmin -u root -p '#{node[‘mariadb’][‘root’][‘password’] }’ -e
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

##Antother method of passing SQL queries using "templates" ##
#Look for this template inside chef repository "codeignitor.sql.erb"

template '/tmp/codeignitor.sql'  do		#Here the sql file is generate inside /tmp/codeignitor.sql
	sorce 'codeignitor.sql.erb'
	variables ({
		:database_name 	 	=> node[‘mariadb’][‘database’][‘name’],
		:database_user 		=> node[‘mariadb’][‘database’][‘user’]
		:database_password 	=> node[‘mariadb’][‘database’][‘password’]
		})
end

#Now import the codeignitor.sql file into database#

execute "configure codeignitor database" do
	command "mysql -u root -p#{node[‘mariadb’][‘root’][‘password’]} < /tmp/codeignitor.sql"
end
