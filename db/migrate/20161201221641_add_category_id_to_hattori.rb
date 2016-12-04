class AddCategoryIdToHattori < ActiveRecord::Migration
  def change
    add_column :hattoris, :category_id, :integer
  end
end
