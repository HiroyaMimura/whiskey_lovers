class Notification < ApplicationRecord
  belongs_to :visitor
  belongs_to :visited
  belongs_to :whiskey
  belongs_to :comment
end
