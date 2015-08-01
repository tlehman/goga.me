class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.column :match_id, :integer
      t.column :user_id, :integer
      t.column :color, :integer, default: 0

      t.timestamps null: false
    end
  end
end
