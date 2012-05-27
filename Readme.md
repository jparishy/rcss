# RCSS

#### **Note: This is under active development and is not even usable, but I was running low on private repositories so I just left this one open or now. Feel free to follow along but don't expect anything quite yet.**

### About
RCSS is an attempt at playing with CSS animations using Ruby. I find CSS to be rather infuriating to write, so I figured I'd try to find a way to generate CSS using Ruby instead. The goal here is to have a nicer interface for developing CSS animations and dynamically calculating values for the CSS without having to use something like SCSS or Less. Ruby has a familiar syntax, so that's what I want.

It looks like this:

1. One should write a script like so:
	```ruby
	require '../lib/rcss'

	class Box < CSSClass

	  def initialize
	    @rules = {
	      width: 128,
	      height: 128,
	      _webkit_transform: "rotate3d(0, 1, 0, 180deg)",
	      background_color: "red"
	    }
	  end
	end

	class BoxAnimation < CSSAnimation

	  def initialize
	    super

	    @class = Box.new
	  end

	  def do_animations
	    animation 1, 0, nil, -> {
	      @class.rules[:width] = 256
	    }, -> { 
	      animation 1, 0, nil, -> {
	        @class.rules[:height] = 256
	      }, -> {
	        # Done!
	        animation 1, 0, nil, -> {
	          @class.rules[:_webkit_transform] = "rotate3d(0, 1, 0, -180deg)"
	        }, -> {

	        }
	      }
	    }
	  end
	end

	anim = BoxAnimation.new
	anim.export "../example/rcss-anim.css", "../example/rcss-anim.js"
	```
2. Which would generate a few files like these:
  ```css
	.Box {
	  width: 128px;
	  height: 128px;
	  -webkit-transform: rotate3d(0, 1, 0, 180deg);
	  background-color: red;
	}

	@-webkit-keyframes BoxAnimation-step-0 {
	  from {
	    width: 128px;
	    height: 128px;
	    -webkit-transform: rotate3d(0, 1, 0, 180deg);
	    background-color: red;
	  }

	  to {
	    width: 256px;
	    height: 128px;
	    -webkit-transform: rotate3d(0, 1, 0, 180deg);
	    background-color: red;
	  }
	}

	@-webkit-keyframes BoxAnimation-step-1 {
	  from {
	    width: 256px;
	    height: 128px;
	    -webkit-transform: rotate3d(0, 1, 0, 180deg);
	    background-color: red;
	  }

	  to {
	    width: 256px;
	    height: 256px;
	    -webkit-transform: rotate3d(0, 1, 0, 180deg);
	    background-color: red;
	  }
	}

	@-webkit-keyframes BoxAnimation-step-2 {
	  from {
	    width: 256px;
	    height: 256px;
	    -webkit-transform: rotate3d(0, 1, 0, 180deg);
	    background-color: red;
	  }

	  to {
	    width: 256px;
	    height: 256px;
	    -webkit-transform: rotate3d(0, 1, 0, -180deg);
	    background-color: red;
	  }
	}

	.BoxAnimation0 {
	  -webkit-animation-name: "BoxAnimation-step-0";
	  -webkit-animation-duration: 1s;
	  -webkit-animation-delay: 0s;
	  -webkit-animation-fill-mode: forwards;
	}

	.BoxAnimation1 {
	  -webkit-animation-name: "BoxAnimation-step-1";
	  -webkit-animation-duration: 1s;
	  -webkit-animation-delay: 0s;
	  -webkit-animation-fill-mode: forwards;
	}

	.BoxAnimation2 {
	  -webkit-animation-name: "BoxAnimation-step-2";
	  -webkit-animation-duration: 1s;
	  -webkit-animation-delay: 0s;
	  -webkit-animation-fill-mode: forwards;
	}
  ```
  ```javascript
	function BoxAnimation(elementName) {
	  element = $(elementName);
	  element.addClass("BoxAnimation0");


	  element.bind("webkitAnimationEnd", function() {
	    if(element.hasClass("BoxAnimation0")) {
	      element.toggleClass("BoxAnimation0")
	      element.toggleClass("BoxAnimation1")
	    }
	    else if(element.hasClass("BoxAnimation1")) {
	      element.toggleClass("BoxAnimation1")
	      element.toggleClass("BoxAnimation2")
	    }
	    else if(element.hasClass("BoxAnimation2")) {
	    }
	  });
	}
  ```
3. At which point you could use it like so:
  ```html
	<!DOCTYPE html>
	<html>
	<header>
		<link rel="stylesheet" type="text/css" href="rcss-anim.css" />
	</header>

	<body>
		<div id="Box" class="Box">Test</div>
	</body>

	<script type="text/javascript" src="jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="rcss-anim.js"></script>

	<script type="text/javascript">
	BoxAnimation("#Box");
	</script>

	</html>
  ```
4. And it should Just Work(tm)

My understanding of CSS3 kind of sucks so this may change as I continue working.

Hopefully this turns out sweet!

# Author
Julius Parishy [Follow me on Twitter](https://twitter.com/jparishy)

# License
MIT License, Copyright (C) 2012
