class CreateUserMatches < ActiveRecord::Migration
  def change
    create_table :user_matches do |t|
      t.integer :user_id
      t.integer :match_id

      t.timestamps null: false
    end
  end
end
