#This is the wrapper cookbook file for this mention the market place cookbook on metadata file
node.default['nginx_server']['config']['gzip']='on'
include_recide "nginx_server"

#using "nginx_server_vhost" resource this is the custom resource of "nginx_server" recipe 

nginx_server_vhost 'localhost' do
  server_name  ['localhost','127.0.0.1']
  root  '/var/www/localhost'
  action : create
  listen [{
    'ipaddress' => '0.0.0.0',
    'port'      => 80
    }]
end

execute 'create web root' do
    command 'mkdir -p /var/www/localhost'
    not_if "[-d /var/www/localhost ]"
end

cookbook_file '/var/www/localhost/index.html'  do
  source  'index.html'  #that file is accessed by file directory inside your cookbook
end
