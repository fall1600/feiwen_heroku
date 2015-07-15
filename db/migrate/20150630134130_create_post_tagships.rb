class CreatePostTagships < ActiveRecord::Migration
  def change
    create_table :post_tagships do |t|
      t.integer :post_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
