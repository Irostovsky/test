class Item < ActiveRecord::Base
  
  validates_presence_of :start, :end

  def validate_on_create
    return unless self.start || self.end
    if self.start > self.end  
      errors.add(:incorrect_intrval_format, 'start should be < then end')
    else
      errors.add(:intersection, 'intersect!!!') if 
      Item.find :first, :conditions => 
      [
        "start < :end and end > :start", 
        { :start => self.start, :end => self.end }
      ]
    end
  end
  
  def validate_on_update
    return unless self.start || self.end
    if self.start > self.end  
      errors.add(:incorrect_intrval_format, 'start should be < then end')
    else
      errors.add(:intersection, 'intersect!!!') if 
      Item.find :first, :conditions => 
      [
        "(start < :end and end > :start) AND id <> :id", 
        { :start => self.start, :end => self.end, :id => self.id }
      ]
    end
  end
  
end
