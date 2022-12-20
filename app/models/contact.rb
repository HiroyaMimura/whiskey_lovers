class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :content, length: { maximum: 800 }, presence: true
end
