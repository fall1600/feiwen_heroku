class AddForumIdAndUserIdToItsShip < ActiveRecord::Migration
  def change
    add_column :forum_userships, :forum_id, :integer
    add_column :forum_userships, :user_id, :integer
  end
end
