---
layout: post
title: "Dude, Where's My Bot?"
created: 1317838029
categories:
- node.js
- irc
---

Say what you will about node.js, but it is certainly an easy way to build IRC bots with the [Jerk library](https://github.com/gf3/Jerk).

The PHP-based bot that runs in the [Treehouse Agency](http://www.treehouseagency.com) IRC channels knows to respond to "Sweet!" with "Dude!" and vice versa. [Brian McMurray](http://www.brianmcmurray.com) said that he'd like to someday write a quick-and-dirty bot that would put our other bot into an infinite loop.

I accepted that challenge, and 10 minutes later, the bot was done.

The code is an example of how to build a bot that accepts environmental variables for configuration and otherwise does a pretty silly task.

<!-- break -->
All in all, node makes this *really* simple.

{% highlight javascript %}
var jerk = require('jerk'),
    channel = ('SWEETDUDEBOT_CHANNEL' in process.env)? process.env.SWEETDUDEBOT_CHANNEL : '#yourchannel',
    options = {
      server: ('SWEETDUDEBOT_SERVER' in process.env)? process.env.SWEETDUDEBOT_SERVER : 'chat.freenode.net',
      nick: ('SWEETDUDEBOT_NICK' in process.env)? process.env.SWEETDUDEBOT_NICK : 'sweetdudebot',
      port: ('SWEETDUDEBOT_PORT' in process.env)? process.env.SWEETDUDEBOT_PORT : '6667',
      flood_protection: true,
      channels: [channel]
    };

var sweet_dude_bot = jerk(function(j) {
  j.watch_for( /^(Sweet|Dude)!$/, function(message) {
    var result = message.match_data[1];
    if (!result)
      return;

    switch (result) {
      case "Sweet":
        message.say("Dude!");
        break;
      case "Dude":
        message.say("Sweet!");
        break;
    }
  })
}).connect(options)
{% endhighlight %}

You can fork [node-sweetdudebot](https://github.com/smerrill/node-sweetdudebot) or its predecessor, [node-sedbot](https://github.com/smerrill/node-sedbot) on GitHub. Enjoy!
