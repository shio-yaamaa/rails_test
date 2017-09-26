module SimilarHattoris
  extend ActiveSupport::Concern
  
  include ColorDifference
  
  MAX_COLOR_DISTANCE = 258.69303202784573
  MAX_DARK_LEVEL_DIFFERENCE = 1
  
  def color_similarity(distance)
    1 - (distance / MAX_COLOR_DISTANCE)
  end
  
  def dark_level_similarity(difference)
    1 - (difference / MAX_DARK_LEVEL_DIFFERENCE)
  end

  # returns [[hattori: Hattori Object, similarity: int], ...]
  def similar_color_hattoris(id, lab)
    color_differences = [] # ascend {id: int, value: int}
    Category.find(2).hattoris.each do |hattori| # todo: 便宜上アニメだけだが、全てならHattori.all.each
      if hattori.id != id
        difference = lab_distance(lab, [hattori.l_star, hattori.a_star, hattori.b_star])
        # Todo: maybe just recording all and sorting is enough. check it after adding all the data
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
    return color_differences[0...5].map { |color_difference|
      {
        hattori: Hattori.find(color_difference[:id]),
        similarity: color_similarity(color_difference[:value])
      }
    }
  end
  
  # returns [[hattori: Hattori Object, similarity: int], ...]
  def similar_dark_level_hattoris(id, dark_level)
    dark_level_differences = [] # ascend {id: int, value: int}
    Category.find(2).hattoris.each do |hattori| # todo: 便宜上アニメだけ
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
    return dark_level_differences[0...5].map { |dark_level_difference|
      {
        hattori: Hattori.find(dark_level_difference[:id]),
        similarity: dark_level_similarity(dark_level_difference[:value])
      }
    }
  end

end