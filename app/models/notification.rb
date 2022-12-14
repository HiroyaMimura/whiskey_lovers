class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  belongs_to :whiskey, optional: true
  belongs_to :wiskey_comment, optional: true

end
