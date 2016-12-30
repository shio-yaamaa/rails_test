class ColorNamesController < ApplicationController
  include Color
  
  def get_color_names
    color_names = ColorName.all
    color_names = color_names.each.map do |color_name|
      rgb = hex2rgb(color_name.hex)
      {
        hex: color_name.hex,
        rgb: rgb,
        hsl: rgb2hsl(rgb),
        name: color_name.name,
        japanese: color_name.japanese
      }
    end
    render json: color_names
=begin
      ColorName.all.map do |color_name|
        rgb = hex2rgb(color_name.hex)
        return {
          hex: color_name.hex,
          rgb: rgb,
          hsl: rgb2hsl(rgb),
          name: color_name.name,
          japanese: color_name.japanese
        }
      end
=end
=begin
      ColorName.all.each do |color_name|
        rgb = hex2rgb(color_name.hex)
        {
          hex: color_name.hex,
          rgb: rgb,
          hsl: rgb2hsl(rgb),
          name: color_name.name,
          japanese: color_name.japanese
        }
      end
=end
  end
  
end
