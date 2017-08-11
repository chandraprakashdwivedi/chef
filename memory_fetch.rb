file “/specs”  do
	content  “#{(node[‘memory’][‘total’][0..-3] .to_f / 1024).round(2) .to_s + “Mb \n” }”
end
