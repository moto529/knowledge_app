class AddColumnToKnowledges < ActiveRecord::Migration[7.0]
  def change
    add_column :knowledges, :user_uid, :string
  end
end
