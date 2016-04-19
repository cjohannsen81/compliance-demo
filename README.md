# compliance-demo

Version 0.6

This Vagrantfile creates a Chef Compliance demo environment using Vagrant. It deploys chef-compliance and configures the server and the nodes.

Just clone the repository and start is using "vagrant up".


The nodes will be:

chef-compliance     Ubuntu	192.168.1.10

chef-node01	    Ubuntu	192.168.1.11  
chef-node02	    Windows	192.168.1.12  

It also copies the profiles folder into tmp on the chef-compliance machine. Feel free to commit.

Have a look at the project wiki how to use the demo.
