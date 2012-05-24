# RCSS

### About
RCSS is an attempt at playing with CSS animations using Ruby. I find CSS to be rather infuriating to right, so I figured I'd try to find a way to generate CSS using Ruby instead. The goal here is to have a nicer interface for developing CSS animations and dynamically calculating values for the CSS without having to use something like SCSS or Less. Ruby has a familiar syntax, so that's what I want.

The goal is to have animations that act somewhat like UIKit's UIView animation functions.

1. One should write a class inheriting CSSAnimation
2. One should implement do_animations like so:
	```ruby
	class MyAnimation < CSSAnimation

	  def initialize
	    @@transform = CSSTransform.identity
	  end

	  def do_animations
	    animation 1, 0, nil, -> {
	      # Some animations
	    }, -> { 
	      animation 1, 0, nil, -> {
	        # Some more animations
	      }, -> {
	        # Done!
	      }
	    }
	  end

	end
	```
3. One should then call `MyAnimation.generate_css` to get the CSS for that animation.

My understanding of CSS3 kind of sucks so this may change as I continue working.

Hopefully this turns out sweet!

# Author
Julius Parishy

# License
MIT License, Copyright (C) 2012
