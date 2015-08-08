class AddCreaterIdToForum < ActiveRecord::Migration
  def change
    add_column :forums, :creater_id, :integer, null: false, default: 1
  end
end
