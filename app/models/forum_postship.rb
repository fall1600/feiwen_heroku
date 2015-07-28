class ForumPostship < ActiveRecord::Base
  belongs_to :post
  belongs_to :forum
end
