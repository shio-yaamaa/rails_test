module HattorisHelper
  
  @@rgb_names = ['R', 'G', 'B']
  @@hsv_names = ['H', 'S', 'V']
  
  @@rgb_maxes = [255, 255, 255]
  @@hsv_maxes = [360, 100, 100]
  
  def rgb_for_graph(rgb)
    @@rgb_names.zip(rgb, @@rgb_maxes).map do |name, value, max|
      {name: name, value: value, percentage: value * 100 / max}
    end
  end
  
  def hsv_for_graph(hsv)
    @@hsv_names.zip(hsv, @@hsv_maxes).map do |name, value, max|
      {name: name, value: value, percentage: value * 100 / max}
    end
  end
  
end
