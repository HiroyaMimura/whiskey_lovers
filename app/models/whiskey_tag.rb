class WhiskeyTag < ApplicationRecord

  belongs_to :whiskey
  belongs_to :tag

  validates :whiskey_id, presence: true
  validates :tag_id, presence: true

end
