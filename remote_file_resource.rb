#Chef uses remote_file resource to download the remote file

remote_file '/tmp/codeignitor_source.zip' do
  source "https://github.com/bcit-ci/CodeIgniter/tree/3.1/stable"
end
