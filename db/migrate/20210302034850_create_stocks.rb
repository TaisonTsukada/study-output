class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :user,index: true, null: false, foreign_key: true
      t.references :article, index: true, null: false, foreign_key: true

      t.timestamps

      t.index [:user_id, :article_id], unique: true
    end
  end
end
