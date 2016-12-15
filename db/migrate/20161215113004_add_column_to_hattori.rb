class AddColumnToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :r, :integer
  end
end
