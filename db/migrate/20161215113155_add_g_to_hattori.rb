class AddGToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :g, :integer
  end
end
