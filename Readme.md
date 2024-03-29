# RCSS

***Keep in mind that I am no CSS3 expert. My background is all in native development. This is an experiment, after all!***

### About
RCSS is a system built on top of Ruby to generate CSS animation using code that looks a lot like the convenience methods from CoreAnimation on iOS.


Essentially, an animation is composed of a `duration`, a `delay`, some `options`, the actual `animation`, and a `completion` block.
Structurally, RCSS uses the style of `UIView#animateWithDuration:delay:options:animations:completion:`
```ruby
  animation theDuration, theDelay, someOptions, -> {
    # The animations
  }, -> {
    # The completion handler
  }
```

What makes this cool is the completion handler. Sure, you can write animations by hand. But what if you want to do something complex?
I certainly don't want to write an animation with 20+ keyframes by hand when I can generate them with some code...


That's what makes RCSS ***awesome***.


The completion handler allows you to chain single animations together to make one, complex animation.
**RCSS will generate the keyframe percentages and insert the rule changes** ***automatically.***

So, yeah that's pretty cool. But it gets betters. RCSS is Ruby. You can use anything you want in Ruby to generate animations.
You get the `Math` module and recursion **fo free!**


Try it for yourself. It's awesome. I promise.


### Dependencies
RCSS depends on Ruby (1.9.3) and a WebKit-based browser (Other vender prefixes coming soon!).


### Author
[@jparishy](https://twitter.com/jparishy) or [my blog](http://juliusparishy.com/).

# License
MIT License, Copyright (C) 2012
