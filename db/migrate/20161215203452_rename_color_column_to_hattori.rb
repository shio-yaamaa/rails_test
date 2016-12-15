class RenameColorColumnToHattori < ActiveRecord::Migration
  def change
    rename_column :hattoris, :color, :hex
  end
end
