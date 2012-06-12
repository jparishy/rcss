require '../lib/rcss'

class Box < Rcss::CSSClass
  
  def initialize(name, width, height)
    super(name)
    
    rules = {
      width: width,
      height: height,
      background_color: "red",
      margin_left: 250,
      margin_top: 250
    }
    
    add_rules rules
  end
  
end

class BoxAnimation < Rcss::CSSAnimation
  
  def initialize
    super
    @box1 = Box.new "Box1", 128, 128
  end
  
  def do_animations
    move_in_a_circle 100, 36, 1
  end
  
  def move_in_a_circle(radius, steps, duration)
    left_orig = @box1[:margin_left]
    top_orig = @box1[:margin_top]
    step_duration = (Float(duration) / Float(steps))
    step_size = ((Math::PI * 2.0) / steps)
    circle_step radius, 0, steps, step_duration, step_size, left_orig, top_orig
  end
  
  def circle_step radius, angle, steps_left, step_duration, step_size, left_orig, top_orig
    unless steps_left == 0
      animation step_duration, 0, nil, -> {
        @box1[:margin_left] = left_orig + (Math.cos(angle) * radius)
        @box1[:margin_top]  = top_orig  + (Math.sin(angle) * radius)

        angle += step_size
      }, -> {
        circle_step radius, angle, steps_left - 1, step_duration, step_size, left_orig, top_orig
      }
    end
  end
  
  def shake_dat_shit(amount, iterations, duration)
    originalMarginLeft = @box1[:margin_left]
    
    unless iterations == 0
      animation (duration / 4.0), 0, nil, -> {
        @box1[:margin_left] += amount
      }, -> {
        animation (duration / 2.0), 0, nil, -> {
          @box1[:margin_left] -= amount * 2.0
        }, -> {
          animation (duration / 4.0), 0, nil, -> {
           @box1[:margin_left] = originalMarginLeft
          }, -> {
            shake_dat_shit (amount / 2.0).floor, iterations - 1, duration / 2.0
          }
        }
      }
    end
  end
end

anim = BoxAnimation.new
anim.generate
