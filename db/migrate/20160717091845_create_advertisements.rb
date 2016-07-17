class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :title
      t.text   :image
      t.string :url
      t.integer :position
      t.integer :order_no

      t.timestamps null: false
    end
  end
end
