class CreateColorNames < ActiveRecord::Migration
  def change
    create_table :color_names do |t|
      t.string :hex
      t.string :name

      t.timestamps null: false
    end
  end
end
