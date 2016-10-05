# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  
  if ENV.has_key?("http_proxy")
    if Vagrant.has_plugin?("vagrant-proxyconf")
      config.proxy.http = ENV["http_proxy"]
      config.proxy.https = ENV.has_key?("https_proxy") ? ENV["https_proxy"] : ENV["http_proxy"]
      config.proxy.no_proxy = ENV.has_key?("no_proxy") ? ENV["no_proxy"] : "localhost,127.0.0.1"
    end
	else
	  print " WARN: Missing plugin 'vagrant-proxyconf'"
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = 3072
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: "/vagrant/provision.sh"
end
