module UploadHelper
  def create_empty_similar_hattoris
    empty_hattori = Hattori.new
    empty_hattori.id = nil
    empty_hattori.hex = '000000'
    empty_hattori.dark_level = 0
    Array.new(5, {hattori: empty_hattori, similarity: 0})
  end
end