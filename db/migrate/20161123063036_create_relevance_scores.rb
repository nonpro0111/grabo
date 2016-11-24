class CreateRelevanceScores < ActiveRecord::Migration
  def change
    create_table :relevance_scores do |t|
      t.integer :referer_idol_id, null: false
      t.integer :request_idol_id, null: false 
      t.integer :appearance_count, default: 0
      t.integer :click_count, default: 0

      t.timestamps null: false
    end

    add_index :relevance_scores, [:referer_idol_id, :request_idol_id], unique: true
  end
end
