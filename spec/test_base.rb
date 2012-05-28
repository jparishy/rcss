require '../lib/rcss'

class Box < CSSClass
  
  def initialize
    @rules = {
      width: 128,
      height: 32,
      background_color: "red",
      margin_left: 0,
    }
  end
end

class BoxAnimation < CSSAnimation
  
  def initialize
    super
    @class = Box.new
  end
  
  def do_animations
    shake_dat_shit 20, 4, 0.5
  end
  
  def shake_dat_shit(amount, iterations, duration)
    originalMarginLeft = @class[:margin_left]
    
    unless iterations == 0
      animation (duration / 4.0), 0, nil, -> {
        @class[:margin_left] += amount
      }, -> {
        animation (duration / 2.0), 0, nil, -> {
          @class[:margin_left] -= amount * 2.0
        }, -> {
          animation (duration / 4.0), 0, nil, -> {
           @class[:margin_left] = originalMarginLeft
          }, -> {
            shake_dat_shit (amount / 2.0).floor, iterations - 1, duration / 2.0
          }
        }
      }
    end
  end
end

anim = BoxAnimation.new
anim.export "../example/rcss-anim.css", "../example/rcss-anim.js"
