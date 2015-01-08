ansible-dev-templates
=====================

Templates for ansible development.

`localenv`: Supporting code necessary to help provide a Vagrant environment for local development, applicable both to playbooks and roles

`role`: Files necessary for a role, taken pretty much exactly from `ansible-galaxy init` 

`playbook`: Files to get started developing a playbook

`init.rb`: Method to automatically apply templates to a given ditectory

## Using `init.rb`

`init.rb` simply nondestructively copies the appropriate templates from the directories in this repository to a destination repository.  

`init.rb` *destination* `{playbook|role}`

will create a structure for either a role or a playbook in the specified destination directory.

## Rebuild a box eg for updates

Let's say you need to update your box, say because `kitchen-ansible` isn't doing an `apt-get update` before 
trying to install things, your box is too old, but a new box hasn't been published by opscode.

In that casse , the box would be called 'opscode-ubuntu-14.04' by default

If you need to create a new box for kitchen, try something like this:

1. start up the box, `kitchen converge`.  It doesn't matter if it's failing.
1. `kitchen login`, `sudo` and 
  1. apt-get remove ansible
  1. apt-get update 
  1. apt-get install -y software-properties-common
  1. apt-add-repository ppa:ansible/ansible
  1. apt-get install ansible
  You should have 1.8.2 now.  
1. ` cd ./kitchen/kitchen-vagrant/default-ubuntu-1404`
1. `vagrant box remove opscode-ubuntu-14.04`
1. Package the box you just started with `vagrant package --output sps-ubuntu-1404.box`
1. Add the package in under the old box name.  
  `vagrant box add --name opscode-ubuntu-14.04 sps-ubuntu-1404.box`
1. `kitchen destroy`
1. `kitchen converge`

You should be converging on the right version of ansible now.  
