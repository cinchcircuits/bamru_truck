# Bamru Truck Wifi Hotspot and Microserver

This guide assumes you've got an Ubuntu laptop with an SD card reader/writer,
and a RPi2 with a USB-WIFI device that runs in master mode.

Github Repo: `https://github.com/cinchcircuits/bamru_truck.git`

The key tools we use to build and maintain the Hotspot:
```
+-------------------+-------------------------------+
| Function          | Tool                          |
+-------------------+-------------------------------+
| RPi configuration | Ansible                       |
| Scripting         | Bash                          |
| Web-Admin UI      | Ruby / Sinatra                |
| Remote pairing    | Tmux / Vim / Wemux            |
+-------------------+-------------------------------+
```

## New RPi Setup

1) load Raspian onto a SD card

https://www.raspberrypi.org/documentation/installation/installing-images/README.md

2) boot the new RPi

3) set the passwd of the 'pi' user to 'pi'

4) enable SSH on the RPi

5) choose a unique hostname & setup DNS or /etc/hosts with the RPi name/address

6) plug in the USB-WIFI and an ethernet cable

7) now you should be able to `ssh pi@<hostname>`

ProTip: create a reusable OS image pre-configured with passwords and account
settings.  Ask Andy for more info.

## Ansible Configuration

1) install latest version of Ansible to your Ubuntu laptop

http://docs.ansible.com/intro_installation.html#latest-releases-via-apt-ubuntu

2) clone the repo and CD to the `playbooks` directory

3) edit `inventory/hosts-<your_username>.ini` - add the RPi hostname and SSID

4) run `./config` to load a bunch of software and configure the hotspot

Notes:
- user-account passwords will be set to 'BamruTruck'

## Using the RPi hotspot

1) You should see the RPi SSID on your laptop network chooser

2) RPi Wifi Passwd is `werescue`

3) You should connect and get a IP address (view with `ifconfig`)

4) Your wifi connection speed should be as good as a commercial hotspot

## Adding a GPS to your hotspot

1) https://github.com/cinchcircuits/bamru_truck/blob/master/playbooks/roles/gpsd

## Adding and using a 2g/3g/4g cell modem to your device

1) https://github.com/cinchcircuits/bamru_truck/tree/master/playbooks/roles/cell_modem_support

## How to Contribute

You'll need a GitHub account, Ubuntu, Command Line savvy, networking skills,
Raspberry Pi know-how, and basic coding skills (HTML, CSS, JS, Ruby).

[Contributing](./docs/Contributing.md)

[Development Notes](./docs/Notes.md)

[Pair Programming](./docs/PairProgramming.md)

[Jenkins](./docs/Jenkins.md)

[Configuring Hostapd and DnsMasq](./docs/HostapdDnsmasq.md)
