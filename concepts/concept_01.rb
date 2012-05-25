#
# This is a concept file.
#
# Basically, this is what I want the generated output for this
# all to look like.
#
# Status: WIP
#

#
# This is the source Ruby code.
#

require 'rcss'

class Box < Rcss::CSSClass
	@width = 100
	@height = 100
end

class BoxAnimation < Rcss::CSSAnimation
	@css_class = Box

	def do_animations

		# Animate the Box width to 200 over 1 second, with no delay or options
		animation 1.0, 0.0, nil, -> {
			@width = 200
		}, -> {
			# Animate the Box height to 400 over 1 second, with no delay or options
			animation 1.0, 0.0, nil, -> {
				@height 400
			}, -> {
				# Nothing
			}
		}
	end
end

#
# This is the generated CSS
#

.box {
	width: 100px;
	height: 100px;
}

@keyframes box-animation-1 {
	from {
		width: 100;
	}

	to {
		width: 200;
	}
}

@keyframes box-animation-2 {
	from {
		height: 100px;
	}

	to {
		height: 400px;
	}
}

#
# This is the generated JavaScript (the glue)
#

function box_animation_start()
{
	__box_animation_start_1()
}

function __box_animation_start_1()
{
	// 1.0 - Add 1 to CSS style
	// Setup finished animation event
}

function __box_animation_finished_1()
{
	__box_animation_start_2();
}

function __box_animation_start_2()
{
	// 1.0 Remove 1 from CSS style

	// 2.0 Add 2 to CSS style
}
