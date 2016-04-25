directory 'C:\tmp' do
  inherits true
  action :create
  not_if { ::File.exists?('C:\tmp') }
end

directory 'C:\tmp\vShell' do
  inherits true
  action :create
  not_if { ::File.exists?('C:\tmp\vShell') }
end

s3_file 'C:\tmp\vShell\vShellInstall.zip' do
  bucket "colonysecurity-apps"
  remote_path "/vShell/vShellInstall.zip"
  owner 'Administrator'
  group 'Administrators'
  action :create
  not_if { ::File.exists?('C:\tmp\vShell\vShellInstall.zip') }
end

windows_zipfile 'C:\tmp\vShell' do
  source 'C:\tmp\vShell\vShellInstall.zip'
  action :unzip
  not_if { ::File.exists?('C:\tmp\vShell\vShellInstall') }
end

#package 'vShell' do
#  action :install
#  options '/s /v"qn"'
#  source 'C:\tmp\vShell\vShellInstall\vshell-ftps-x64.4.2.0.980.exe'
#  installer_type "installshield"
#  not_if { ::File.exists?('C:\Program Files\VShell') }
#end
execute 'apache_configtest' do
  command 'C:\tmp\vShell\vShellInstall\vshell-ftps-x64.4.2.0.980.exe /s /v"/qn"'
end
