class Tag < ApplicationRecord

  has_many :whiskey_tags, dependent: :destroy
  # タグは複数の投稿を持つので、whiskey_tagsを通じて参照できる
  has_many :whiskeys, through: :whiskey_tags, dependent: :destroy
  # uniquenessはオブジェクトが保存される直前に、属性の値が一意であり重複していないことを検証する
  validates :tag, length: { maximum: 100 }, uniqueness: true

end
