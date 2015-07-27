class User < ActiveRecord::Base
  #include Paperclip::Glue
  has_many :replies
  has_many :posts
  has_secure_password
  #validates :password, length: {6..20}
  validates_presence_of :name, :email
  validates :email, uniqueness: true, on: :create
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  has_attached_file :profile_picture, :styles => {:medium => "300*300>", :thumb => "100*100>"}, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :profile_picture, :less_than => 1.kilobytes

  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
