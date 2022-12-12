class Whiskey < ApplicationRecord

  has_one_attached :whiskey_image
  belongs_to :user
  has_many :whiskey_comments, dependent: :destroy
  has_many :whiskey_tags, dependent: :destroy
  has_many :tags, through: :whiskey_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, length: { maximum: 30 }, presence: true
  validates :impression, length: { maximum: 150 }, presence: true
  validates :whiskey_image, presence: true
  validates :performance, presence: true

  def self.search(word)
    Whiskey.where("name LIKE?","%#{word}%")
  end

  def self.looks(price)
    Whiskey.where("price_range LIKE?", "#{price}")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_whiskey_tag = Tag.find_or_create_by(tag: new)
      self.tags << new_whiskey_tag
    end
  end
end
