class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :match_id
      t.integer :width
    end
  end
end
