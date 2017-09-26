class RemoveDarkLevelToHattoris < ActiveRecord::Migration
  def change
    remove_column :hattoris, :dark_level, :float
  end
end
