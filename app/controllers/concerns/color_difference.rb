module ColorDifference
  extend ActiveSupport::Concern
  
  def color_difference(rgb1, rgb2)
    lab_distance(rgb2lab(rgb1), rgb2lab(rgb2))
  end
  
  def rgb2lab(rgb)
    xyz2lab(scale_xyz(rgb2xyz(to_linear(scale_rgb(rgb)))))
  end
  
  def scale_rgb(rgb)
    rgb.map {|element| element / 255.0}
  end
  
  def to_linear(rgb)
    rgb.map do |element|
      if element <= 0.04045
        element / 12.92
      else
        ((element + 0.055) / 1.055) ** 2.4
      end
    end
  end
  
  def rgb2xyz(rgb)
    m = [
      [0.4124, 0.3576, 0.1805],
      [0.2126, 0.7152, 0.0722],
      [0.0193, 0.1192, 0.9505]
    ]
    
    m.map do |m_row|
      m_row.zip(rgb).inject(0) {|sum, (m_element, rgb_element)| sum + m_element * rgb_element * 100}
    end
  end
  
  def scale_xyz(xyz)
    xyz.zip([95.047, 100.000, 108.883]).map {|xyz_element, n| xyz_element / n}
  end
  
  def xyz2lab(xyz)
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
end