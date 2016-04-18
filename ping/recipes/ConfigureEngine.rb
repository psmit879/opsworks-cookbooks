execute 'rm /var/ping/pingfederate/server/default/conf/tcp.xml -y'

execute 'rm /var/ping/pingfederate/bin/run.properties -y'

s3_file '/var/ping/pingfederate/server/default/conf/tcp.xml' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/tcp.xml'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/tcp.xml"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  #not_if { ::File.exists?('/var/ping/pingfederate/server/default/data/drop-in-deployer/data.zip') }
end

s3_file '/var/ping/pingfederate/bin/run.properties' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/run.properties'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/run.properties"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  #not_if { ::File.exists?('/var/ping/pingfederate/server/default/conf/pingfederate.lic') }
end
