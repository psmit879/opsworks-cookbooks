def opsworks_cookbook(name, version = '>= 0.0.0', options = {})
    cookbook name, version, { path: "opsworks-cookbooks/#{name}" }.merge(options)
end

source "https://supermarket.chef.io"

opsworks_cookbook 'opsworks_initial_setup'
opsworks_cookbook 'ssh_host_keys'
opsworks_cookbook 'ssh_users'
opsworks_cookbook 'mysql'

metadata
