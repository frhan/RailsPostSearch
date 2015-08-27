class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :desc
      t.decimal :price
      t.string :image

      t.timestamps null: false
    end
  end
end
