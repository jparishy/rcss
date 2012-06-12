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
    
    def value
      @value
    end
    
    def value=(val)
      @value = val
    end
    
    def qualifier
      @qualifier
    end
    
    def qualifier=(qualifier)
      @qualifier = qualifier
    end
    
    def wrap_quotes
      @wrap_quotes
    end
    
    def wrap_quotes=(wrap_quotes)
      @wrap_quotes = wrap_quotes
    end
    
    def dup
      rule = CSSRule.new @name, @value
      rule.qualifier = @qualifier
      rule.wrap_quotes = @wrap_quotes
      
      rule
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
      if @value.class == Float and @qualifier == :px
        val = val.to_i
      end
      
      val = "\"#{val}\"" if @wrap_quotes
      
      name = @name.to_s.gsub("_", "-")
      
      "#{name}: #{val}#{@qualifier if @qualifier != :none};"
    end
    
  end
  
end
