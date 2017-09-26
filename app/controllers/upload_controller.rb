class UploadController < ApplicationController
  include Color
  include SimilarHattoris
  
  def index
  end
  
  # send all the Hattori data as JSON to compare their colors in coffee
  def get_hattoris
    data = []
    
    Category.find(2).hattoris.each do |hattori| # todo: 便宜上アニメだけだが、全てならHattori.all.each
      data << {
        id: hattori.id,
        hex: hattori.hex,
        dark_level: hattori.dark_level,
        l_star: hattori.l_star,
        a_star: hattori.a_star,
        b_star: hattori.b_star
      }
    end
    
    render json: data, nothing: true
  end
  
end