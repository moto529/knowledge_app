class AddUserIdToKnowledges < ActiveRecord::Migration[7.0]
  def change
    add_reference :knowledges, :user, foreign_key: true, after: :category_id
  end
end
