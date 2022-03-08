class CreateKarmaVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :karma_votes do |t|
      t.integer :voter_id, null: false, index: true
      t.integer :votee_id, null: false, index: true
      t.integer :vote, null: false, default: 1

      t.timestamps
    end
  end
end
