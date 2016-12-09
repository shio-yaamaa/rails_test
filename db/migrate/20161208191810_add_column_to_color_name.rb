class AddColumnToColorName < ActiveRecord::Migration
  def change
    add_column :color_names, :japanese, :string
  end
end
