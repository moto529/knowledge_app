# frozen_string_literal: true

class AddProfileImageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :profile_image, :string
  end
end
