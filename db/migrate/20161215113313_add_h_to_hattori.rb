class AddHToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :h, :integer
  end
end
