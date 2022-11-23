class CreateKnowledges < ActiveRecord::Migration[7.0]
  def change
    create_table :knowledges do |t|
      t.string :title
      t.text :body
      t.text :url
      t.string :knowledge_image
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
