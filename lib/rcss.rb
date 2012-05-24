
class CSSBaseSerializable
  
  # Return some CSS for this object
  def css
    
  end
  
  def at_strip(s)
    if s.start_with? "@@"
      s = s[2..s.length]
    end
    
    s
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
      cached_variables[at_strip(var.to_s)] = self.class.class_variable_get(var)
    end
    
    cached_variables
  end
  
  def generate_animation_for_variable(name, old_value, new_value)
    "@-webkit-animation #{name}-anim {
      from {
        #{name}: #{old_value};
      }
      
      to {
        #{name}: #{new_value};
      }
    }"
  end
  
  def generate_animation_for_variables(old_vars, new_vars)
    anims = [ ]
    old_vars.each do |name, var|
      anims << generate_animation_for_variable(name, var, new_vars[name])
    end
    
    puts anims
  end
  
  def simulate_animation(duration, delay, options, animationLambda)
    
    # Cache values
    old_vars = cache_current_values
    animationLambda.call
    new_vars = cache_current_values
    
    # Generate the animations
    generate_animation_for_variables old_vars, new_vars
  end
  
  def animation(duration, delay, options, animationLambda, completionLambda)
    
    simulate_animation duration, delay, options, animationLambda
    completionLambda.call
  end
end

class MyAnimation < CSSAnimation
  
  def initialize
    @@width = 500
  end
  
  def do_animations
    animation 1, 0, nil, -> {
      # Some animations
      @@width = 1000
    }, -> { 
      animation 1, 0, nil, -> {
        # Some more animations
        @@width = 500
      }, -> {
        # Done!
      }
    }
  end
  
end

puts MyAnimation.generate_css
