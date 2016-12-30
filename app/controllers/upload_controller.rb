class UploadController < ApplicationController
  include Color
  include NameThatColor
  
  def index
  end
  
  def get_color_info
    rgb = [params[:r].to_i, params[:g].to_i, params[:b].to_i]
    hsv = rgb2hsv(rgb)
    
    render json: {
      hex: rgb2hex(rgb),
      color_name: name_that_color(rgb),
      r: rgb[0],
      g: rgb[1],
      b: rgb[2],
      h: hsv[0],
      s: hsv[1],
      v: hsv[2],
      dark_level: dark_level(rgb)
    }, nothing: true
  end
  
  def get_similar_hattoris
    render nothing: true
  end
end