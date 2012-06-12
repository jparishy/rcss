#
# css_animation.rb
# Ruby representation of a CSS animation
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

require_relative 'css_base_serializable'
require_relative 'css_keyframe'
require_relative 'css_keyframe_exporter'

module Rcss

  class CSSAnimation < CSSBaseSerializable

    @@current_animation = nil
    
    def self.current_animation
      @@current_animation
    end
    
    def self.set_current_animation anim
      @@current_animation = anim
    end

    def initialize
      @keyframes = { }
      @total_duration = 0
      
      CSSAnimation.set_current_animation self
    end
    
    def register_class css_class
      @registered_classes = [ ] if @registered_classes == nil
      
      @registered_classes << css_class
      puts "Registered #{css_class} with current animation."
    end
  
    def css
      do_animations
      [ @keyframes.join("\n\n"), @animation_classes.join("\n\n") ].join("\n\n")
    end
  
    def do_animations
      puts "You need to implement #{self.class.name}#do_animations!"
    end
  
    def cache_class_rules the_class
      rules = { }
      the_class.rules.each do |name, rule|
        rules[name] = rule.dup
      end
      
      rules
    end
  
    def pixelatize_value(val)
      out = val.to_s
      if val.class == Fixnum or val.class == Float
        out << "px"
      end
    
      out
    end
    
    def filter_changed_rules old_rules, new_rules
      changed_rules = { }
      
      new_rules.each do |name, value|
        if old_rules[name].value != value.value then
          changed_rules[name] = value
        end
      end
      
      changed_rules
    end
    
    #
    # Generates keyframes for any changec classes during the last animation.
    #
    def generate_keyframes duration, delay, options, old_class_rules, new_class_rules
      
      changed_css_rules = { }
      old_class_rules.each do |css_class, rules|
        changed_css_rules[css_class] = filter_changed_rules(rules, new_class_rules[css_class])
      end
      
      changed_css_rules.each do |css_class, rules|
        @keyframes[css_class] = [ ] if @keyframes[css_class] == nil
        
        if delay != 0 then
          delay_keyframe = CSSKeyframe.new delay, nil
          @keyframes[css_class] << delay_keyframe
        end
        
        animation_keyframe = CSSKeyframe.new duration, rules
        @keyframes[css_class] << animation_keyframe
      end
    end
  
    def simulate_animation(duration, delay, options, animationLambda)
    
      # Cache values
      old_class_rules = { }
      @registered_classes.each do |c|
        old_class_rules[c] = cache_class_rules(c)
      end
      
      animationLambda.call
      new_class_rules = { }
      @registered_classes.each do |c|
        new_class_rules[c] = cache_class_rules(c)
      end
    
      # Generate the animations
      generate_keyframes duration, delay, options, old_class_rules, new_class_rules
    end
  
    def animation(duration, delay, options, animationLambda, completionLambda)
      
      @total_duration += (duration + delay)
    
      if @registered_classes != nil and @registered_classes.length != 0 then
        simulate_animation duration, delay, options, animationLambda
        completionLambda.call
      else
        puts "Warning: No animations can be simulated without first registering a class."
      end
    end
    
    def generate
      do_animations
      
      @registered_classes.each do |c|
        puts c.css
      end
      
      @keyframes.each do |css_class, keyframes|
        current_time = 0
        
        puts "@-webkit-keyframes #{self.class.name}-#{css_class.name}-keyframes {\n"
        
        keyframes.each do |keyframe|
          puts CSSKeyframeExporter.export keyframe, current_time, @total_duration
          current_time += keyframe.duration
        end
        puts "}\n\n"
      end
    end
    
  end

end
