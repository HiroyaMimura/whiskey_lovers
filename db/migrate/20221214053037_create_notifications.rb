class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :visitor, null: false, foreign_key: { to_table: :users}
      t.references :visited, null: false, foreign_key: { to_table: :users}
      t.references :whiskey, foreign_key: true
      t.references :whiskey_comment, foreign_key: true
      t.string :action, null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
