class Knowledge < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  validates :title, presence: true, length: { maximum: 30 }, uniqueness: { scope: [:category_id, :user_id] }
  validates :body, presence: true
  # validates :url, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :category_id, presence: true
end
