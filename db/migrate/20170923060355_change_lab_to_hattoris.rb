class ChangeLabToHattoris < ActiveRecord::Migration
  def change
    change_column :hattoris, :l_star, :float
    change_column :hattoris, :a_star, :float
    change_column :hattoris, :b_star, :float
  end
end
