class CreateJapaneseColors < ActiveRecord::Migration
  def change
    create_table :japanese_colors do |t|
      t.string :hex
      t.string :name

      t.timestamps null: false
    end
  end
end
