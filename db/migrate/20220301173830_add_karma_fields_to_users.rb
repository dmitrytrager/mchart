class AddKarmaFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :karma, :integer, null: false, default: 0
    add_column :users, :karma_points, :integer, null: false, default: 0
    add_column :users, :karma_reset_at, :datetime
  end
end
