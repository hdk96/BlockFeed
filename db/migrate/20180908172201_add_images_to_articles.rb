class AddImagesToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :images, :text
  end
end
