# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :knowledges
  validates :category_name, presence: true, length: { maximum: 30 }, uniqueness: true
end
