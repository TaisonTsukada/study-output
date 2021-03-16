class CreateReads < ActiveRecord::Migration[6.0]
  def change
    create_table :reads do |t|
      t.references :user, foreign_key: true
      t.references :message, foreign_key: true
      t.boolean :complete, default: false, null: false
      t.timestamps
    end
  end
end
