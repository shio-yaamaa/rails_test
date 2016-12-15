class CategoriesController < ApplicationController
  
  def show
    @categories = Category.all
    @active_category = Category.find(params[:id])
    @hattoris = @active_category.hattoris.page(params[:page])
  end
  
end
