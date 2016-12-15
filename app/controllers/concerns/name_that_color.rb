module NameThatColor
  extend ActiveSupport::Concern
  
  @@color_names = []
  
  def init()
    for color in ColorName.all
      rgb = hex2rgb(color.hex)
      @@color_names.push({
        name: color.name,
        rgb: rgb,
        hsl: rgb2hsl(rgb)
      })
    end
  end
  
  def name_that_color(rgb)
    if @@color_names.size == 0
      init()
    end
  
    hsl = rgb2hsl(rgb)
  
    difference = 0
    rgb_difference = 0
    hsl_difference = 0
  
    candidate = nil
    candidate_difference = -1
  
    @@color_names.each do |color_name|
      if rgb == color_name[:rgb]
        return color_name[:name]
      end
  
      rgb_difference = rgb.zip(color_name[:rgb]).inject(0) do |sum, (rgb1, rgb2)|
        sum + (rgb1 - rgb2) ** 2
      end
      hsl_difference = hsl.zip(color_name[:hsl]).inject(0) do |sum, (hsl1, hsl2)|
        sum + (hsl1 - hsl2) ** 2
      end
      difference = rgb_difference + hsl_difference * 2
  
      if candidate == nil || difference < candidate_difference
        candidate = color_name
        candidate_difference = difference
      end
    end
  
    return candidate[:name]
  end
end