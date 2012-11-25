---
layout: post
title: "Ten Lesser-Known Things About Vagrant"
created: 1306726837
categories:
- vagrant
- virtualization
---

I'm a huge fan of [Vagrant](http://www.vagrantup.com), a framework for virtualized development environments. We use Vagrant at [Phase2 Technology](http://www.phase2technology.com) to model clients' hosting environments and to develop Puppet manifests in a testing environment before they even hit the production hosting environment.
I've had the opportunity recently to sit in #vagrant on Freenode and answer some questions. The #vagrant channel is interesting because the questions end up being a mix of questions on many different topics, but throughout many of them, I've noticed several things that are generally not well understood, and I thought I'd answer them.

<!-- break -->

Since Vagrant is a framework for automating VirtualBox to create local development environments using Linux machines that are provisioned (generally) with a configuration management tool, the following topics all come up in #vagrant:

* Linux system administration
* [Chef](http://www.opscode.com/chef/)
* [Puppet](http://www.puppetlabs.com)
* [VirtualBox](https://www.virtualbox.org)
* [Veewee](https://github.com/jedi4ever/veewee)

Here are 8 facts about Vagrant that are not widely known about Vagrant.

## 1. The eth0 interface on a VM is a NAT interface and Vagrant runs commands over it

## 2. You can give a Vagrant VM an address on your local network (with some caveats)

## 3. Host-only networking lets you access the guest from the host

* Explain difference vs port forwarding
* Try and point out vagrant-hostmaster
* Explain that iptables can thwart this

## 4. You can re-run your provisioners without rebooting

* `vagrant provision`
* The provisioners run in order
* `vagrant reload` vs `vagrant provision`

## 5. Public Vagrant boxes use a public keypair (be careful!)

## 6. Vagrant's box management keeps pristine copies of boxes for you

## 7. Moving and cloning your Vagrant projects

* The `.vagrant` file and how it tracks VMs

## 8. You can use the VirtualBox CLI to manage your machines

* A quick `VBoxManage` primer
* Hard stopping a VM
* Stopping a VM after you delete a Vagrantfile

## 9. Vagrant runs pretty much everywhere

This shouldn't really come as a surprise to anyone, but every time I try out a new platform, Vagrant works flawlessly. This is a tribute to VirtualBox: although it has its warts, it runs pretty much everywhere. Mitchell also has to work around various VirtualBox bugs on [certain versions of OS X](https://github.com/mitchellh/vagrant/commit/e367a8cfd6ecd3b194ab694eea948dfd891b76b9) [and on Windows](https://github.com/mitchellh/vagrant/commit/6323a8efd433e6e340a262e89fa3aba86f2e9d4f), so the fact that this all just works transparently is pretty awesome.

Any time I set up a new system, one of the first things I do is set up VirtualBox and see if Vagrant can run on it.  Here's a full list of systems that I have used as a Vagrant host:

* OS X 10.6 with NFS
* OS X 10.7 with NFS
* Ubuntu 12.04 with NFS
* Ubuntu 12.10 with NFS
* Fedora 17 with NFS
* * I helped [with a patch to make NFS work on Fedora 16+](https://github.com/mitchellh/vagrant/pull/1140))
* Arch Linux with NFS
* OmniOS
* * I [blogged my experience trying this out](http://grenadesandwich.com/blog/steven/2012/09/23/omnios-vagrant/), and it sounds like [OmniTI](http://omniti.com/) is going to make some packages for VirtualBox and Vagrant soon. I am utterly unfamiliar with Illumos/OpenSolaris, so there's probably some work needed here, like an Illumos host class.
* Windows 7
* * Before I reformatted a netbook to Linux, I tried out Vagrant 1.0.5 with Cygwin, and everything worked smoothly.

## 10. Vagrant is not (yet) ready to use non-VirtualBox hypervisors yet

I'm including this as a quick way to end this post. Several people have popped into #vagrant and said, "I read that Vagrant supports VMWare, or that it will soon!"

It is true that the master branch of the Vagrant repository contains code that aims to decouple Vagrant from VirtualBox, but there's not a firm timeline on when other providers will be ready to use. (In addition, running the code on master will reformat your Vagrantfiles, so you'll want to set up a new user to test this.)

