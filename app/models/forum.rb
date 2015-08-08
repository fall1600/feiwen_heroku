class Forum < ActiveRecord::Base
  
  validates :name, 
    :presence => {:message => "不能空白"},
    :length => {minimum: 2, maximum: 20, :message => "長度不正確"},
    :uniqueness => true

  # public for everyone, private for people in forum, deleted for been fake_deleted
  validates :status, inclusion: {in: ['public', 'private', 'deleted']}

  has_many :posts
  has_many :forum_userships
  has_many :users, :through => :forum_userships
end
