class Whiskey < ApplicationRecord

  has_one_attached :whiskey_image
  belongs_to :user
  has_many :whiskey_comments, dependent: :destroy
  has_many :whiskey_tags, dependent: :destroy
  has_many :tags, through: :whiskey_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, length: { maximum: 60 }, presence: true
  validates :impression, length: { maximum: 400 }, presence: true
  validates :whiskey_image, presence: true
  validates :performance, presence: true
  has_many :notifications, dependent: :destroy

  validate :image_content_type, if: :was_attached?

  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:image, "の拡張子が間違っています") unless whiskey_image.content_type.in?(extension)
  end

  def was_attached?
    self.whiskey_image.attached?
  end

  def self.search(word)
    Whiskey.where("name LIKE?", "%#{word}%")
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

  def create_notification_favorite(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and whiskey_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        whiskey_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, whiskey_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = WhiskeyComment.select(:user_id).where(whiskey_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, whiskey_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, whiskey_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, whiskey_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      whiskey_id: id,
      whiskey_comment_id: whiskey_comment_id,
      visited_id: visited_id,
      action: 'whiskey_comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end