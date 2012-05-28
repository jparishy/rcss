
require_relative 'css_base_serializable'

class CSSClass < CSSBaseSerializable
  
  def pixelatize_value(val)
    out = val.to_s
    if val.class == Fixnum or val.class == Float
      out << "px"
    end
    
    out
  end
  
  def css
    class_lines = [ ]
    class_lines << ".#{self.class.name} {"
    
    @rules.each do |name, value|
      class_lines << "  #{name.to_s.gsub("_", "-")}: #{pixelatize_value value};"
    end
    
    class_lines << "}"
    
    class_lines.join("\n")
  end
  
  def rules
    @rules
  end
  
  def [](symbol)
    @rules[symbol]
  end
  
  def []=(symbol, value)
    @rules[symbol] = value
  end
  
end
