class Category < ApplicationRecord
  belongs_to :user
  has_many :knowledges
  validates :category_name, presence: true, length: { maximum: 30 }
end
