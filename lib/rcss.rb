
class CSSBaseSerializable
  
  # Return some CSS for this object
  def css
    
  end
  
end

class CSSTransform < CSSBaseSerializable
  def init
    
  end
  
  def self.identity
    CSSTransform.new
  end
end

class CSSAnimation < CSSBaseSerializable

  def self.generate_css
    Object::const_get(self.name).new.css
  end
  
  def css
    do_animations
  end
  
  def do_animations
    puts "You need to implement #{self.class.name}#do_animations!"
  end
  
  def cache_current_values
    
    cached_variables = { }
    
    self.class.class_variables.each do |var|
      cached_variables[var.to_s] = self.class.class_variable_get(var)
    end
    
    cached_variables
  end
  
  def simulate_animation(duration, delay, options, animationLambda)
    
    # Cache values
    vars = cache_current_values
    
    #puts vars
    
    animationLambda.call
    
    # Calculate animations
  end
  
  def animation(duration, delay, options, animationLambda, completionLambda)
    
    # Do the animations....
    simulate_animation duration, delay, options, animationLambda
    
    completionLambda.call
  end
end

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

puts MyAnimation.generate_css
