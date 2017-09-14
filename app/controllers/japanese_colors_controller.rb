class JapaneseColorsController < ApplicationController
  include Color
  
  def get_japanese_colors
    color_names = JapaneseColor.all
    color_names = color_names.each.map do |color_name|
      rgb = hex2rgb(color_name.hex)
      {
        hex: color_name.hex,
        rgb: rgb,
        hsl: rgb2hsl(rgb),
        name: color_name.name
      }
    end
    render json: color_names
  end
end
