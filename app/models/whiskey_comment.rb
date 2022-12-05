class WhiskeyComment < ApplicationRecord

  belongs_to :user
  belongs_to :whiskey

  validates :comment, length: { maximum: 150 }, presence: true

end
