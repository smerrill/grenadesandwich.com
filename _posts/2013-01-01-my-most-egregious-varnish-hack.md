---
layout: post
title: "My Most Egregious Varnish Hack"
created: 1315363024
categories:
- varnish
- hackery
---
[Varnish](http://varnish-cache.org/) is an amazing piece of open-source software. At [Treehouse Agency](http://treehouseagency.com) we use it as a standard part of our hosting stack because of its amazing performance for serving anonymous and static content.

In truth, though, its extreme ease of configuration is another part of its appeal. Perhaps an application that you can't easily change is sending the wrong headers. In that case, just rewrite them on the way back out. Maybe you want to [munge Accept-Encoding headers](https://www.varnish-cache.org/trac/wiki/FAQ/Compression#Ithoughtyousaidthiswascomplicated) to get maximum cache hit rates? Varnish handles that with aplomb.

My favorite Varnish story, though, deals with a quick hack I put together to fix what could potentially have been a major PR problem.

<!-- break -->
## Shortening Links For Fun and Profit

We use [bit.ly](http://bit.ly) to shorten [Treehouse Agency](http://treehouseagency.com)'s links. Specifically, we are using bit.ly's "Custom short domain" feature to use the <u>tha.cm</u> domain for all of our shortened links. We like bit.ly for its analytics and the fact that a custom short domain is free.

Now let's travel back in time a bit.

In the early spring of 2011, Team Treehouse Agency was preparing for [DrupalCon Chicago](http://chicago2011.drupal.org/). We had just printed up new business cards and promotional materials. We had put a number of URLs into our promotional materials and we were fleshing their content in the days leading up to the conference. One by one, we claimed the URLs on our tha.cm domain as we finished pages.

## ...Oops

We left the easiest page to produce (content-wise) for last: [tha.cm/social](http://tha.cm/social), which was simply a list of all the Treehouse Agency social media links. When we went to claim this link, however, we discovered one thing that we had overlooked.

<strong>Using a bit.ly custom domain does not give you your own pool of unique links.</strong>

Stated in another way, tha.cm/social is the same as bit.ly/social is the same as (insert other short domain here)/social, and someone had already claimed this. This was a major problem, because thousands of Treehouse Agency business cards had been printed with that exact link on it.

## Varnish to the rescue!

We looked at other link-shortening services, but many of them cost too much or didn't offer the same level of analytics that we got from bit.ly. Without a simple switch possible, I implemented a quick 10-minute fix with Varnish.

The way that you implement bit.ly custom short domain support is by setting up a DNS <strong>A</strong> record that points to the URL 168.143.174.97. Therefore, I created a tiny [Rackspace Cloud Server](http://www.rackspace.com/cloud/cloud_hosting_products/servers/) and set the DNS for tha.cm to resolve to its IP. I then installed Varnish on it, and configured it almost as a straight-up proxy. Here's the VCL I used:

{% highlight scala %}
backend default {
  .host = "168.143.174.97";
  .port = "80";
}

sub vcl_recv {
  set req.http.host = "tha.cm";
  if (req.url == "/social") {
    error 750 "Moved Temporarily";
  }
}

sub vcl_error {
  if (obj.status == 750) {
    set obj.http.Location = "http://tha.cm/tha-social";
    set obj.status = 302;
    return (deliver);
  }
}
{% endhighlight %}

It's really pretty simple. If the requested URL is "/social", redirect to the real tha.cm/bit.ly link that we ended up getting. Otherwise, it proxies the request through to 168.143.174.97, which is the address that you would normally put into your domain's DNS anyway.

Varnish's primary role is that of a super-fast reverse proxy cache, but hopefully this post has also shown you that its flexibility can also save you from other sorts of issues.

In our case, it meant that we didn't have to reprint lots of business cards. Chalk up another win for Varnish.
