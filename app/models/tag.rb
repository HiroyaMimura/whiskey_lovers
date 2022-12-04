class Tag < ApplicationRecord
  
  has_many :whiskey_tags, dependent: :destroy
  
  validates :tag, length: { minimum: 2, maximum: 10 }, uniqueness: true
  
  def self.looks(word)
    if @tag = Tag.where("tagLIKE?","%#{word}%")
    else
      @tag = Whiskey.all
    end
  end
  
end
