class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
    	t.belongs_to :user, index: true, foreign_key: true
    	t.string :url
    	t.string :title
    	t.text :content
    	t.string :image
      t.timestamps
    end
  end
end
