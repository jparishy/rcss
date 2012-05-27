
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
