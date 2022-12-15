class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, uniqueness: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true, length: {maximum: 20}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :whiskeys, dependent: :destroy
  has_many :whiskey_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key:"visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key:"visited_id", dependent: :destroy

  validate :image_content_type, if: :was_attached?

  def image_content_type
    extension = ['image/png', 'image/jpg', 'image/jpeg']
    errors.add(:image, "の拡張子が間違っています") unless profile_image.content_type.in?(extension)
  end

  def was_attached?
    self.profile_image.attached?
  end

  def get_profile_image
    unless profile_image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
      profile_image
  end

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

end
