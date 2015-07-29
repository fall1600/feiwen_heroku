class AddStatusToForum < ActiveRecord::Migration
  def change
    add_column :forums, :status, :string
  end
end
