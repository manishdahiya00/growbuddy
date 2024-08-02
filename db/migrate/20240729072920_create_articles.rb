class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :desc
      t.string :category
      t.string :image_url
      t.boolean :status, default: true
      t.boolean :highlighted, default: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
