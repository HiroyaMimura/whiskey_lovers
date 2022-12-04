class CreateWhiskeys < ActiveRecord::Migration[6.1]
  def change
    create_table :whiskeys do |t|

      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :impression, null: false
      t.float :taste, null: false
      t.float :scent, null: false
      t.string :price_range, null: false
      t.float :performance, null: false
      t.timestamps
    end
  end
end
