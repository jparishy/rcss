require '../lib/rcss'

class Box < CSSClass
  
  def initialize
    @rules = {
      width: 128,
      height: 128,
      _webkit_transform: "rotate3d(0, 1, 0, 0deg)",
      background_color: "red",
      border_radius: 64,
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
      @class.rules[:border_radius] = 32
    }, -> { 
      animation 1, 0, nil, -> {
        @class.rules[:height] = 256
        @class.rules[:border_radius] = 128
        @class.rules[:background_color] = "yellow";
      }, -> {
        animation 1, 0, nil, -> {
          @class.rules[:background_color] = "blue"
          @class.rules[:_webkit_transform] = "rotate3d(0, 1, 0, -180deg)"
        }, -> {
          
        }
      }
    }
  end
end

anim = BoxAnimation.new
anim.export "../example/rcss-anim.css", "../example/rcss-anim.js"
