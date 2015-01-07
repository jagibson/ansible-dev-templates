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
