module Mod2
  module ClassMethods
    def sm2
      p 'sm2'
    end
  end

  def m2
    p 'm2'
  end
  
end

module Mod1
  
  include Mod2
  def self.included(host_class)
    host_class.extend Mod2::ClassMethods
    
    def host_class.sm1
      p 'sm1'
    end
  end
  
end

class A
  include Mod1
  
  def self.sa1
    self.sm1
    self.sm2
  end
  
  def a2
    m2
  end
end

