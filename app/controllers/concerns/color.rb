module Color
  extend ActiveSupport::Concern
  
  @@MATRIX_FOR_XYZ = [
    [0.4124, 0.3576, 0.1805],
    [0.2126, 0.7152, 0.0722],
    [0.0193, 0.1192, 0.9505]
  ]
  
  def hex2rgb(hex)
    rgb = []
    3.times do |i|
      rgb.push(hex[i * 2, 2].to_i(16))
    end
    return rgb
  end
  
  def rgb2hex(rgb)
    rgb.reduce('') {|sum, element| sum + "%02x" % element}
  end
  
  def rgb2hsv(rgb)
    rgb = rgb.map {|element| element.to_f / 255}
    min = rgb.min
    max = rgb.max
    
    # hue
    h = max - min
    unless h == 0
      case max
      when rgb[0]
        h = (rgb[1] - rgb[2]) / h
        h += 6 if h < 0
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
    
    [h, s, v]
  end
  
  # used only by name_that_color and japanese_color!
  def rgb2hsl(rgb)
    rgb = rgb.map {|element| element.to_f / 255}
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
      if max == rgb[0] && max != rgb[1] then h +=     (rgb[1] - rgb[2]) / delta end
      if max == rgb[1] && max != rgb[2] then h += 2 + (rgb[2] - rgb[0]) / delta end
      if max == rgb[2] && max != rgb[0] then h += 4 + (rgb[0] - rgb[1]) / delta end
      h /= 6
    end
    
    h += 1 if h < 0 # not confident
  
    return [(h * 255).to_i, (s * 255).to_i, (l * 255).to_i]
  end
  
  def rgb2lab(rgb)
    rgb = rgb.map {|element| element / 255.0}
    linear_rgb = rgb.map do |element|
      if element <= 0.04045
        element / 12.92
      else
        ((element + 0.055) / 1.055) ** 2.4
      end
    end
    xyz = @@MATRIX_FOR_XYZ.map do |m_row|
      m_row.zip(linear_rgb).inject(0) {|sum, (m_element, rgb_element)| sum + m_element * rgb_element * 100}
    end
    xyz = xyz.zip([95.047, 100.000, 108.883]).map {|xyz_element, n| xyz_element / n}
    def f(t)
      if t > 0.0089
        t ** (1.0 / 3)
      else
        ((29.0 / 3) ** 3 * t + 16) / 116
      end
    end
    [116 * f(xyz[1]) - 16, 500 * (f(xyz[0]) - f(xyz[1])), 200 * (f(xyz[1]) - f(xyz[2]))]
  end
  
  def lab_distance(lab1, lab2)
    lab1.zip(lab2).inject(0) do |sum, (lab1_element, lab2_element)|
      sum + (lab1_element - lab2_element) ** 2
    end ** (1/2.0)
  end
  
  def dark_level(rgb)
    1 - rgb.zip([0.299, 0.587, 0.114]).inject(0) {|sum, element|
      sum + element.inject(:*)
    } / 255
  end
  # 1 - (0.299 * R + 0.587 * G + 0.114 * B) / 255

end