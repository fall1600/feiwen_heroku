class CreateForumPostships < ActiveRecord::Migration
  def change
    create_table :forum_postships do |t|
      t.integer :forum_id
      t.integer :post_id

      t.timestamps null: false
    end
  end
end
