class Address < ActiveRecord::Base
  #
  # Associations
  #
  belongs_to :user
end
