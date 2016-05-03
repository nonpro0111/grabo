class ChangeColumnToVideo < ActiveRecord::Migration
  def change
    remove_column :videos, :text, :string
  end
end
