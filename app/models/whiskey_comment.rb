class WhiskeyComment < ApplicationRecord

  belongs_to :user
  belongs_to :whiskey
  has_many :notifications, dependent: :destroy

  validates :comment, length: { maximum: 400 }, presence: true

end
