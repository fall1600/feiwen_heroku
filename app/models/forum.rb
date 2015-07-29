class Forum < ActiveRecord::Base
  validates :name, 
    :presence => {:message => "不能空白"},
    :length => {minimum: 2, maximum: 20, :message => "長度不正確"},
    :uniqueness => true
  has_many :posts
end
