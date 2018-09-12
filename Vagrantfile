# -*- mode: ruby -*-
# vi: set ft=ruby :

system("./config.sh >/dev/null")

$spectre_report = <<SCRIPT
# run only when BUILD_SPECTRE is true
if [ -z ${BUILD_SPECTRE:-} ]; then
	echo "BUILD_SPECTRE was not set. Skipping report ..."
else
	if [ "$BUILD_SPECTRE" = false ]; then
		echo "BUILD_SPECTRE set to FALSE. Skipping report ..."
	else
		echo "BUILD_SPECTRE set to TRUE. Reporting actual status ..."
		# ensure we have mounted our boot partition
		sudo mount /boot
		# report status
		sudo spectre-meltdown-checker -v 2>/dev/null || true
	fi
fi
SCRIPT

$script_cleanup = <<SCRIPT
# stop rsyslog and postfix to allow zerofree to proceed
sudo /etc/init.d/rsyslog stop
sudo /etc/init.d/postfix stop
# /boot (initially not mounted)
sudo mount -o ro /dev/sda1
sudo zerofree /dev/sda1
# /
sudo mount -o remount,ro /dev/sda4
sudo zerofree /dev/sda4
# swap
sudo swapoff /dev/sda3
sudo bash -c 'dd if=/dev/zero of=/dev/sda3 2>/dev/null' || true
sudo mkswap /dev/sda3
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.hostname = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "#{ENV['BUILD_GUEST_MEMORY']}"
    vb.cpus = "#{ENV['BUILD_GUEST_CPUS']}"
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]
    vb.customize ["modifyvm", :id, "--vram", "12"]
    vb.customize ["modifyvm", :id, "--vrde", "off"]
    vb.customize ["modifyvm", :id, "--hpet", "on"]
    vb.customize ["modifyvm", :id, "--spec-ctrl", "on"]
  end
  config.ssh.pty = true
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provision "spectre-report", type: "shell", inline: $spectre_report, env: {"BUILD_SPECTRE" => "#{ENV['BUILD_SPECTRE']}"}
  config.vm.provision "cleanup", type: "shell", inline: $script_cleanup
end
