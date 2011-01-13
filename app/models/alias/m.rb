module Alias::M
  
  include Alias::N
  
  alias old_t t
  
  def t(code,options={})
    p "-----------------------"
    old_t(code, options.merge(:www => 1))
  end
  
end