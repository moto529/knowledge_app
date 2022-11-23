class User < ApplicationRecord
  has_many :knowledgess

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
