property :rootpath, String, default: '/var/www/localhost'
action : create do
  execute "create directory" do
    command "mkdir -p #{rootpath}"
    not_if " -d #{rootpath}"
  end
  cookbook_file "#{rootpath}/index.html" do
    source "index.html"
  end
end

action : delete do
  execute "rm -rf #{rootpath}"
  not_if "[ -d #{rootpath} ]"
end
