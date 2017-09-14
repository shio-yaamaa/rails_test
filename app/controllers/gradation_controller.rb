class GradationController < ApplicationController
  include NameJapaneseColor
  
  def index
    #@hattoris = Hattori.order('dark_level')
    @hattoris = Category.find(2).hattoris.where.not(id: [24, 26, 31, 43]).order('dark_level')
    @hattoris.each do |hattori|
      hattori.japanese_color = name_japanese_color([hattori.r, hattori.g, hattori.b])
    end
  end
end