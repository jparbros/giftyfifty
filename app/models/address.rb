class Address < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :user
  
  def completed?
    !country.nil? && !state.nil? && !city.nil? && !address_1.nil? && !zip_code.nil? && !country.blank? && !state.blank? && !city.blank? && !address_1.blank? && !zip_code.blank?
  end
end
