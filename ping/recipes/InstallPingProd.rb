include_recipe "s3_file"

execute 'yum update -y'

#package 'java-1.8.0-openjdk'

package 'unzip'

user 'pingfed' do
  comment 'pingfed'
  system true
  home '/home/pingfed'
  shell '/bin/bash'
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

directory '/var/ping' do
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

directory '/home/pingfed' do
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

remote_file '/var/ping/pingfederate-8.1.2.zip' do
  source 'https://s3.amazonaws.com/colonybrands-security-apps/PINGFed/pingfederate-8.1.2.zip'
  owner 'pingfed'
  group 'pingfed'
  mode '0775'
  action :create
  not_if { ::File.exists?('/var/ping/pingfederate-8.1.2.zip') }
end

execute 'extract_ping' do
  command 'unzip pingfederate-8.1.2.zip -d /var/ping'
  cwd '/var/ping'
  not_if { ::File.exists?('/var/ping/configureComplete') }
end

#execute 'move_ping' do
#  command 'mv /var/ping/pingfederate-8.1.2/pingfederate .'
#  cwd '/var/ping'
#end

file '/etc/rc.d/init.d/pingfed' do
  owner 'pingfed'
  group 'pingfed'
  mode '0755'
  content <<-EOH
	#! /bin/sh
   start(){
      echo "starting PingFederate.."
      su - pingfed \\
      -c '/var/ping/pingfederate-8.1.2/pingfederate/sbin/pingfederate-run.sh \\
      > /dev/null 2> /dev/null'
   }
   stop(){
      echo "stopping PingFederate.."
      su - pingfed -c '/var/ping/pingfederate-8.1.2/pingfederate/sbin/pingfederate-shutdown.sh'
   }
   restart(){
      stop
   # padding time to stop before restart
      sleep 60
   # To protect against any services that are not stopped,
   # uncomment the following command.
   # (Warning: this kills all Java instances running as
   # pingfed.)
   #   su - pingfed -c 'killall java'
      start
   }
   case "$1" in
      start)
         start
         ;;
      stop)
         stop
         ;;
      restart)
         restart
         ;;
      *)
      echo "Usage: pingfed {start|stop|restart}"
      exit 1
   esac
   exit 0
   EOH
  action :create
  not_if { ::File.exists?('/var/ping/configureComplete') }
end


#s3_file '/var/ping/pingfederate/server/default/conf/pingfederate.lic' do
#  #source 'https://s3.amazonaws.com/colonysecurity-apps/PINGFed/PingFederate.78200.Development.lic'
#  bucket "colonysecurity-apps"
#  remote_path "/PINGFed/PingFederate.78200.Development.lic"
#  owner 'pingfed'
#  group 'pingfed'
#  mode '0775'
#  action :create
#  not_if { ::File.exists?('/var/ping/pingfederate/server/default/conf/pingfederate.lic') }
#end


script 'start_service' do
  interpreter "bash"
  cwd '/home/ec2-user'
  code <<-EOH
  	ln -s /etc/rc.d/init.d/pingfed /etc/rc3.d/S84pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc5.d/S84pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc4.d/S84pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc6.d/K15pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc0.d/K15pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc1.d/K15pingfed
	ln -s /etc/rc.d/init.d/pingfed /etc/rc2.d/K15pingfed
	chmod 755 /etc/rc.d/init.d/pingfed
	#service pingfed start
	chown -R pingfed /var/ping/pingfederate-8.1.2
  	EOH
  not_if { ::File.exists?('/var/ping/configureComplete') }
end
