class Tag < ApplicationRecord
  
  has_many :whiskey_tags, dependent: :destroy
  
end
