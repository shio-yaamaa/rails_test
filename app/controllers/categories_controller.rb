class CategoriesController < ApplicationController
  include OrderHattoris
  include SearchHattoris
  
  def show
    @categories = Category.all
    @active_category = Category.find(params[:id])
    
    @order = params[:order] == nil ? nil : params[:order].to_sym
    @order_options = @@order_info.map {|key, value| [value[:for_display], key.to_s]}

    @hattoris = search_hattoris(order_hattoris(@active_category.hattoris, @order), params[:search])
        .page(params[:page])
  end
  
end
