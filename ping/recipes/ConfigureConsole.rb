#https://github.com/adamsb6/s3_file
file '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties' do
  action :delete
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

file '/var/ping/pingfederate-8.1.2/pingfederate/bin/ldap.properties' do
  action :delete
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/tcp.xml' do
  action :delete
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/tcp.xml' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/tcp.xml'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/tcp.xml"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/PingIDRadiusPCV-1.3.0.jar' do
  bucket "colony-security-apps"
  remote_path "/PINGFed/PingIDRadiusPCV-1.3.0.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/pf-pingid-idp-adapter-1.3.1.jar' do
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/pf-pingid-idp-adapter-1.3.1.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/gson-2.2.4.jar' do
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/gson-2.2.4.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/deploy/common-mfa-14.4.7.jar' do
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/common-mfa-14.4.7.jar"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/bin/ldap.properties' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/tcp.xml'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/ldap.properties"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/data/drop-in-deployer/data.zip' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/pingfederate-data-04-14-2016.zip'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/pingfederate-data-05-19-2016DEV.zip"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

#sed -i 's/ADLICENSE="Y"/ADLICENSE="N"/g' centrifydc-install.cfg

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/conf/pingfederate.lic' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/PingFederate.78200.Development.lic'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/PingFederate.78200.Development.lic"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

s3_file '/var/ping/pingfederate-8.1.2/pingfederate/bin/run.properties' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/run.properties'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/run.properties-CONSOLE"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

execute 'chown -R pingfed /var/ping'

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
