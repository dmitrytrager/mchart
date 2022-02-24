class CreateCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :charts do |t|
      t.references :user, null: false, index: true

      t.string :title
      t.text :description
      t.jsonb :items, default: [], null: false

      t.timestamps
    end

    add_index :charts, :items, using: :gin
  end
end
