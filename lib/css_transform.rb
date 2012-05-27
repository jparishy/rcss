
require_relative 'css_base_serializable'

class CSSTransform < CSSBaseSerializable
  def init
    
  end
  
  def self.identity
    CSSTransform.new
  end
end
