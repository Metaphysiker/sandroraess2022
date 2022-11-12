class AddModifiedContentToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :modified_content, :text, default: ""
  end
end
