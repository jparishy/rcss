
require_relative 'css_base_serializable'

class CSSAnimation < CSSBaseSerializable

  def initialize
    @keyframes = [ ]
    @animation_classes = [ ]
    @keyframe_step = 0
  end

  def self.generate_css
    Object::const_get(self.name).new.css
  end
  
  def css
    do_animations
    [ @keyframes.join("\n\n"), @animation_classes.join("\n\n") ].join("\n\n")
  end
  
  def do_animations
    puts "You need to implement #{self.class.name}#do_animations!"
  end
  
  def cache_current_values
    @class.rules.dup
  end
  
  def pixelatize_value(val)
    out = val.to_s
    if val.class == Fixnum or val.class == Float
      out << "px"
    end
    
    out
  end
  
  def generate_keyframes_for_variables(old_vars, new_vars)
    
    keyframe_lines = [ ]
    keyframe_lines << "@-webkit-keyframes #{self.class.name}-step-#{@keyframe_step} {"
    
    keyframe_lines << "  from {"
    
    # Add the original values in here
    old_vars.each do |name, value|
      keyframe_lines << "    #{name.to_s.gsub("_", "-")}: #{pixelatize_value value};"
    end
    
    keyframe_lines << "  }\n"
    
    keyframe_lines << "  to {"
    
    # Add the animated values in here
    new_vars.each do |name, value|
      keyframe_lines << "    #{name.to_s.gsub("_", "-")}: #{pixelatize_value value};"
    end
    
    keyframe_lines << "  }"
    keyframe_lines << "}"
    
    @keyframes << keyframe_lines.join("\n")
  end
  
  def generate_class_for_animation_step(duration, delay, options)
    class_lines = [ ]
    class_lines << ".#{self.class.name}#{@keyframe_step} {"
    
    class_lines << "  -webkit-animation-name: \"#{self.class.name}-step-#{@keyframe_step}\";"
    class_lines << "  -webkit-animation-duration: #{duration}s;"
    class_lines << "  -webkit-animation-delay: #{delay}s;"
    class_lines << "  -webkit-animation-fill-mode: forwards;"
    class_lines << "  -webkit-animation-timing-function: ease-in-out;"
    class_lines << "}"
    
    @animation_classes << class_lines.join("\n")
  end
  
  def javascript
    
    class_name = self.class.name
    js_lines = [ ]
    js_lines << "function #{class_name}(elementName) {"
    js_lines << "  element = $(elementName);"
    js_lines << "  element.addClass(\"#{class_name}0\");\n\n"
    js_lines << "  element.bind(\"webkitAnimationEnd\", function() {"
    
    @keyframe_step.times do |i|
      
      ifType = "else if"
      ifType = "if" if i == 0
      
      js_lines << "    #{ifType}(element.hasClass(\"#{class_name}#{i}\")) {";
      
      unless i == (@keyframe_step - 1)
        js_lines << "      element.toggleClass(\"#{class_name}#{i}\")"
        js_lines << "      element.toggleClass(\"#{class_name}#{i + 1}\")"
      end
      
      js_lines << "    }"
      
    end
    
    js_lines << "  });"
    js_lines << "}"
    
    js_lines.join("\n")
  end
  
  def export(css_filename, javascript_filename)
    
    css_file = File.new css_filename, "w+"
    css_file << @class.css
    css_file << "\n\n"
    css_file << self.css
    css_file << "\n"
    css_file.close
    
    js_file = File.new javascript_filename, "w+"
    js_file << self.javascript
    js_file << "\n"
    js_file.close
    
  end
  
  def simulate_animation(duration, delay, options, animationLambda)
    
    # Cache values
    old_vars = cache_current_values
    animationLambda.call
    new_vars = cache_current_values
    
    # Generate the animations
    generate_class_for_animation_step duration, delay, options
    generate_keyframes_for_variables old_vars, new_vars
    @keyframe_step += 1
  end
  
  def animation(duration, delay, options, animationLambda, completionLambda)
    
    simulate_animation duration, delay, options, animationLambda
    completionLambda.call
  end
end