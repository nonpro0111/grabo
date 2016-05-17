class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
