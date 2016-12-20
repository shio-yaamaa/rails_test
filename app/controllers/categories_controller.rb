class CategoriesController < ApplicationController
  include OrderHattoris
  include SearchHattoris
  
  def show
    @categories = Category.all
    @active_category = Category.find(params[:id])
    
    @order = params[:order] == nil ? nil : params[:order].to_sym
    @order_options = @@order_info.map {|key, value| [value[:for_display], key.to_s]}
    
    search_param = params[:list_control] ? params[:list_control][:search] : nil

    @hattoris = search_hattoris(order_hattoris(@active_category.hattoris, @order), search_param)
        .page(params[:page])
  end
  
end
