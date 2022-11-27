class User < ApplicationRecord
  has_many :knowledges

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
