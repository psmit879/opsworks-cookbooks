#execute 'rm -f /var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/tcp.xml'

#execute 'rm -f /var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties'
file '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties' do
  action :delete
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/tcp.xml' do
  action :delete
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/tcp.xml' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/tcp.xml'
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/tcp.xml-PROD"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/pf-pingid-idp-adapter-1.3.1.jar' do
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/pf-pingid-idp-adapter-1.3.1.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/gson-2.2.4.jar' do
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/gson-2.2.4.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/common-mfa-14.4.7.jar' do
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/common-mfa-14.4.7.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/PingIDRadiusPCV-1.3.0.jar' do
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/PingIDRadiusPCV-1.3.0.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/run.properties'
  bucket "colonybrands-security-apps"
  remote_path "/PINGFed/run.properties-PRODENGINE"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

#execute 'sed -i 's/pf.cluster.node.index=8/pf.cluster.node.index=10/g' /var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties'
template '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties' do
  source '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties'
  local true
  variables({
    :clusterID => Random.rand(65534)
  })
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

file '/var/ping/configureComplete' do
  content 'This is a flag that prevents the configure recipe from running a 2nd time'
  mode '0775'
  owner 'pingfed'
  group 'pingfed'
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

#execute 'service pingfed start'
service "pingfed" do
  action :start
end
