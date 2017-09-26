class AddLabstarToHattoris < ActiveRecord::Migration
  def change
    add_column :hattoris, :l_star, :integer
    add_column :hattoris, :a_star, :integer
    add_column :hattoris, :b_star, :integer
  end
end
