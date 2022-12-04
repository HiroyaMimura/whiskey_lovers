class Whiskey < ApplicationRecord

  has_one_attached :whiskey_image
  belongs_to :user
  has_many :whiskey_comments, dependent: :destroy
  has_many :whiskey_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 30 }, uniqueness: true
  validates :impression, length: { maximum: 80 }
  validates :whiskey_image, presence:true
  validates :performance, presence:true
  

  def self.looks(word)
    if @whiskey = Whiskey.where("name LIKE?","%#{word}%")
    else
      @whiskey = Whiskey.all
    end
  end

  def self.looks(price)
    @whiskey = Whiskey.where("price_range LIKE?", "#{price}")
  end

end
