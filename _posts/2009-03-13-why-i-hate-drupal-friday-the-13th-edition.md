---
layout: post
title: "Why I Hate Drupal: Friday the 13th Edition"
created: 1236924634
permalink: "/blog/steven/2009/03/13/why-i-hate-drupal-friday-13th-edition/"
categories:
- drupal
---
<p>Now that I'm back from my month-long blog hiatus and from <a href="http://dc2009.drupalcon.org">DrupalCon DC 2009</a>, I&nbsp;thought I'd throw up a little post in the same vein as <a href="http://walkah.net">walkah</a>'s brilliant <a href="http://walkah.net/blog/walkah/why-i-hate-drupal">Why I Hate Drupal</a> talk.</p>
<!-- break -->
<p>A friend was building a Drupal site and asked me what I&nbsp;thought the best way to prepopulate a lot of HTML&nbsp;into a node body field was for a newsletter. Now, she's using <a href="http://drupal.org/project/simplenews">Simplenews</a> and <a href="http://drupal.org/project/simplenews_template">Simplenews template</a> isn't yet out for Drupal 6, but that's no problem. In the past, on sites like <a href="http://www.ypogp.org/">YPOGP.org</a>, I&nbsp;implemented the newsletter by using a little module called <a href="http://drupal.org/project/nodeformtemplate">nodeformtemplate</a> to fill in the node body with a full HTML&nbsp;newsletter, and letting the user type in the extra HTML&nbsp;they needed. That module makes it easy, right?</p>

<p>It had been awhile since doing an implementation, so I&nbsp;told my friend to look into the 'node form template' module.&nbsp; Well, she dutifully went and downloaded the <a href="http://drupal.org/project/Node_form_template">Node Form Template</a> module, and not the <a href="http://drupal.org/project/nodeformtemplate">nodeformtemplate</a> module.&nbsp; (This makes sense, since she's building a Drupal 6 site, and Node Form Template has a 6 release.)</p>

<p>To make a long story short, the two modules are completely different, and thus I&nbsp;inadvertantly sent my friend on a wild goose chase, leaving her confused about why exactly she could care about templating a node form in Drupal 6 to begin with when all she wanted to do was to pre-fill a newsletter's body.</p>

<p>So here we have three simple problems:</p><ol><li>These two contrib modules with vastly differently functions need vastly different names.</li><li>The existing <a href="http://drupal.org/project/nodeformtemplate">nodeformtemplate</a> module should probably be called something like <a href="http://drupal.org/project/prepopulate">prepopulate</a>. <em>Oops - a module with that name already exists, too, so then we go on to...</em></li><li>The existing <a href="http://drupal.org/project/prepopulate">prepopulate</a> module might better be called <em>prepopulate from url</em>, or maybe the two should merge.</li></ol>

<p>Having said all that, my gripe is a small one and the vastness of Drupal's contrib is an asset more than a liability in most cases.&nbsp; Plus, our story has a happy ending. Despite the fact that the Twitterati of the #shittymodulesmustdie hashtag might question my decision, I&nbsp;<a href="http://drupal.org/node/363180#comment-1350774">ported the nodeformtemplate module</a> to Drupal 6.</p>

<p><em>P.S.</em> It's a shame that <a href="http://search.twitter.com">Twitter Search</a> filters out swear words, because I&nbsp;was going to link up #shittymodulesmustdie. Our puritanical Twitter overlords win this one.</p>
