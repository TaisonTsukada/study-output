class CreateDmnotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :dmnotifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :message_id
      t.integer :room_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end

    add_index :dmnotifications, :visitor_id
    add_index :dmnotifications, :visited_id
    add_index :dmnotifications, :message_id
    add_index :dmnotifications, :room_id
  end
end
