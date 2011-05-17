---
layout: post
title: Everything Old is New Again
created: 1255353828
permalink: "/blog/steven/2009/10/12/everything-old-new-again/"
categories:
- performance
- nginx
- drupal
- centos
- cdn
- bzr
---
<p>It's time for my quarterly blogging drive, and to start, here's some information on my ever-increasing need to try out cool web technologies.</p>
<!-- break -->
<h3>Server Migration</h3>

<p>My previous server was a VPS with 1 GB RAM for an obscenely low price from Serve By Design. I'm not linking to them, because I wouldn't recommend them, as you'll see.  For the money, I didn't expect them to stay around forever, and I was right. At the end of September, I got an email saying that they had to immediately cease all hosting and that I had 10 days to move my VPS.   Not great, but I can deal with that.</p>

<p>I've been doing some work with <a href="http://www.rackspacecloud.com/">Rackspace's cloud products</a> recently for work, so I decided to move to a Cloud Server VPS running CentOS.  I'm quite impressed with the Rackspace Cloud thus far, they have a robust backup / cloning system, and the plans are plenty cheap so long as your data transfer isn't too high.  Since I'm using <a href="http://www.simplecdn.com/">SimpleCDN</a> to handle all static content for my Drupal 6 sites, there's really nothing to worry about on the data transfer front.</p>

<p>But why stop with a new VPS and a new provider?  I decided to switch to some of the alternate technologies that people go to for maximum throughput on a Drupal site.  In this case, I'm not yet talking about Varnish and/or Pressflow (although I am a fan and user of both those projects in production on bigger sites.)  I decided to use the alternative webserver <a href="http://wiki.nginx.org/">nginx</a> and to run PHP dameonized through <a href="http://php-fpm.org/Main_Page">PHP-FPM</a>.</p>

<p>The installation of PHP-FPM and nginx was a snap. I initially read <a href="http://adityo.blog.binusian.org/?p=428">a great tutorial on how to do so on CentOS</a>, but then I found <a href="http://centos.alt.ru/pub/repository/centos/">the CentALT repo</a>, which has builds of nginx and PHP-FPM for your <strong>yum install</strong>ing pleasure.</p>

<p>Thus far, nginx and php-fpm have been rock-solid and quite fast (although I'm not going to break any traffic records with my hosted sites.)  I also like the ability to reload php configuration changes just by restarting the php-fpm service, and nginx restarts in milliseconds.</p>

<h3>Version Control</h3>

<p>I've been flirting with DVCS systems for while now.  I've mostly been looking at <a href="http://bazaar-vcs.org/en/">bzr</a>, because it's cross-platform, easy for people familiar with svn and cvs to grok, and supposedly offers the best Windows support of the lot.  It also has a Drupal upstream branch, and <a href="https://launchpad.net/pressflow">Pressflow</a> is now being managed on Launchpad.</p>

<p>There's now a nice <a href="http://bazaar-vcs.org/MacOSXDownloads">Snow Leopard-friendly installer</a> for bzr 2.0, and so I've been using that on my OS X boxes.</p>

<p>One of the neat features about bzr is that it can run off of dumb servers.  All you need is an SFTP server and you can host your own bzr branches.  Nonetheless, you can save on bandwidth (and score more geek cred) if you run your own smart server, so I set out to set up bzr and some of the cooler tools from the bzr ecosystem on my CentOS box.</p>

<p>Version 1.3 is the latest bzr version in any mainstream CentOS repo, so I built bzr 2.0 on my box.  I also got <a href="https://launchpad.net/loggerhead">Loggerhead</a> up and running for nice-looking graphical representations of my bzr branches like the one below.</p>

<p><a href="http://www.flickr.com/photos/00sven/4004158545" title="/lift-url-shortener : revision 7" class="flickr-photo-img"><img src="http://farm3.static.flickr.com/2642/4004158545_8dfb8177a7.jpg" alt="/lift-url-shortener : revision 7" title="/lift-url-shortener : revision 7"  class=" flickr-photo-img" height="411" width="500" /></a></p>

<p>Check back later in the week where I'll post more details about how to set up <strong>bzr serve</strong> as a CentOS service, and how to get Loggerhead via an nginx proxy to play nicely together.</p>
