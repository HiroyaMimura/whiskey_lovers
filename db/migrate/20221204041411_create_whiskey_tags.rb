class CreateWhiskeyTags < ActiveRecord::Migration[6.1]
  def change
    create_table :whiskey_tags do |t|

      t.references :whiskey_id, null: false, foreign_key: true
      t.references :tag_id, null: false, foreign_key: true
      t.timestamps
    end
    # 複合キーインデックスで、この記述で同じタグを2回保存できないようにする
    add_index :whiskey_tags, [:whiskey_id, :tag_id], unique: true

  end
end
