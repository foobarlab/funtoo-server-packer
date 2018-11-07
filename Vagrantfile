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
# stop all running services to be able to remount partitions read-only (needed for zerofree)
/etc/init.d/rsyslog stop
/etc/init.d/dhcpcd stop
/etc/init.d/acpid stop
/etc/init.d/udev stop
# mount /boot read-only
mount -o remount,ro /dev/sda1
zerofree -v /dev/sda1
# mount rootfs read-only
mount -o remount,ro /dev/sda4
zerofree -v /dev/sda4
# re-create swap area
swapoff -v /dev/sda3
bash -c 'dd if=/dev/zero of=/dev/sda3 2>/dev/null' || true
mkswap /dev/sda3
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box_check_update = false
  config.vm.box = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.hostname = "#{ENV['BUILD_BOX_NAME']}"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "#{ENV['BUILD_GUEST_MEMORY']}"
    vb.cpus = "#{ENV['BUILD_GUEST_CPUS']}"
    # customize virtualbox settings, see also virtualbox.json
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
    vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
    vb.customize ["modifyvm", :id, "--audio", "none"]
    vb.customize ["modifyvm", :id, "--usb", "off"]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    vb.customize ["modifyvm", :id, "--chipset", "ich9"]
    vb.customize ["modifyvm", :id, "--vram", "12"]
    vb.customize ["modifyvm", :id, "--vrde", "off"]
    vb.customize ["modifyvm", :id, "--hpet", "on"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--vtxvpid", "on"]
    vb.customize ["modifyvm", :id, "--spec-ctrl", "on"]
    vb.customize ["modifyvm", :id, "--largepages", "on"]
  end
  config.ssh.pty = true
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.provision "spectre-report", type: "shell", inline: $spectre_report, env: {"BUILD_SPECTRE" => "#{ENV['BUILD_SPECTRE']}"}
  config.vm.provision "cleanup", type: "shell", inline: $script_cleanup, privileged: true
end
