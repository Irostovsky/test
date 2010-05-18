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
  
#    Доказательство
#    Возможные варианты пересечения
#    1.            x|------------------|y
#          a|------------|b
#          
#          a<x<b<y
#    2.            x|------------------|y
#                              a|------------|b
#          
#          x<a<y<b
#    3.            x|------------------|y
#                       a|-------|b
#          
#          x<a<b<y
#    4.            x|--------|y
#             a|-----------------|b
#          
#          a<x<y<b
#          
# Итого имеем  систему неравенств
#   a<x<b<y 
#   x<a<y<b 
#   x<a<b<y 
#   a<x<y<b
# 
# Очевидно что выражение a<x или x<a дает всю ось те для нас бесполезно(за исключением одной точки)
# аналогично b<y или y<b
# Тогда получаем b>x && a<y       
      
end