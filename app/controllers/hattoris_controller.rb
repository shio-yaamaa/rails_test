class HattorisController < ApplicationController
  include NameThatColor
  include SimilarHattoris
  include OrderHattoris
  include SearchHattoris
  
  def index
    @categories = Category.all
    
    @order = params[:order] == nil ? nil : params[:order].to_sym
    @order_options = @@order_info.map {|key, value| [value[:for_display], key.to_s]}
    
    search_param = params[:list_control] ? params[:list_control][:search] : nil
    
    @hattoris = search_hattoris(order_hattoris(Hattori, @order), search_param)
        .page(params[:page]).includes(:category)
  end
  
  def show
    @hattori = Hattori.find(params[:id])
    
    rgb = [@hattori.r, @hattori.g, @hattori.b]
    
    @hattori.color_name = name_that_color(rgb)
    @hattori.similar_color_hattoris = similar_color_hattoris(@hattori.id, rgb)
    @hattori.similar_dark_level_hattoris = similar_dark_level_hattoris(@hattori.id, @hattori.dark_level)
  end
  
end
