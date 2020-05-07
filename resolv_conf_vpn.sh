#!/bin/bash

cat ~/scripts/random-scripts/resolv_conf_work_vpn.txt >> ~/scripts/random-scripts/resolv.conf
sudo chown systemd-resolve:systemd-resolve ~/scripts/random-scripts/resolv.conf
sudo chmod 644 ~/scripts/random-scripts/resolv.conf
sudo mv ~/scripts/random-scripts/resolv.conf /run/systemd/resolve/resolv.conf.tmp
sudo rm /run/systemd/resolve/resolv.conf
sudo mv /run/systemd/resolve/resolv.conf.tmp /run/systemd/resolve/resolv.conf
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf