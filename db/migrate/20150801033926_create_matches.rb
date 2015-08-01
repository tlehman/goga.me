class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :black_user_id
      t.integer :white_user_id
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
