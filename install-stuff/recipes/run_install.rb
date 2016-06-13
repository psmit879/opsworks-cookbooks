
execute 'Get Vagrant' do
	command 'wget https://releases.hashicorp.com/vagrant/1.8.3/vagrant_1.8.3_x86_64.rpm'
	creates 'vagrant_1.8.3_x86_64.rpm'
end 

execute 'Install Vagrant via RPM'	do
	command 'rpm -i vagrant_1.8.3_x86_64.rpm'
end

execute 'install aws plugin' do
	command 'vagrant plugin install vagrant-aws'
end 

script "Mod yum" do 
	interpreter "bash"
	code <<-EOH
		# sed '/Pattern/a [el5_addons]
# name=Enterprise Linux $releasever - $basearch - addons
# baseurl=http://public-yum.oracle.com/repo/EnterpriseLinux/EL5/addons/$basearch/
# gpgcheck=1
# enabled=1
 
# [el5_oracle_addons]
# name=Enterprise Linux $releasever - $basearch - oracle addons
# baseurl=http://public-yum.oracle.com/repo/EnterpriseLinux/EL5/oracle_addons/$basearch/
# gpgcheck=1
# enabled=1' /etc/yum.conf
		echo "[el5_addons]
# name=Enterprise Linux $releasever - $basearch - addons
# baseurl=http://public-yum.oracle.com/repo/EnterpriseLinux/EL5/addons/$basearch/
# gpgcheck=1
# enabled=1
 
# [el5_oracle_addons]
# name=Enterprise Linux $releasever - $basearch - oracle addons
# baseurl=http://public-yum.oracle.com/repo/EnterpriseLinux/EL5/oracle_addons/$basearch/
# gpgcheck=1
# enabled=1 /n" >> /etc/yum.conf
	EOH
end

execute "Install VirtualBox" do
	command 'yum install VirtualBox-5.0'
end
