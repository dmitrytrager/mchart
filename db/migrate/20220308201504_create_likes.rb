class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :voter_id, null: false, index: true
      t.integer :voteable_id, null: false
      t.string :voteable_type, null: false

      t.timestamps
    end
  end
end
