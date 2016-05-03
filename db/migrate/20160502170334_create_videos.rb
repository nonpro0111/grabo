class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :thumbnail
      t.string :original_site
      t.string :embed_code
      t.string :text
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
