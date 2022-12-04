class WhiskeyComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :whiskey
  
end
