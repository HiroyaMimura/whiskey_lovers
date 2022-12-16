class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.references :whiskey_id, null: false, foreign_key: true
      t.references :user_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
