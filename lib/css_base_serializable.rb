#
# css_keyframe_exporter.rb
# Responsible for exporting a CSS keyframe in memory to valid
# CSS as a string.
#
# MIT License
# Copyright (C) 2012 Julius Parishy
# http://juliusparishy.com/
#

module Rcss
  
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

end
