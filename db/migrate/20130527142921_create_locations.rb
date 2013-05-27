class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :board_id
      t.integer :row
      t.integer :slot
      t.string :letter


      t.timestamps
    end
  end
end
