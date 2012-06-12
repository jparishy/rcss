#
# css_keyframe.rb
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

require_relative 'css_base_serializable'

module Rcss
  
  class CSSKeyframe < CSSBaseSerializable
  
    def initialize(duration, rules)
      @duration = duration
      @rules = rules
    end
    
    def duration
      @duration
    end
    
    def rules
      @rules
    end
  end
end
