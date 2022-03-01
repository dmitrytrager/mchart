class AddLikesAndRatingsForCharts < ActiveRecord::Migration[7.0]
  def change
    add_column :charts, :likes, :integer, null: false, default: 0
    add_column :charts, :rating, :integer, null: false, default: 0
  end
end
