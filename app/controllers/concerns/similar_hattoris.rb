module SimilarHattoris
  extend ActiveSupport::Concern
  
  include ColorDifference

  def similar_color_hattoris(id, rgb)
    color_differences = [] # ascend {id: int, value: int}
    Hattori.all.each do |hattori|
      if hattori.id != id
        difference = color_difference([hattori.r, hattori.g, hattori.b], rgb)
        insert_pos = 0
        color_differences.each do |color_difference|
          if color_difference[:value] < difference
            insert_pos += 1
          else
            break
          end
        end
        color_differences.insert(insert_pos, {id: hattori.id, value: difference})
      end
    end
    return color_differences[0...5].map {|color_difference| Hattori.find(color_difference[:id])}
  end
  
  def similar_dark_level_hattoris(id, dark_level)
    dark_level_differences = [] # ascend {id: int, value: int}
    Hattori.all.each do |hattori|
      if hattori.id != id
        difference = (hattori.dark_level - dark_level).abs
        insert_pos = 0
        dark_level_differences.each do |dark_level_difference|
          if dark_level_difference[:value] < difference
            insert_pos += 1
          else
            break
          end
        end
        dark_level_differences.insert(insert_pos, {id: hattori.id, value: difference})
      end
    end
    return dark_level_differences[0...5].map {|dark_level_difference| Hattori.find(dark_level_difference[:id])}
  end

end