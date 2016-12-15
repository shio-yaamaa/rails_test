class AddBToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :b, :integer
  end
end
