class AddStatusToForumUserShip < ActiveRecord::Migration
  def change
    add_column :forum_userships, :status, :string, :null => false, :default => "pending"
  end
end
