class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, default: ""
      t.string :sub_title, default: ""
      t.text :content, default: ""
      t.string :seo_description, default: ""

      t.timestamps
    end
  end
end
