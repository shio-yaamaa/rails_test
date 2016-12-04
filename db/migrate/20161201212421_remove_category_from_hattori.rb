class RemoveCategoryFromHattori < ActiveRecord::Migration
  def change
    remove_column :hattoris, :category, :integer
  end
end
