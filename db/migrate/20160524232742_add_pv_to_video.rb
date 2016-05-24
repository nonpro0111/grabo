class AddPvToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :pv, :integer, default: 0
  end
end
