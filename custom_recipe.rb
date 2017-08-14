property :rootpath, String, default: '/var/www/localhost'

#Here “property” is the variable which we need to define on custom resources “rootpath” is the symbol for the value we pass “string” is the data type of property and default is the value which is to be passed if the user not define any value.
#Now under this property you can create as many actions as you can.

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
