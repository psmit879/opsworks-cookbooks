powershell_script 'configureGateway' do
  code <<-EOH
	New-SelfSignedCertificate -DnsName "RDGateway.sccompanies.com" -CertStoreLocation "Cert:\\LocalMachine\\My"
	Import-Module remotedesktopservices
	new-item -path RDS:\\GatewayServer\\CAP -Name Default-CAP -UserGroups 'Domain Users@Train' -AuthMethod 1
	new-item -Path RDS:\\GatewayServer\\RAP -Name Default-RAP -UserGroups 'Domain Users@Train' -ComputerGroupType 1 -ComputerGroup 'Domain Computers@Train’
	dir cert:\\localmachine\\my | where-object { $_.Subject -eq "CN=rdgateway.sccompanies.com” } | ForEach-Object { Set-Item -Path RDS:\\GatewayServer\\SSLCertificate\\Thumbprint -Value $_.Thumbprint }
	Restart-Service TSGateway

EOH
end
