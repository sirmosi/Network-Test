Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  #disable automatic update
  config.vm.box_check_update = false
  #disable autoconfigure network 
  config.vm.network "private_network", virtualbox__intnet: "vagrant-intnet-1", auto_config: false
  config.vm.network "private_network", virtualbox__intnet: "vagrant-intnet-2", auto_config: false
  #config.vm.network "public_network", use_dhcp_assigned_default_route: true, bridge: "wlo1"
  #defining Mikrotik VMs,Networks and ...
  config.vm.define "ca" do |ca|
    ca.vm.box = "cheretbe/routeros"
    ca.vm.hostname = "customer-A"
    #make customer networking_and_nat_and_default_route
    ca.vm.network "private_network", ip: "192.168.10.10/24", virtualbox__intnet: true, virtualbox__intnet: "ca-to-internet", auto_config: false
    ca.vm.provision "routeros_command", name: "nat", command: "/ip firewall nat add chain=srcnat src-address=192.168.10.10/24 action=masquerade"
    ca.vm.provision "routeros_command", name: "route", command: "/ip route add dst-address=0.0.0.0/0 gateway=192.168.10.1"
  end
  config.vm.define "cb" do |cb|
    cb.vm.box = "cheretbe/routeros"
    cb.vm.hostname = "customer-B"
    #make customer networking_and_nat_and_default_route
    cb.vm.network "private_network", ip: "192.168.20.10",virtualbox__intnet: true, virtualbox__intnet: "cb-to-internet", auto_config: false
    cb.vm.provision "routeros_command", name: "nat", command: "/ip firewall nat add chain=srcnat src-address=192.168.20.10/24 action=masquerade"
    cb.vm.provision "routeros_command", name: "route", command: "/ip route add dst-address=0.0.0.0/0 gateway=192.168.20.1"
  end
  config.vm.define "vr1" do |vr1|
    vr1.vm.box = "cheretbe/routeros"
    vr1.vm.hostname = "VRRP-A"
    #configure vrrp-1 router network initialize
    vr1.vm.network "private_network", ip: "192.168.10.1/24",virtualbox__intnet: true, virtualbox__intnet: "ca-to-internet", auto_config: false
    vr1.vm.provision "routeros_command", name: "bridge", command: "/interface bridge add bridge=outside_vrrp1"
    vr1.vm.provision "routeros_command", name: "bridge_port", command: "/interface bridge port add bridge=outside_vrrp1 interface=ether4,ether5"
    vr1.vm.provision "routeros_command", name: "nat", command: "/ip firewall nat add chain=srcnat src-address=10.10.1.0/24 action=masquerade"
    vr1.vm.provision "routeros_command", name: "route", command: "/ip route add dst-address=0.0.0.0/0 gateway=10.10.1.100"
  end
  config.vm.define "vr2" do |vr2|
    vr2.vm.box = "cheretbe/routeros"
    vr2.vm.hostname = "VRRP-B"
    #configure vrrp-2 router network initialize
    vr2.vm.network "private_network", ip: "192.168.2.254",virtualbox__intnet: true, virtualbox__intnet: "ca-to-internet", auto_config: false
    vr2.vm.provision "routeros_command", name: "bridge", command: "/interface bridge add bridge=outside_vrrp2"
    vr2.vm.provision "routeros_command", name: "bridge_port", command: "/interface bridge port add bridge=outside_vrr2 interface=ether4,ether5"
    vr2.vm.provision "routeros_command", name: "nat", command: "/ip firewall nat add chain=srcnat src-address=10.20.1.0/24 action=masquerade"
    vr2.vm.provision "routeros_command", name: "route", command: "/ip route add dst-address=0.0.0.0/0 gateway=10.20.1.100"
  end
  config.vm.define "b1" do |b1|
    b1.vm.box = "cheretbe/routeros"
    b1.vm.hostname = "Building-A"
    #upload rsc file and import configuration
    b1.vm.provision "routeros_file", name: "Upload", source: "building-a.rsc", destination: "building-a.rsc"
    b1.vm.provision "routeros_command", name: "Run", command: "/import building-a.rsc", check_script_error: true
    #Add 2 nic as VRRP interface
    b1.vm.network "private_network",virtualbox__intnet: true, virtualbox__intnet: "building-1", auto_config: false
    b1.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "building-2", auto_config: false 
    #Add 2 nic for connecting to ISPs
    b1.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp1", auto_config: false
    b1.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp1", auto_config: false
  end
  config.vm.define "b2" do |b2|
    b2.vm.box = "cheretbe/routeros"
    b2.vm.hostname = "Building-B"
    #upload rsc file and import configuration
    b2.vm.provision "routeros_file", name: "Upload", source: "building-b.rsc", destination: "building-b.rsc"
    b2.vm.provision "routeros_command", name: "Run", command: "/import building-b.rsc", check_script_error: true
    #Add 2 nic as VRRP interface
    b2.vm.network "private_network",virtualbox__intnet: true, virtualbox__intnet: "building-1", auto_config: false
    b2.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "building-2", auto_config: false 
    #Add 2 nic for connecting to ISPs
    b2.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp2", auto_config: false
    b2.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp2", auto_config: false
  end
  config.vm.define "isp1" do |isp1|
    isp1.vm.box = "cheretbe/routeros"
    isp1.vm.hostname = "ISP-A"
    #upload rsc file and import configuration
    isp1.vm.provision "routeros_file", name: "Upload", source: "ISP-A.rsc", destination: "ISP-A.rsc"
    isp1.vm.provision "routeros_command", name: "Run", command: "/import ISP-A.rsc", check_script_error: true
    isp1.vm.network "private_network",virtualbox__intnet: true, virtualbox__intnet: "isp1", auto_config: false
    isp1.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp2", auto_config: false 
    isp1.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "internet", auto_config: false
  end
  config.vm.define "isp2" do |isp2|
    isp2.vm.box = "cheretbe/routeros"
    isp2.vm.hostname = "ISP-B"
    #upload rsc file and import configuration
    isp2.vm.provision "routeros_file", name: "Upload", source: "ISP-B.rsc", destination: "ISP-B.rsc"
    isp2.vm.provision "routeros_command", name: "Run", command: "/import ISP-B.rsc", check_script_error: true
    isp2.vm.network "private_network",virtualbox__intnet: true, virtualbox__intnet: "isp1", auto_config: false
    isp2.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "isp2", auto_config: false 
    isp2.vm.network "private_network", virtualbox__intnet: true, virtualbox__intnet: "internet", auto_config: false
  end
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "128"
    vb.cpus = "1"
  end
end
