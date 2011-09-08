---
layout: post
title: "A PSA: Lion and .local Domain Names"
created: 1315454459
categories:
- lion
- web development
---

Do you enjoy your hair? Would you prefer not to pull it out while waiting for your local Apache server on Mac OS X to deliver a page to you?

If you use Mac OS X Lion and have development sites set up at .local addresses, you should immediately move them to any other fake TLD. The .local address space is resolved for Bonjour and as a result any request to a .local name will not hit /etc/hosts first, but will search for Bonjour hosts first.

I found [this Stack Exchange question](http://stackoverflow.com/questions/6841421/mac-osx-lion-dns-lookup-order) on the subject tonight after getting frustrated with **curl** seemingly hanging for several seconds on each request.

Instead, I switched all of my local dev sites from $DOMAIN.local to $DOMAIN.dev. The results are staggering.

<!-- break -->

Since switching all my development sites to end in .dev, requests for them happen several orders of magnitude faster, which is a welcome change. Here are two examples of an Apache 404 page (such that the DNS resolution time is the only appreciable time spent in delivering a response to **curl**.)

{% highlight text %}
 ┌┤smerrill@Tinier-Shinier:6 [Sep 07 23:43:35] ~
 └╼ time curl http://whatever.local/ > /dev/null

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    72  100    72    0     0   1217      0 --:--:-- --:--:-- --:--:--  1250

real	0m5.011s
user	0m0.006s
sys 	0m0.003s

 ┌┤smerrill@Tinier-Shinier:6 [Sep 07 23:43:46] ~
 └╼ time curl http://whatever.dev/ > /dev/null
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    72  100    72    0     0   1412      0 --:--:-- --:--:-- --:--:--  1440

real	0m0.060s
user	0m0.007s
sys 	0m0.004s
{% endhighlight %}

That's right - the request goes from a lag of almost 5 seconds to finishing in the blink of an eye. A coworker reported his times going from 12 seconds to less than a tenth of a second. It's amazing what a difference such a small change in DNS can make.

I hope this speeds up your local web development!
