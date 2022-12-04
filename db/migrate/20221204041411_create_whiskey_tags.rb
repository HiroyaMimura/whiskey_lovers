class CreateWhiskeyTags < ActiveRecord::Migration[6.1]
  def change
    create_table :whiskey_tags do |t|
      
      t.integer :tag_id, null: false
      t.integer :whiskey_id, null: false
      t.timestamps
    end
  end
end
