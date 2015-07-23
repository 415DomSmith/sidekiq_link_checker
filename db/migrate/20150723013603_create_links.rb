class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.boolean :working
      t.integer :site_id
      t.text :address

      t.timestamps null: false
    end
  end
end
