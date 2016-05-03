class AddChannelAndUrlToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :channel, :string
    add_column :videos, :url, :string, null: :false
  end
end
