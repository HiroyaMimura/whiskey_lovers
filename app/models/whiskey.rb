class Whiskey < ApplicationRecord
  
  has_one_attached :whiskey_image
  belongs_to :user
  has_many :whiskey_comments, dependent: :destroy
  has_many :whiskey_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
end
