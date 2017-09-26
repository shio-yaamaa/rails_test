module ColorHelper
  
  def color_distinct_from_background(background_dark_level)
    background_dark_level > 0.5 ? 'white' : 'black'
  end
  
end