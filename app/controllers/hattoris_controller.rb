class HattorisController < ApplicationController
  #include Color
  include NameThatColor
  include SimilarHattoris
  
  def index
    #logger.debug("hattori controller の index")
    
    @categories = Category.all
    @hattoris = Hattori.page(params[:page]).includes(:category)
    
    #for hattori in @hattoris
    #  hattori.rgb = hex2rgb(hattori.color)
    #  hattori.dark_level = dark_level(hattori.rgb)
    #end
  end
  
  def show
    #logger.debug("hattori controller の show")
    
    @hattori = Hattori.find(params[:id])
    
    #logger.debug("保持されていたrgb↓")
    #logger.debug(@hattori.rgb)
    #@hattori.rgb_with_name = [
    #  {name: "R", value: @hattori.r},
    #  {name: "G", value: @hattori.g},
    #  {name: "B", value: @hattori.b}
    #]
    #logger.debug(@hattori.rgb)
    #rgb = hex2rgb(@hattori.color)
    #@hattori.hsv_with_name = [
    #  {name: "H", value: @hattori.r},
    #  {name: "S", value: @hattori.g},
    #  {name: "V", value: @hattori.b}
    #]
    #@hattori.dark_level = dark_level(rgb)
    
    rgb = [@hattori.r, @hattori.g, @hattori.b]
    
    @hattori.color_name = name_that_color(rgb)
    @hattori.similar_color_hattoris = similar_color_hattoris(@hattori.id, rgb)
    @hattori.similar_dark_level_hattoris = similar_dark_level_hattoris(@hattori.id, @hattori.dark_level)
  end
  
end
