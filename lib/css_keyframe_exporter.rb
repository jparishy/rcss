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

  class CSSKeyframeExporter
    
    def self.export keyframe, start_time, total_duration
      
      percentage = CSSKeyframeExporter.percentage_string keyframe, start_time, total_duration
      keyframe_str = "  #{percentage} {\n"
      
      if keyframe.rules != nil then
        keyframe.rules.each do |name, value|
          keyframe_str << "    #{value.export_css}\n"
        end
      end
      
      keyframe_str << "  }\n"
      
      keyframe_str
    end
    
    def self.percentage_string keyframe, start_time, total_duration
      percentage = (((start_time + Float(keyframe.duration))/Float(total_duration)) * 100.0).ceil
      
      "#{percentage}%"
    end
  end
end
