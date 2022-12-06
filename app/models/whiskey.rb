class Whiskey < ApplicationRecord

  has_one_attached :whiskey_image
  belongs_to :user
  has_many :whiskey_comments, dependent: :destroy
  has_many :whiskey_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, length: { maximum: 30 }, presence: true
  validates :impression, length: { maximum: 150 }, presence: true
  validates :whiskey_image, presence: true


  def self.looks(word)
    if @whiskey = Whiskey.where("name LIKE?","%#{word}%")
    else
      @whiskey = Whiskey.all
    end
  end

  def self.looks(price)
    @whiskey = Whiskey.where("price_range LIKE?", "#{price}")
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
