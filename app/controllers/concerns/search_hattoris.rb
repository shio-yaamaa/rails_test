module SearchHattoris
  extend ActiveSupport::Concern
  
  # hattori: Hattoriオブジェクト, search_param: params[:list_control][:search]
  def search_hattoris(hattori, search_param)
    if search_param
      search_param.split(/\+|\p{blank}/).each do |search_word|
        hattori = hattori.where("title like ? or description like ?", "%#{search_word}%", "%#{search_word}%")
      end
    end
    return hattori
  end

end