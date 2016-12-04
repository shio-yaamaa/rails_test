class CreateHattoris < ActiveRecord::Migration
  def change
    create_table :hattoris do |t|
      t.integer :category
      t.string :title
      t.string :description
      t.date :date
      t.string :color

      t.timestamps null: false
    end
  end
end
