class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :size
      t.text :content

      t.timestamps
    end
  end
end
