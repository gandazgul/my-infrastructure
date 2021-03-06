#!/bin/bash

printf "\nInstall Virtualization ====================================================================================\n"
sudo dnf install -y @virtualization
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

printf "\nInstall Cockpit support for KVM ===========================================================================\n"
sudo dnf install -y cockpit-machines
sudo systemctl restart cockpit.service

# TODO: Install the windows machine
