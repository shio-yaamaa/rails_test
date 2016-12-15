class AddDarkLevelToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :dark_level, :float
  end
end
