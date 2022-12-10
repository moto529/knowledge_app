class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :knowledge
  
  validates_uniqueness_of :knowledge_id, scope: :user_id
end
