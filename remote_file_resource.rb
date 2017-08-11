#Chef uses remote_file resource to download the remote file

remote_file '/tmp/codeignitor_source.zip' do
  source "https://github.com/bcit-ci/CodeIgniter/tree/3.1.4.zip"
end

#Now hosting a codeignitor in apache

bash  "unzip codeignitor" do
  code <<-EOT
  rm -rf /var/www/html/{*,.*}
  unzip /tmp/codeignitor_source.zip  -d  /tmp/
  mv /tmp/CodeIgnitor-*/{*,.*}  /var/www/html/
  EOT
end
