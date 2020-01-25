class UploadController < ApplicationController
  require 'open-uri'
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
  
  def url2base64
    begin
      data = 'data:image/png;base64,' + Base64.strict_encode64(open(params[:url]).read)
    rescue
      data = nil
    end
    render json: {base64: data}, nothing: true
  end
  
end