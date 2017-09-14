class UploadController < ApplicationController
  include Color
  include SimilarHattoris
  
  def index
  end
  
=begin
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
=end
  
  def show_similar_hattoris
    rgb = params[:rgb].map {|element| element.to_i}
    
    # the return value contains both hattori object and the similarity
    @similar_color_hattoris = similar_color_hattoris(nil, rgb)
    @similar_dark_level_hattoris = similar_dark_level_hattoris(nil, dark_level(rgb))
  end
  
end