Vagrant.configure("2") do |config|

  config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']

  ## VM definition
  config.vm.define "injector.example.com" do |injector|
    injector.vm.box = "centos66"
    injector.vm.hostname = "injector.example.com"
    injector.vm.network :public_network,
                         :dev => "br0",
                         :mode => "bridge",
                         :type => "bridge",
                         :ip => "172.16.24.137"
    ## Shell provisionning
    injector.vm.provision "shell" do |shell|
      shell.path = "vagrant/bootstrap.sh"
      shell.args = "172.16.24.1 eth1"
    end

    ## Installing obm-loadtest
    injector.vm.provision "shell" do |shell|
      shell.path = "vagrant/injector.sh"
    end
  end
  
  ## VM definition
  config.vm.define "obm3.example.com" do |obm3|
    obm3.vm.box = "centos66"
    obm3.vm.hostname = "obm3.example.com"
    obm3.vm.network :public_network,
                         :dev => "br0",
                         :mode => "bridge",
                         :type => "bridge",
                         :ip => "172.16.24.133"
    ## Shell provisionning
    obm3.vm.provision "shell" do |shell|
      shell.path = "vagrant/bootstrap.sh"
      shell.args = "172.16.24.1 eth1"
    end
  end

  ## VM definition
  config.vm.define "opush3.example.com" do |opush3|
    opush3.vm.box = "centos66"
    opush3.vm.hostname = "opush3.example.com"
    opush3.vm.network :public_network,
                         :dev => "br0",
                         :mode => "bridge",
                         :type => "bridge",
                         :ip => "172.16.24.134"
    ## Shell provisionning
    opush3.vm.provision "shell" do |shell|
      shell.path = "vagrant/bootstrap.sh"
      shell.args = "172.16.24.1 eth1"
    end
  end

  ## VM definition
  config.vm.define "cassandra1.example.com" do |cassandra1|
    cassandra1.vm.box = "centos66"
    cassandra1.vm.hostname = "cassandra1.example.com"
    cassandra1.vm.network :public_network,
                         :dev => "br0",
                         :mode => "bridge",
                         :type => "bridge",
                         :ip => "172.16.24.135"
    ## Shell provisionning
    cassandra1.vm.provision "shell" do |shell|
      shell.path = "vagrant/bootstrap.sh"
      shell.args = "172.16.24.1 eth1"
    end
  end

  ## VM definition
  config.vm.define "cassandra2.example.com" do |cassandra2|
    cassandra2.vm.box = "centos66"
    cassandra2.vm.hostname = "cassandra2.example.com"
    cassandra2.vm.network :public_network,
                         :dev => "br0",
                         :mode => "bridge",
                         :type => "bridge",
                         :ip => "172.16.24.136"
    ## Shell provisionning
    cassandra2.vm.provision "shell" do |shell|
      shell.path = "vagrant/bootstrap.sh"
      shell.args = "172.16.24.1 eth1"
    end
    ## Ansible/obm-deploy provisionning
    cassandra2.vm.provision :ansible do |ansible|
      ansible.host_key_checking = false
      ansible.verbose = "vvvv"
      ansible.inventory_path = "inventory"
      ansible.playbook = "obm.yml"
      ansible.extra_vars = { ansible_ssh_user: 'root' }
      # Disable default limit (required with Vagrant 1.5+)
      ansible.limit = 'all'
    end
  end

  ## Libvirt provider global configuration
  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.memory = 2048
    libvirt.graphics_type = "spice"
    libvirt.host = "virt-obm-hp-01.obm-int.dc1"
    libvirt.connect_via_ssh = true
    libvirt.username = "virt"
    libvirt.id_ssh_key_file = "id_rsa"
    libvirt.management_network_name = "vagrant-libvirt"
    libvirt.management_network_address = "192.168.99.0/24"
  end

  ## synced folder configuration
  config.vm.synced_folder "vagrant", "/vagrant", type: "rsync"

end
