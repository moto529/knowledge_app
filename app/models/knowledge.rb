# frozen_string_literal: true

class Knowledge < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }, uniqueness: { scope: %i[category_id user_id] }
  validates :body, presence: true
  # validates :url, format: /\A#{URI::regexp(%w(http https))}\z/

  belongs_to :category
  belongs_to :user
  has_many :favorites, dependent: :destroy
end
