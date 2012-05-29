#
# css_rule.rb
# Ruby representation of a CSS rule
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

module Rcss

  class CSSRule
    
    def initialize(name, value)
      
      @name = name
      
      case value
      when Float
        initialize_float value
      when Fixnum
        initialize_fixnum value
      when String
        initialize_string value
      else
        throw "Unsupported CSS rule value type."
      end
      
    end
    
    def initialize_float(value)
      @qualifier = :none
      @wrap_quotes = false
      
      @value = value
    end
    
    def initialize_fixnum(value)
      @qualifier = :px
      @wrap_quotes = false
      
      @value = value
    end
    
    def initialize_string(value)
      @qualifier = :none
      @wrap_quotes = true
      
      @value = value
    end
    
    def export_css
      val = @value
      val = "\"#{val}\"" if @wrap_quotes
      
      "#{@name.to_s}: #{val}#{@qualifier if @qualifier != :none};"
    end
    
  end
  
end
