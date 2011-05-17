---
layout: post
title: Scala, Lift, and the Future
created: 1259294938
permalink: "/blog/steven/2009/11/27/scala-lift-and-future/"
categories:
- scala
- scala 2.7
- lift
- functional programming
---
<p>I've been spending a decent amount of my after-hours time investigating a combination that I think will be part of the future of web programming: the <a href="http://www.scala-lang.org">Scala programming language</a>, and <a href="http://www.liftweb.net/">the Lift web framework</a> on top of it.</p>
<!-- break -->
<p>A number of high-scale, distributed systems have recently adopted Scala. Twitter's messaging queues are now handled by Scala and its Actors library. Another high-scale social game, <a href="http://foursquare.com/">Foursquare</a>, uses Scala for its backend, and Lift for its web tier.  (I'm excited to see a presentation about Foursquare's use of Lift at the <a href="http://www.meetup.com/New-York-Scala-Enthusiasts/calendar/11900384/">New York Scala Enthusiasts</a> meetup this weekend.</p>

<p><a href="http://lerdorf.com/bio.php">Rasmus Lerdorf</a> is the inventor of PHP and author of a famous presentation at OSCMS 2007 that exposed flaws in PHP CMSs (although it showed Drupal to be light-years ahead of its open-source brethren in terms of security.)  He recently cast a critical eye on Foursquare:</p>

<p><a href="http://www.flickr.com/photos/00sven/4136785689" title="Twitter / Rasmus Lerdorf: Four stars to @foursquare ..." class="flickr-photo-img"><img src="http://farm3.static.flickr.com/2524/4136785689_fd8c6c0b69.jpg" alt="Twitter / Rasmus Lerdorf: Four stars to @foursquare ..." title="Twitter / Rasmus Lerdorf: Four stars to @foursquare ..."  class=" flickr-photo-img" height="346" width="500" /></a></p>

<h2>Why I Like Scala</h2>

<h3>It's got an interactive shell</h3>

<p>Like Python, you can run commands in Scala's interactive shell, the REPL (read-eval-print-loop.)  Don't take my word for you - you can also <a href="http://www.simplyscala.com/">play with the REPL online</a>. Another benefit to this is that you can test Lift apps and interactive with its ORM from the command line through the REPL, just as you can with Django through the Python interactive shell.</p>

<h3>Scala runs on the JVM and interoperates with Java libraries</h3>

<p>Any of the wealth of Java libraries can be used with Scala. If you're already running SOLR on Tomcat or Jetty, you can run a Scala application.  Enterprises who already have Java infrastructure can move to Scala apps today.</p>

<h3>You can write incredibly concise code with Scala</h3>

<p>With its support for pattern-matching, structural types, and just through the general design of the language, you'll find that almost none of your Scala code is boilerplate. Consider the following Java:</p>

{% highlight scala %}
public class Person {
  public final String name;
  public final int age;
  Person(String name, int age) {
    this.name = name;
    this.age = age;
  }
}
{% endhighlight %}

<p>Next, the equivalent Scala.</p>

{% highlight scala %}
class Person(val name: String, val age: Int)
{% endhighlight %}

<p>This was taken from a presentation by David Pollak, the creator of Lift. (You can check out <a href="http://www.infoq.com/presentations/Scala-Basics-Bytecode-David-Pollak">the whole presentation</a> along with more comparisons, along with some very low-level Java bytecode.)</p>

<h3>Scala supports functional programming techniques</h3>

<p>Functional programming will be the way of the future in a world of decreasing processor speeds and increasing numbers of processor cores. Note that Scala merely supports functional programming; it's also entirely possible to write regular, imperative Java-style code as you get used to the functional, Scala idiom. Hey - at least your Java-in-Scala code will still be concise. Once you get used to functional style with no shared state and immutable variables, you can refactor your old code.</p>

<p>Scala also has a built-in actors library which allows for share-nothing message passing between processes, threads or servers.  (Facebook chat uses Erlang, which has a similar actor library, to send nearly a billion messages a day.)</p>

<h3>Lift is feature-laden and secure</h3>

<p>Lift (like <a href="http://drupal.org/">Drupal</a>) has many layers of security built in - form tokens, explicit escaping of all values going into templates by default, and the like. See Rasmus's comment above.</p>

<p>A common Lift demonstration is writing a Comet chat application in under 20 lines of Scala code. (Check out slides 9, 10, and 11 of <a href="http://qconlondon.com/london-2009/file?path=/qcon-london-2009/slides/DavidPollak_LiftWebFramework.pdf">one such presentation</a>.) Combined with a Java web application server like Jetty that supports continuations, actors that are handling Comet long polling can suspend without tying up a thread.</p>

<h3>Scala uses Drupal for their site</h3>

<p>The Scala webmasters have good taste in their choice of other open-source projects. What can I say?</p>

<h2>The Future</h2>

<p>So what's the point of all this?</p>

<p>I've been looking around at frameworks as a way to broaden my horizons. I checked out Django and Python briefly, but I think that Scala and Lift could be the next great building block for high-scale social applications. I'll be posting about it as I go. Tomorrow, I'll post a conversion of <a href="http://norvig.com/spell-correct.html">Peter Norvig's 21-line python spell-checker</a> into Scala.</p>
