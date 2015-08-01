class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.integer :total_score

      t.timestamps null: false
    end
  end
end
