class Item < ActiveRecord::Base
  
  validates_presence_of :start, :end
  
  
  def validate
    return unless self.start || self.end
    if self.start > self.end  
      errors.add(:incorrect_intrval_format, 'start should be < then end')
    else
      errors.add(:intersection, 'intersect!!!') if 
      Item.find :first, :conditions => 
      [
        "(start < :start and end > :start) OR (start < :end and end > :end) OR (start > :start and end < :end)", 
        { :start => self.start, :end => self.end }
      ]
    end
    
  end
  
end
