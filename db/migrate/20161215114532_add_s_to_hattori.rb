class AddSToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :s, :integer
  end
end
