class Hattori < ActiveRecord::Base
  belongs_to :category
  
  attr_accessor :color_name
  attr_accessor :similar_color_hattoris
  attr_accessor :similar_dark_level_hattoris
end
