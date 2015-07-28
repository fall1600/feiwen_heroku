class Tag < ActiveRecord::Base
  has_many :post_tagships
  has_many :posts, :through => :post_tagships

  validates :name, presence: true
  #has_and_belongs_to_many :posts

  #@posts = @tag.posts.where(status: 'public').order("updated_at DESC")
end
