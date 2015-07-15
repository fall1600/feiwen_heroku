class AddTimestampToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :created_at, :datetime
    add_column :posts, :updated_at, :datetime
    # 手動增加此欄位, rails 也會自動放時戳
  end
end
