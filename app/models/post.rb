class Post < ActiveRecord::Base

  validates :title, :content, :status, presence: true
  validates :status, inclusion: {in: ['public', 'private', 'deleted']}

  before_validation :set_content_from_title
  
  has_many :post_tagships
  has_many :tags, :through => :post_tagships
  has_many :replies
  
  belongs_to :forum
  belongs_to :user

  after_initialize :init

  def init
    self.user_id = 1 unless user_id
    self.status = "public"
  end

  def title_must_start_with_x
    unless title.to_s.start_with? 'X'
      errors.add(:title, 'must start with "X"')
    end
  end

  def set_content_from_title
    self.content = title if content.blank?
  end

  #scope :own_posts, -> (user) { where("user_id = ? AND status != ?", user.id, "deleted").order("updated_at DESC") }
  #scope :others_posts, -> (user) { where("user_id = ? AND status = ?", user.id, "public").order("updated_at DESC") }

end
