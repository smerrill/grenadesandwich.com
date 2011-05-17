---
layout: post
title: Fuddled API, Verbose Workaround
created: 1263013345
permalink: "/blog/steven/2010/01/09/fuddled-api-verbose-workaround/"
categories:
- unfuddle
- treehouse agency
- scala
- scala 2.7
- databinder dispatch
---
<p>I've started writing some <a href="http://scala-lang.org/">Scala</a> applications (including one atop the <a href="http://liftweb.net/">Lift web framework</a>) to access <a href="http://unfuddle.com/docs/api/">Unfuddle's API</a> recently. I've mainly been building daily burndown reports for my team at <a href="http://treehouseagency.com/">Treehouse Agency</a>.  I've run into a few issues with API methods not working as advertised, and Unfuddle's been pretty good about fixing most of them.</p>

<p>The problem <a href="http://unfuddle.com/community/forums/3/topics/816?page=1#posts-2306">I've been experiencing as of January 5th</a> is that Unfuddle has subtly broken authentication for client libraries that (wisely) wait for a 401 error with an accompanying WWW-Authenticate: Basic header before sending credentials.  (Namely, Unfuddle's API stopped sending a WWW-Authenticate header altogether.)  If need be, you can force most HTTP client libraries to send authentication on every request in one way or another, and that's what I had to do tonight with the excellent <a href="http://databinder.net/dispatch/About">Databinder Dispatch library</a>.</p>
<!-- break -->
<p>The code to prepare a request that will send Basic credentials when the server requests them is concise:</p>

{% highlight scala %}
import dispatch._

val req = :/("%s.unfuddle.com" format subdomain) / "api/v1" as (user, password)
{% endhighlight %}

<p>Clean and simple, right?</p>

<p>To force an outgoing HTTP basic auth header with the least fuss, you'll need to create it by hand by Base64 encoding a user's username and password pair.  The Apache Commons library includes a Base64 encoder and decoder, so by dipping your toes into Java-land you can construct this header.  Once the Base64 value is encoded, the <strong>&lt;:&lt;</strong> method of the <a href="http://databinder.net/sxr/dispatch-http/0.6.5/main/Http.scala.html#6742">dispatch.Request class</a> accepts a Map[String, String] and will set the corresponding headers on the outgoing web request.</p>

<p>Here's the full workaround I came up with.</p>

{% highlight scala %}
import dispatch._
import org.apache.commons.codec.binary.Base64

val authString = "Basic " + new String(Base64.encodeBase64("%s:%s".format(user, password).getBytes))
val req = :/("%s.unfuddle.com" format subdomain) / "api/v1" <:< Map("Authorization" -> authString)
{% endhighlight %}

<p>So there you have it - a method to construct a Databinder Dispatch web request that always sends an HTTP basic auth header. Hopefully, all the web APIs that you interact with will do the right thing regarding WWW-Authenticate headers, but if not, now you'll know how to cope.</p>

<p><strong>UPDATE:</strong> In case you're wondering if this is happening with an API that you're interacting with, the specific error that indicates that Apache HttpClient (the underlying workhorse of Databinder Dispatch) did not receive any WWW-Authenticate headers looks like this:</p>

<p><pre><code>WARN - Authentication error: Unable to respond to any of these challenges: {}</code></pre></p>

