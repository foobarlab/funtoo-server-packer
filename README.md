# Funtoo Server Vagrant box

This is a basic server-flavored core Funtoo Linux that is packaged into a Vagrant box file. Currently only a VirtualBox version is provided.
It is based on the [Funtoo Core Vagrant box](https://github.com/foobarlab/funtoo-core-packer) and can be used for bootstrapping your own box.

### What's included?

 - Minimal Funtoo Linux installation with server flavor
 - Architecture: pure64, generic_64 (currently only on Intel CPU, no AMD support)
 - 100 GB dynamic sized HDD image (ext4)
 - Timezone: ```UTC```
 - NAT Networking using DHCP (virtio)
 - Vagrant user *vagrant* with password *vagrant* (can get superuser via sudo without password), additionally using the default SSH authorized keys provided by Vagrant (see https://github.com/hashicorp/vagrant/tree/master/keys) 
 - Kernel and GCC taken from [core box](https://github.com/foobarlab/funtoo-core-packer)
 - List of additional installed software:
    - Services: *rsyslog* for logging
    - *spectre-meltdown-checker* for mitigation detection
    - *ansible* for automation tasks
    - Plus any additional software installed in the [core box](https://github.com/foobarlab/funtoo-core-packer)

### Download pre-build images

Get the latest build from Vagrant Cloud: [foobarlab/funtoo-server](https://app.vagrantup.com/foobarlab/boxes/funtoo-server)

### Build your own using Packer

#### Preparation

 - Install [Vagrant](https://www.vagrantup.com/) and [Packer](https://www.packer.io/)

#### Build a fresh Virtualbox box

 - Run ```./build.sh```

#### Quick test the box file

 - Run ```./test.sh```

#### Upload the box to Vagrant Cloud (experimental)

 - Run ```./upload.sh```

### Regular use cases

#### Initialize a fresh box (initial state, any modifications are lost)

 - Run ```./init.sh```

#### Power on the box (keeping previous state) 

 - Run ```./startup.sh```

### Special use cases

#### Show current build config

 - Run ```./config.sh```

#### Cleanup build environment (poweroff all Vagrant and VirtualBox machines)

 - Run ```./clean_env.sh```

#### Generate Vagrant Cloud API Token

 - Run ```./vagrant_cloud_token.sh```

#### Keep only a maximum number of boxes in Vagrant Cloud (experimental)

 - Run ```./clean_cloud.sh```

## Feedback welcome

Please create an issue.
