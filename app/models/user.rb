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

  # def get_profile_image
  #   unless profile_image.attached?
  #     file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  #   end
  #     profile_image
  # end

  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io:File.open(file_path),filename:'default-image.jpg',content_type:'image/jpeg')
    end
      profile_image
  end

  def self.guest
    find_or_create_by!(name: 'ゲストユーザー' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

end
