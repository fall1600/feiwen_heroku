class ForumUsership < ActiveRecord::Base
  validates :status, inclusion: {in: ["hosting", "joined", "pending", "bucketed", "left"]}
  belongs_to :forum
  belongs_to :user
end
