module Color
  extend ActiveSupport::Concern
  
  include ColorDifference
  
  def hex2rgb(hex, is_hash = false)
    names = ['R', 'G', 'B']
    rgb = []
    3.times do |i|
      value = hex[i * 2, 2].to_i(16)
      if is_hash
        rgb.push({
          name: names[i],
          value: value,
          percentage: value * 100 / 255
        })
      else
        rgb.push(value)
      end
    end
    return rgb
  end
  
  def rgb2hsv(rgb, is_hash = false)
    names = ['H', 'S', 'V']
    
    rgb = rgb.map { |element| element.to_f / 255 }
    min = rgb.min
    max = rgb.max
    
    # hue
    h = max - min
    unless h == 0
      case max
      when rgb[0]
        h = (rgb[1] - rgb[2]) / h
        h + 6 if h < 0
      when rgb[1]
        h = 2 + (rgb[2] - rgb[0]) / h
      when rgb[2]
        h = 4 + (rgb[0] - rgb[1]) / h
      end
    end
    h = (h * 60).round
    
    # saturation
    s = max - min
    s = s * 100 / max if max != 0
    s = s.round
    
    # value
    v = (max * 100).round
    
    if is_hash
      return [h, s, v].map.with_index { |element, index| {
        name: names[index],
        value: element,
        percentage: element * 100 / (index == 0 ? 360 : 100)
      } }
    else
      return [h, s, v]
    end
  end
  
  # use only by name_that_color!
  def rgb2hsl(rgb)
    rgb = rgb.map { |element| element.to_f / 255 }
    min = rgb.min
    max = rgb.max
    delta = max - min
  
    l = (min + max) / 2
  
    s = 0
    if l > 0 && l < 1
      s = delta / (l < 0.5 ? 2 * l : 2 - 2 * l)
    end
  
    h = 0
    if delta > 0
      h += (rgb[1] - rgb[2]) / delta if max == rgb[0] && max != rgb[1]
      h += 2 + (rgb[2] - rgb[0]) / delta
      h += 4 + (rgb[0] - rgb[1]) / delta
      h /= 6
    end
  
    return [(h * 255).to_i, (s * 255).to_i, (l * 255).to_i]
  end
  
  def dark_level(rgb)
    100 - 100 * rgb.zip([0.299, 0.587, 0.114]).inject(0) { |sum, element|
      sum + element.inject(:*)
    } / 255
  end
  # (100 - 100 * (0.299 * R + 0.587 * G + 0.114 * B) / 255)
  
  def similar_color_hattoris(id, rgb)
    color_differences = [] # ascend {id: int, value: int}
    Hattori.all.each do |hattori|
      if hattori.id != id
        difference = color_difference(hex2rgb(hattori.color), rgb)
        insert_pos = 0
        color_differences.each do |color_difference|
          if color_difference[:value] < difference
            insert_pos += 1
          else
            break
          end
        end
        color_differences.insert(insert_pos, {id: hattori.id, value: difference})
      end
    end
    return color_differences[0...5].map {|color_difference| Hattori.find(color_difference[:id])}
  end
  
  def similar_dark_level_hattoris(id, dark_level)
    dark_level_differences = [] # ascend {id: int, value: int}
    Hattori.all.each do |hattori|
      if hattori.id != id
        difference = (dark_level(hex2rgb(hattori.color)) - dark_level).abs
        insert_pos = 0
        dark_level_differences.each do |dark_level_difference|
          if dark_level_difference[:value] < difference
            insert_pos += 1
          else
            break
          end
        end
        dark_level_differences.insert(insert_pos, {id: hattori.id, value: difference})
      end
    end
    return dark_level_differences[0...5].map {|dark_level_difference| Hattori.find(dark_level_difference[:id])}
  end

end