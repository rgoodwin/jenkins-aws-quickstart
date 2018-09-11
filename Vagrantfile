# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "bento/centos-7.5"

    config.vm.network "forwarded_port", guest: 8080, host: 8080
    config.vm.hostname = "jenkins"

    config.vm.network "private_network", ip: "192.168.33.10"

    config.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "jenkins-jumpstart-playbook.yaml"
    end

end
