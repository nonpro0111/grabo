class CreateIdolsVideos < ActiveRecord::Migration
  def change
    create_table :idols_videos do |t|
      t.references :idol, index: true, foreign_key: true
      t.references :video, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
