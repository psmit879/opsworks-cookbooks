execute 'mkdir /home/ec2-user'

package ['wget','perl','ntpdate','bind-utils']

execute 'yum update -y'

script 'join_domain' do
  interpreter "bash"
  cwd '/home/ec2-user'
  code <<-EOH
	wget http://edge.centrify.com/products/centrify-suite/2016/installers/20160315/centrify-suite-2016-rhel4-x86_64.tgz
	gunzip centrify-suite-2016-rhel4-x86_64.tgz
	tar -xf centrify-suite-2016-rhel4-x86_64.tar
	ntpdate ntp01
	sed -i 's/ADLICENSE="Y"/ADLICENSE="N"/g' centrifydc-install.cfg
	sed -i 's/CentrifyDC_openssh="F"/CentrifyDC_openssh="U"/g' centrifydc-install.cfg
	sed -i 's/CentrifyDC_krb5=/CentrifyDC_krb5="U"/g' centrifydc-install.cfg
	./install-express.sh -n
	sed -i 's/# dns.sweep.pattern:.*/dns.sweep.pattern: t5,u5,u10,t10,u10,u10/g' /etc/centrifydc/centrifydc.conf
	sed -i 's/# pam.allow.users:.*/pam.allow.users: file:\/etc\/centrifydc\/users.allow/g' /etc/centrifydc/centrifydc.conf
	sed -i 's/# pam.allow.groups:.*/pam.allow.groups: file:\/etc\/centrifydc\/groups.allow/g' /etc/centrifydc/centrifydc.conf
	sudo touch /etc/centrifydc/users.allow
	sudo touch /etc/centrifydc/groups.allow
	echo smith_p | tee -a /etc/centrifydc/users.allow
	echo SecurityUsers | tee -a /etc/centrifydc/groups.allow
	echo 'smith_p ALL=(ALL:ALL) ALL'|tee -a /etc/sudoers
	echo '%SecurityUsers ALL=(ALL:ALL) ALL'|tee -a /etc/sudoers
	adjoin --user SACentrify --password Ws7N\`\*qhYbKu4j\;cm@=mWaNq= -w sccompanies.com
	reboot
    EOH
end