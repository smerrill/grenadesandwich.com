---
layout: post
title: "Bonjour, mes amis!"
created: 1326741865
categories:
- networking
- ssh
- zeroconf
---

Apple's [Bonjour](http://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/NetServices/Introduction.html#//apple_ref/doc/uid/10000119i) service just saved me a lot of hassle.

I took a little time this MLK Day to get some old electronics ready for sale. One of the machines I decided to clean up was an old Mac Pro. I've recently replaced it with a [Mac mini](http://www.apple.com/macmini/server/) that positively sips power: 10 - 12 watts at idle instead of the consistent 120 watts that my old Mac Pro would draw. (I'll write more on cutting my setup's power consumption in a later blog post.)

I hooked my Mac Pro up to my router with an Ethernet cable but didn't want to get out a keyboard, mouse, and monitor to do a final set of backups and deauthorize some software. Normally this wouldn't be a problem since the old Mac Pro was set configured to start Apple Remote Desktop at boot.

I forgot that since switching to the Mac Pro, I had reassigned the Mac Pro's IP address (192.168.0.150) to the Mac mini. The Mac Pro booted, but could not get a proper IP address since the address it was configured to use was in use.

I was about to break out my keyboard, mouse, and monitor when I thought I'd give Bonjour a try.

<!-- break -->

## Saying ' _Bonjour!_ ' sans IP address

The Mac Pro in question was configured with a machine name of `Terawattson`. I knew that Bonjour would advertise `Terawattson.local` over the network to capable clients, but wasn't sure if that would work when the machine didn't have a proper IP address. On a lark, I gave it a shot, and it worked.

{% highlight text %}
 ┌┤smerrill@Tinier-Shinier [Jan 16 12:23:22] ~
 └╼ ssh Terawattson.local
Last login: Mon Jan 16 12:56:57 2012
 ┌┤smerrill@Terawattson [Jan 16 12:58:22] ~
 └╼
{% endhighlight %}

Even better, this meant that I could use an SSH tunnel over Bonjour networking to tunnel to port 5900 (where the Apple Remote Desktop service lives, just like VNC) and graphically access the Network control panel to switch IP addresses.

{% highlight text %}
 ┌┤smerrill@Tinier-Shinier:1 [Jan 16 12:56:55] ~
 └╼ ssh -N Terawattson.local -L 5901/localhost/5900
{% endhighlight %}

With that SSH tunnel in place, I went into the Finder and with a single "Connect to Server", I had a session on the Mac Pro in OS X's Screen Sharing.app.

![Connecting to vnc://localhost:5901 over the SSH tunnel](https://img.skitch.com/20120116-f45bhy6g7bprfjgug1818f8xn9.jpg)

Using the graphical connection I set a new IP address, deauthorized Adobe CS4, iTunes, and a couple other programs, and started up an rsync backup to the new Mac mini.

I hope this post helps you out if you ever have trouble with a headless Mac.

