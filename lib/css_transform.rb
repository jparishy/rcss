#
# css_transform.rb
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

require_relative 'css_base_serializable'

module Rcss
  
  class CSSTransform < CSSBaseSerializable
    def initialize
    
    end
  
    def self.identity
      CSSTransform.new
    end
  end
  
end
