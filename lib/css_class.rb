#
# css_class.rb
# Ruby representation of a CSS class
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

require_relative 'css_base_serializable'

module Rcss

  class CSSClass < CSSBaseSerializable
    
    def initialize name
      @name = name
      CSSAnimation.current_animation.register_class self
    end
    
    def name
      @name
    end
    
    def add_rule name, value
      @rules = { } if @rules == nil
      
      @rules[name] = CSSRule.new name, value
    end
    
    def add_rules rules_hash
      rules_hash.each do |name, value|
        add_rule name, value
      end
    end
  
    def pixelatize_value(val)
      out = val.to_s
      if val.class == Fixnum or val.class == Float
        out << "px"
      end
    
      out
    end
  
    def css
      class_lines = [ ]
      class_lines << ".#{@name} {"
    
      @rules.each do |name, value|
        class_lines << "  #{value.export_css}"
      end
    
      class_lines << "}"
    
      class_lines.join("\n")
    end
  
    def rules
      @rules
    end
  
    def [](symbol)
      @rules[symbol].value
    end
  
    def []=(symbol, value)
      @rules[symbol].value = value
    end
  
  end

end
