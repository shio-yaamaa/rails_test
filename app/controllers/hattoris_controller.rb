class HattorisController < ApplicationController
  include Color
  include NameThatColor
  
  def index
    @hattoris = Hattori.page(params[:page])
    for hattori in @hattoris
      hattori.rgb = hex_to_rgb(hattori.color)
      hattori.dark_level = dark_level(hattori.rgb)
    end
  end
  
  def show
    @hattori = Hattori.find(params[:id])
    @hattori.rgb = hex_to_rgb(@hattori.color, true)
    logger.debug(@hattori.rgb)
    rgb = hex_to_rgb(@hattori.color)
    @hattori.hsv = rgb_to_hsv(rgb, true)
    @hattori.dark_level = dark_level(rgb)
    @hattori.color_name = name_that_color(rgb)
    
    @hattori.similar_color_hattoris = similar_color_hattoris(@hattori.id, rgb)
    @hattori.similar_dark_level_hattoris = similar_dark_level_hattoris(@hattori.id, @hattori.dark_level)
  end
  
end
