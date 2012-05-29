require '../lib/rcss'

class Box < Rcss::CSSClass
  
  def initialize
    @rules = {
      width: 128,
      height: 32,
      background_color: "red",
      margin_left: 0,
    }
  end
end

class BoxAnimation < Rcss::CSSAnimation
  
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

class Header < Rcss::CSSClass
  def initialize
    @rules = {
      width: 1200,
      height: 250,
      background_color: "rgb(100, 180, 230)",
      opacity: "0",
      margin_top: 0,
      font_family: "Helvetica Neue",
      font_size: "24pt",
      text_align: "center",
      border_radius: 5
    }
  end
end

class HeaderAnimation < Rcss::CSSAnimation
  def initialize
    super
    @class = Header.new
  end
  
  def do_animations
    # Fade in and drop down from above
    @class[:margin_top] = -@class[:height] - 25
    animation 0.5, 0, nil, -> {
      @class[:opacity] = "0.5"
      @class[:margin_top] = @class[:height] / 8
    }, -> {
      animation 0.2, 0, nil, -> {
        @class[:opacity] = "1"
        @class[:margin_top] = 0
      }, -> {
        
      }
    }
  end
end

anim = HeaderAnimation.new
anim.export "./stylesheets/rcss-anim.css", "./js/rcss-anim.js"
