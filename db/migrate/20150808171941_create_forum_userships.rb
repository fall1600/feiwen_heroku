class CreateForumUserships < ActiveRecord::Migration
  def change
    create_table :forum_userships do |t|

      t.timestamps null: false
    end
  end
end
