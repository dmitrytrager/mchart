class CreateCommentsForCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false
      t.references :chart, null: false, index: true
      t.string :text, null: false

      t.timestamps
    end
  end
end
