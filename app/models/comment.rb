class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :knowledge
  
  validates :comment, presence: true, length: { maximum: 150 }
end
