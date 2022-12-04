class WhiskeyTag < ApplicationRecord
  
  belongs_to :whiskey
  belongs_to :tag
  
end
