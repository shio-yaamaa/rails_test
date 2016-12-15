class HattorisController < ApplicationController
  include Color
  include NameThatColor
  
  def index
    logger.debug("hattori controller の index")
    @categories = Category.all
    @hattoris = HattoriObject.get_all_hattoris()#.page(params[:page]) #.includes(:category)
    #for hattori in @hattoris
    #  hattori.rgb = hex2rgb(hattori.color)
    #  hattori.dark_level = dark_level(hattori.rgb)
    #end
  end
  
  def show
    logger.debug("hattori controller の show")
    @hattori = Hattori.find(params[:id])
    logger.debug("保持されていたrgb↓")
    logger.debug(@hattori.rgb)
    @hattori.rgb = hex2rgb(@hattori.color, true)
    logger.debug(@hattori.rgb)
    rgb = hex2rgb(@hattori.color)
    @hattori.hsv = rgb2hsv(rgb, true)
    @hattori.dark_level = dark_level(rgb)
    @hattori.color_name = name_that_color(rgb)
    
    @hattori.similar_color_hattoris = similar_color_hattoris(@hattori.id, rgb)
    @hattori.similar_dark_level_hattoris = similar_dark_level_hattoris(@hattori.id, @hattori.dark_level)
  end
  
end
