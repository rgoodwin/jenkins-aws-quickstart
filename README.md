### Overview

This terraform and ansible code gets a jenkins master and slave up and running quickly. 
It's automatic but uses basic configuration and jenkins security.

The jenkins master and slave are run via docker containers. See: [master container](https://github.com/rgoodwin/jenkins-master-preconfigured)
and [slave container](https://github.com/rgoodwin/docker-centos-jenkins-swarm-slave) for info.

Generally, this is meant to serve as an example for customization.

#### Quick Start

Launch the infrastructure using terraform

```bash
cd provision-terraform
terraform apply
```

Run ansible playbook to provision 

```bash
cd ..
ansible-playbook jenkins-jumpstart-playbook.yaml -i ec2.py -u ec2-user --limit tag_Name_jenkins_master
```

When this is all done you can login to http://<ip of new jenkins host>:8080 using admin/admin

#### Details

This will provision one server in your default VPC in the AWS region you have set as the default. It assumes you have
terraform setup and your aws credentials setup.

It then runs a jenkins master and a slave (which is tagged to build docker containers). You can launch more slaves on
the same or other hosts to quickly setup a jenkins build cluster.

The ansible playbook should run. But, will required whatever ssh key you passed to terraform, as well as it assumes you
have the ec2.py dynamic inventory configured for ansible.

#### Development

The included Vagrant file can be used for testing ansible provisioning of the host and containers locally