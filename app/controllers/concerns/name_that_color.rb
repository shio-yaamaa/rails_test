module NameThatColor
  extend ActiveSupport::Concern
  
  @@color_names = []
  
  def init()
    for color in ColorName.all
      rgb = hex_to_rgb(color.hex)
      @@color_names.push({
        name: color.name,
        rgb: rgb,
        hsl: rgb_to_hsl(rgb)
      })
    end
  end
  
  def name_that_color(rgb)
    if @@color_names.size == 0
      init()
    end
  
    hsl = rgb_to_hsl(rgb)
  
    diff = 0
    rgb_diff = 0
    hsl_diff = 0
  
    candidate = nil
    candidate_diff = -1
  
    @@color_names.each do |color_name|
      if rgb == color_name[:rgb]
        return color_name[:name]
      end
  
      rgb_diff = rgb.zip(color_name[:rgb]).inject(0) do |sum, element|
        sum + (element[0] - element[1]) ** 2
      end
      hsl_diff = hsl.zip(color_name[:hsl]).inject(0) do |sum, element|
        sum + (element[0] - element[1]) ** 2
      end
      diff = rgb_diff + hsl_diff * 2
  
      if candidate == nil || diff < candidate_diff
        candidate = color_name
        candidate_diff = diff
      end
    end
  
    return candidate[:name]
  end
end