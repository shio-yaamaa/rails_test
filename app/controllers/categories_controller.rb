class CategoriesController < ApplicationController
  include Color
  
  def show
    @categories = Category.all
    @active_category = Category.find(params[:id])
    @hattoris = @active_category.hattoris.page(params[:page])
    for hattori in @hattoris
      hattori.rgb = hex2rgb(hattori.color)
      hattori.dark_level = dark_level(hattori.rgb)
    end
  end
end
