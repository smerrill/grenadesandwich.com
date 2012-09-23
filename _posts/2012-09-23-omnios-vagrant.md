---
layout: post
title: "OmniOS and Vagrant"
created: 1306726837
categories:
- virtualbox
- virtualization
- vagrant
- illumos
- omnios
---

### <3 ZFS

I've recently gotten religion about ZFS, and as a result, I've been looking hard at the various systems that offer you the ability to use ZFS and other amazing tools from the Solaris lineage (now being developed freely under [the Illumos moniker](http://blog.illumos.org/) after Oracle's unceremonious murder of OpenSolaris.)

My data's backed up on an 8 TB FreeNAS, but there's also an amazing trend of Illumos-based distributions on offer that offer KVM virtualization, which was ported to Illumos by Joyent for [their SmartOS distribution](http://smartos.org/). Theo Schlossnagle recently gave a talk at the NYC DevOps meetup about [their Illumos-based OmniOS distribution](http://omnios.omniti.com/). OmniOS is a bit more than a JeOS - it aims to provide just enough packaged software to let you build the Illumos kernel and several other important tools like tmux and screen, and then get out of your way. Like SmartOS, it provides both lightweight zones-based virtualization and KVM for full hardware virtualization, but OmniOS is designed to be permanently installed on a machine, as opposed to SmartOS's focus on USB or PXE booting and ephemeral global zone configuration.

OmniTI also makes a larger set of packages that their Managed Services team uses at [http://pkg.omniti.com/omniti-ms/en/index.shtml](http://pkg.omniti.com/omniti-ms/en/index.shtml).

### KVM? Not today.

But at the end of the day, [Vagrant](http://vagrantup.com/) is still the platform I use to run applications with the correct operating system, software versions, and production configurations, so I need Vagrant (and thus [VirtualBox](https://www.virtualbox.org/)) to run on my workstation.

I am happy to report that I was able to get VirtualBox and Vagrant to the point that they could boot a box, and use host-only networking despite being a complete UNIX and Solaris noob. (Thanks to Mitchell and the whole Vagrant community for an awesome piece of software.)

### Get it installed

Here's the roundup on how to get it all up and running. All commands were run as root in the global zone.

Install a few utility packages. This is not strictly necessary, but it helps.

    $ pkg install terminal/tmux
    $ pkg install developer/versioning/git

Set up a static IP as pointed out in http://omnios.omniti.com/wiki.php/GeneralAdministration. In my case, it was 192.168.0.160.

You will also need to set up your gateway as a DNS resolver. To do so on UNIX, add at least a *search* and *nameserver* to /etc/resolv.conf. I am using the following:

    search nyc.rr.com
    nameserver 192.168.0.1

Set up NSS to read resolv.conf.

    $ cp /etc/nsswitch.{dns,conf}

Add the OmniTI managed services package repo to make getting a few things easier.

    $ pkg set-publisher -g http://pkg.omniti.com/omniti-ms/ ms.omniti.com

Rebuild the package index

    $ pkg rebuild-index

Install Ruby and gcc 4.6 to be able to build gem extensions. Also ensure libffi is there since Vagrant needs the ffi gem.

    $ pkg install omniti/runtime/ruby-19
    $ pkg install developer/gcc46
    $ pkg install library/libffi

At this point you should be ready to install the Vagrant gem. The Ruby 1.9 executables like `gem` and `irb` get put into `/opt/omni/bin/`.

    $ /opt/omni/bin/gem install vagrant

Run a quick `vagrant help` to ensure that everything's hooked up properly.

    $ /opt/omni/lib/ruby/gems/1.9.1/gems/vagrant-1.0.5/bin/vagrant help

Next up we need to install VirtualBox. I saw [errors related to the Crossbow-based networking kernel module](https://gist.github.com/7ddfa72c1d97198532ea) while trying to install a variety of versions of VirtualBox, so we can [force the older stream-based VirtualBox networking driver to install](http://www.virtualbox.org/manual/ch09.html#vboxbowsolaris11).

    $ touch /etc/vboxinst_vboxflt

With that in place, download and extract the VirtualBox 4.2.0 release for Solaris guests.

    $ wget http://download.virtualbox.org/virtualbox/4.2.0/VirtualBox-4.2.0-80737-SunOS.tar.gz
    $ tar xzf VirtualBox-4.2.0-80737-SunOS.tar.gz

Next up, install the package.

    $ pkgadd -d VirtualBox-4.2.0-SunOS-r80737.pkg

At this point you should be ready to download a Vagrantfile and go. I've made [a sample one](https://gist.github.com/0509301bb7c62e523b49) that you can try with.

    $ curl https://raw.github.com/gist/0509301bb7c62e523b49/87e75688b45631ca9492123c5f160d2311e84604/gistfile1.rb > Vagrantfile
    $ /opt/omni/lib/ruby/gems/1.9.1/gems/vagrant-1.0.5/bin/vagrant up
    $ /opt/omni/lib/ruby/gems/1.9.1/gems/vagrant-1.0.5/bin/vagrant ssh

And with that, the box should download and the second command should have you logged in as the `vagrant` user on your very own Ubuntu 12.04 LTS VM.

### Host-only networking

There is one peculiarity to VirtualBox on OmniOS (which, granted, might be VirtualBox on Solaris/Illumos - I have no idea.) Windows, Mac, and Linux hosts all have the ability to create a host-only interface with the `VBoxManage hostonlyif create` command-line option. That option does not exist in the Solaris version of VirtualBox. In my experience from this weekend, VirtualBox will create you a `vboxnet0` interface which can be used as a host-only network. If you do wish to use host-only networking with your VM, you will have to set it up before you run `vagrant up`.

I usually run my host-only interfaces inside of 172.16.0.0/12. For the sake of argument, let's say we want to give this VM a host-only address of 172.31.31.31. (The sample Vagrantfile has this configuration commented out.) By setting the IP address of `vboxnet0` to 172.31.31.1, vagrant will not try to run `VBoxManage hostonlyif create`, and host-only networking will also work. The `VBoxManage` command to do so is as follows:

    $ VBoxManage hostonlyif ipconfig vboxnet0 -ip 172.31.31.1

### Not exhaustive

I haven't tried out a full client setup though Vagrant on OmniOS yet, and I think I'll still be booting my workstation into Fedora 17 for the next week to run KVM and/or VirtualBox VMs. Here are the remaining things that I'd need to nail down before I could use OmniOS and Vagrant together:

- There's no Solaris host class in Vagrant, so the ability to export files (like your codebase) from the host to the guest via NFS won't work yet. That said, since ZFS has deep hooks into NFS, this might be super simple to implement assuming that you boot from ZFS.
- The host-only networking bit is strange, and I don't know enough about OmniOS or Crossbow to say what's going on.
- I haven't tested out applying Puppet or Chef configuration to the guest. OmniTI [makes a Chef package available](http://pkg.omniti.com/omniti-ms/info/0/omniti%2Fsystem%2Fmanagement%2Fchef%400.10.8%2C5.11-0.151002%3A20120501T192332Z) in the managed services repository, and the Puppet and Facter gems install without issue, so this should be rather painless.
- VirtualBox should probably be run [in its own zone](http://www.virtualbox.org/manual/ch02.html#idp11597936).
