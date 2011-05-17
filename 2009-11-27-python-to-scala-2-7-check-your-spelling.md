---
layout: post
title: "Python to Scala 2.7: Check Your Spelling"
created: 1259370442
permalink: "/blog/steven/2009/11/28/python-scala-27-check-your-spelling/"
categories:
- python
- scala
- scala 2.7
---
<p><a href="/node/10">Last time out</a>, I talked about the benefits of <a href="http://www.scala-lang.org/">Scala</a>, and why I'm looking at Scala and <a href="http://www.liftweb.net/">Lift</a>.</p>

<p>In that spirit, I spent some time last weekend converting Peter Norvig's <a href="http://norvig.com/spell-correct.html">simple Python spell-checker</a> to Scala.  I didn't do this conversion alone; I got some great answers from <a href="http://dcsobral.blogspot.com/">Daniel Sobral</a>, <a href="http://www.codecommit.com/blog/">Daniel Spiewak</a> and finally <A href="http://dwins.wordpress.com/">David Winslow</a> on <a href="http://stackoverflow.com/questions/1780459/how-can-i-approximate-pythons-or-operator-for-set-comparison-in-scala">Stack Overflow</a>. David provided the answer I needed for the best way to implement the matching function in Scala 2.7.</p>
<!-- break -->
<p>Here's Peter Norvig's 21 lines (not counting blank lines) of Python 2.5 code, for comparison.</p>

{% highlight python %}
import re, collections

def words(text): return re.findall('[a-z]+', text.lower())

def train(features):
    model = collections.defaultdict(lambda: 1)
    for f in features:
        model[f] += 1
    return model

NWORDS = train(words(file('big.txt').read()))

alphabet = 'abcdefghijklmnopqrstuvwxyz'

def edits1(word):
   s = [(word[:i], word[i:]) for i in range(len(word) + 1)]
   deletes    = [a + b[1:] for a, b in s if b]
   transposes = [a + b[1] + b[0] + b[2:] for a, b in s if len(b)>1]
   replaces   = [a + c + b[1:] for a, b in s for c in alphabet if b]
   inserts    = [a + c + b     for a, b in s for c in alphabet]
   return set(deletes + transposes + replaces + inserts)

def known_edits2(word):
    return set(e2 for e1 in edits1(word) for e2 in edits1(e1) if e2 in NWORDS)

def known(words): return set(w for w in words if w in NWORDS)

def correct(word):
    candidates = known([word]) or known(edits1(word)) or known_edits2(word) or [word]
    return max(candidates, key=NWORDS.get)
{% endhighlight %}

<p>And now, the Scala 2.7 version that I came up with. It's 24 non-whitespace lines, although the average line is longer than the Python version.</p>

{% highlight scala %}
import scala.io.Source

val alphabet = "abcdefghijklmnopqrstuvwxyz"

def train(text:String) = {
  "[a-z]+".r.findAllIn(text).foldLeft(Map[String, Int]() withDefaultValue 1)
    {(a, b) => a(b) = a(b) + 1}
}

val NWORDS = train(Source.fromFile("big.txt").getLines.mkString.toLowerCase)

def known(words:Set[String]) = {Set.empty ++ (for(w <- words if NWORDS contains w) yield w)}

def edits1(word:String) = {
  Set.empty ++ // The next four are deletes, transposes, replaces and inserts, respectively.
  (for (i <- 0 until word.length) yield (word take i) + (word drop (i + 1))) ++
  (for (i <- 0 until word.length - 1) yield (word take i) + word(i + 1) + word(i) + (word drop (i + 2))) ++
  (for (i <- 0 until word.length; j <- alphabet) yield (word take i) + j + (word drop (i+1))) ++
  (for (i <- 0 until word.length; j <- alphabet) yield (word take i) + j + (word drop i))
}

def known_edits2(word:String) = {Set.empty ++ (for
  (e1 <- edits1(word); e2 <- edits1(e1) if NWORDS contains e2) yield e2)}

def correct(word: String) = {
  val sets = List[String => Set[String]](
    x => known(Set(x)), x => known(edits1(x)), known_edits2
  ).elements.map(_(word))

  sets find { !_.isEmpty } match {
    case Some(candidates) => candidates.reduceLeft { (res, n) => if (NWORDS(res) > NWORDS(n)) res else n }
    case None => word
  }
}
{% endhighlight %}

<p>Still, it's a pretty terse bit of code, and it works much like the Python version. Tune in a bit later for an explanation of some of the constructs at work here, and an even nicer Scala 2.8 version of the code.</p>
