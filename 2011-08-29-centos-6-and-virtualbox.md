---
layout: post
title: CentOS 6 and VirtualBox (VBoxHeadless CPU Usage Fix)
created: 1305935720
categories:
- centos
- centos 6
- virtualbox
- vagrant
---
**TL;DR:** Add "noapic" to your kernel line if your VBoxHeadless process uses far too much CPU.

I've been working on making [space-efficient CentOS 5.6 and 6 images](https://github.com/smerrill/veewee-fun/) for [VirtualBox](http://www.virtualbox.org) recently. I'm building the images as part of a pilot program to start using [the Vagrant gem](http://vagrantup.com) to allow our developers to test the Drupal code they write on the real production OS before pushing it to the dev server. (I'm also learning Puppet, both for this project and as a way to more easily re-use tested configurations as we launch new sites.)

The CentOS 5.6 images I made worked like a charm, but ran into a problem wherein the _VBoxHeadless_ process that hosted my CentOS 6 image would always use 25% CPU on my MacBook Air (one full core) despite the guest OS showing between 98% and 100% idle.

<!-- break -->

I read through a number of suggestions that applied to CentOS 5.6, which involved [setting ```divider="10"```](http://tiebing.blogspot.com/2011/08/virtualbox-vboxheadless-high-cpu-usage.html) in the kernel parameters, but these have no effect under CentOS 6, which uses a tickless kernel.

In reading further on the subject, I found that some other forums advocated looking at the [APIC](http://www.wlug.org.nz/APIC) settings. Sure enough, as soon as I added the text ```noapic``` to the end of my **kernel** line in ```/boot/grub/grub.conf``` and restarted, the issue went away.


