---
layout: post
title: "Be More Awesome (Please!) : A Tale of Two Browsers"
created: 1305935720
categories:
- browsers
- chrome
- firefox
---
When Firefox 4 came out, I switched to it. I was mainly impressed by its speed (relative to the stable version of Chrome at the time) and the efficacy of Firefox Sync.

Several weeks later, I abandoned it for the stable build of Chrome. There were several things that contributed to its downfall in my eyes. Chief among them was its effect on my battery life on my MacBook Pro. Despite being nearly as fast as Chrome in user-perceived speed, Firefox generally used more CPU. There was also a [very annoying bug](https://bugzilla.mozilla.org/show_bug.cgi?id=567552) that resulted in a ton of modal popups.

About a month back, I switched from the Chrome stable released to the Chrome dev channel and I've been in general very pleased. There's one feature that has been slowly gnawing away at my sanity, however, and it's gotten serious enough that I'm switching back to Firefox 5 to see if my complaints about Firefox 4 have been addressed.
<!-- break -->

## Advantage: Firefox

Even though Chrome has been my daily driver for several months now, I often still use Firefox in a number of cases:

- To use the excellent [FoxyProxy extension](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/) to abuse SOCKS proxies for fun and profit.
- To debug with the [Charles web debugging proxy](http://www.charlesproxy.com/) without sending all of my traffic through it.
- To use FireCookie, YSlow!, or one of several web development tools that is just slightly better than the Chrome equivalent.

<br />
## Advantage: Chrome

That being said, I think Chrome has a leg up in a number of ways on Firefox:

- It has had a working Delicious extension for some time now, which was not true of Firefox 4 (and 5) until [just a couple of weeks ago](https://addons.mozilla.org/en-US/firefox/addon/delicious-extension/).
- It has a great [extension to integrate with Google Voice](https://chrome.google.com/webstore/detail/kcnhkahnjcbndmmehfkdnkjomaanaooo). I do nearly all my texting from Chrome thanks to this extension.
- It lets you do things like "Close all tab to the right" [without an extension](https://addons.mozilla.org/en-US/firefox/addon/multiple-tab-handler/).
- The web development tools are baked in, so you can debug something right away in any installed version of Chrome.

<br />
And finally, I have found ways to work around some of Firefox's flaws. Mostly notably, the font popup window was actually in issue with Font Book. A [workaround has been posted on the Mozilla forums](http://support.mozilla.com/en-US/questions/768100) and it is working well.

## Ow, My Brain.

The straw that broke the camel's back with regard to Chrome is the fact that it no longer seems to save any new URLs, or at least it never puts them in the Omnibar. It seems that [I'm not alone in wanting this, either](http://superuser.com/questions/120885/make-chromes-omnibar-behave-more-like-the-firefox-awesomebar) - there are [several](http://jaygoldman.com/2010/12/how-to-get-the-firefox-awesomebar-in-google-chromes-omnibar/) [articles](http://www.chromeplugins.org/google/chrome-troubleshooting/how-can-i-make-omnibar-more-like-awesomebar-9539.html) [online](http://jshoer.wordpress.com/2008/10/12/make-google-chromes-omnibar-behave-more-like-firefox-3s-awesomebar/) about how to supposedly make Chrome's Omnibar more like the AwesomeBar in Firefox.

Most of these articles focus on the wrong part of the part of the AwesomeBar, which is its propensity to do an "I'm Feeling Lucky" search if there's nothing in AwesomeBar results. The single feature that, in my opinion, makes the AwesomeBar **utterly awesome** is the simple fact that it _remembers the URLs that I type on a daily basis_.

I have been visiting sites that are not in Google's index quite a bit recently, as any web developer will do. And while it's kind of cute to type https://jenkins.{thing}.{stuff}.{domain}.{tld}/ two or three times, it would be just dandy if Chrome would get the hint the fourth or fifth or twelfth time that I did so.

But it doesn't, and it seems that as of version 12 or so, no new URLs will ever enter into the Omnibar for autocompletion as I type.

Here is another example that shows just how frustrating this is. I've recently visited the source of the [Arch Linux PKGBUILD that I made for Varnish](https://github.com/smerrill/varnish-3-pkgbuild/blob/master/PKGBUILD) in both Firefox and Chrome. In Firefox, I can type "var pk" and the AwesomeBar brings up two hits that are laser-focused on what I'm looking for. Chrome suggests that I either do a Google search for that tiny, two-word phrase or visit [this Coding Horror article from 2008](http://www.codinghorror.com/blog/2008/12/hardware-is-cheap-programmers-are-expensive.html), which is the only non-search item shown in the Omnibar.

## Chrome, Y U No Awesome?

And believe me, I get it. Google wants me to make Google searches and to use Google Instant and/or their prediction webservices so that they get a greater quantity of searches.  When I am genuinely looking for something with an unknown URL, I will happily do that. I love Google's search.

But please, Google, for the love of the sanity of web developers who routinely type long URLs that may not come up near the top of a Google search, make Chrome more [awesome](http://blog.mozilla.com/blog/2008/04/21/a-little-something-awesome-about-firefox-3/).

Until then, I'll be trying out [Firefox 5](http://www.getfirefox.com).

