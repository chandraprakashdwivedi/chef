%w(httpd mariadb-server ).each  do |p|
package p do
	action : install
end
end

execute “epel” do
	not_if  “rpm  -qa  | grep epel”	   #This is just the condition if the package is install it will neglect
	command “rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm”
end

execute “webtatic” do
	not_if  “rpm  -qa  | grep webtatic”
	command “rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm”
end

#It is another method of mentioning the array list using "%w"
%w(mod_php php-mysql php*).each do |p|
	package p do
		action : install
	end
end


[“httpd”,”mariadb”].each do |p|
	service p do 
		action [:start,:enable]
	end
end


