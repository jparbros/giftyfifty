class Provider < ActiveRecord::Base
  has_many :events
  
  def url
     "http://www.#{self.name}.com"
  end
end
