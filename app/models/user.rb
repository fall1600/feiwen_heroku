class User < ActiveRecord::Base
  
  #validates :password, length: {6..20}
  validates_presence_of :name, :email
  validates :email, uniqueness: true, on: :create
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  has_many :replies
  has_many :posts
  has_secure_password
  has_many :forum_userships
  has_many :forums, through: :forum_userships
end
