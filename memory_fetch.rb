#node module uses OHAI service to fetch the system information
file “/specs”  do
	content  “#{(node[‘memory’][‘total’][0..-3] .to_f / 1024).round(2) .to_s + “Mb \n” }”
end
