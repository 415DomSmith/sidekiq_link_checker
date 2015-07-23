class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text :address
      t.integer :link_id

      t.timestamps null: false
    end
  end
end
