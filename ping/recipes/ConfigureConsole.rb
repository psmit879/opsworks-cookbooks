#https://github.com/adamsb6/s3_file
s3_file '/var/ping/pingfederate-8.1.2/pingfederate/server/default/data/drop-in-deployer/data.zip' do
  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/pingfederate-data-04-14-2016.zip'
  bucket "colonysecurity-apps"
  remote_path "/PINGFed/pingfederate-data-04-18-2016.zip"
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/pingfederate/server/default/data/drop-in-deployer/data.zip') }
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
  not_if { ::File.exists?('/var/ping/pingfederate/server/default/conf/pingfederate.lic') }
end
