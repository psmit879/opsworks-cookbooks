execute 'yum update -y'

package 'java-1.8.0-openjdk'

package 'unzip'

directory '/var/pingfederate' do
  owner 'ec2-user'
  group 'ec2-user'
  mode '0755'
  action :create
end

remote_file '/var/pingfederate/pingfederate-8.1.2.zip' do
  source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/pingfederate-8.1.2.zip'
  owner 'ec2-user'
  group 'ec2-user'
  mode '0755'
  action :create
end

execute 'extract_ping' do
  command 'unzip pingfederate-8.1.2.zip'
  cwd '/var/pingfederate'
end
