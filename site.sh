#!/bin/bash
set -e

git submodule update --init

chmod o-rwx .
ansible-galaxy install -r requirements.yml

ansible-playbook hcloud.yml

# needs updating for hardening
#ansible-playbook prepare.yml

# needs to be run if workers are added
ansible-playbook ca.yml
ansible-playbook kubelets.yml

ansible-playbook kube-proxy.yml
ansible-playbook kube-controller-manager.yml
ansible-playbook kube-scheduler.yml
ansible-playbook kube-admin-user.yml
ansible-playbook kubeencryptionconfig.yml

ansible-playbook controller.yml
ansible-playbook worker.yml
