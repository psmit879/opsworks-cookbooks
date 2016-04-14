execute 'yum update -y'

package 'java-1.8.0-openjdk'

package 'unzip'

remote_file '/var/pingfederate/pingfederate-8.1.2.zip' do
  source 'https://www.pingidentity.com/content/dam/pic/downloads/software/servers/pingfederate-8.1.2.zip'
  owner 'ec2-user'
  group 'ec2-user'
  mode '0755'
  action :create
end

execute 'extract_ping' do
  command 'unzip pingfederate-8.1.2.zip'
  cwd '/var/pingfederate'
end

