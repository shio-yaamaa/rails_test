class AddVToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :v, :integer
  end
end
