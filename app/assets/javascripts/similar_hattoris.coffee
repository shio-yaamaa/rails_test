MAX_COLOR_DISTANCE = 258.69303202784573
MAX_DARK_LEVEL_DIFFERENCE = 1

hattoris = null
$.getJSON('upload/get_hattoris', (data) -> hattoris = data)

# ループを1度で済ませるため統一。戻り値の使い方に注意。あまりにも速くなるなら分けてもいいかも。
# {
#   similarColorHattoris: [{id: 0, hex: '000000', dark_level: 0, l_star: 0, a_star: 0, b_star: 0}, ...],
#   similarDarkLevelHattoris: [同上]
# }
@getSimilarHattoris = (rgb) ->
  if not hattoris?
    console.log("Ajax hasn't completed yet!")
    return {similarColorHattoris: [], similarDarkLevelHattoris: []}
  
  lab = rgb2lab rgb
  darkLevel = rgb2darkLevel rgb
  
  for hattori in hattoris
    hattori.color_similarity = 1 - colorDistance(lab, [hattori.l_star, hattori.a_star, hattori.b_star]) / MAX_COLOR_DISTANCE
    hattori.dark_level_similarity = 1 - (Math.abs(darkLevel - hattori.dark_level)) / MAX_DARK_LEVEL_DIFFERENCE
  
  sortedHattorisByColor = hattoris.slice().sort((a, b) ->
    b.color_similarity - a.color_similarity
  )
  sortedHattorisByDarkLevel = hattoris.slice().sort((a, b) ->
    b.dark_level_similarity - a.dark_level_similarity
  )
  
  {
    similarColorHattoris: sortedHattorisByColor.slice(0, 5),
    similarDarkLevelHattoris: sortedHattorisByDarkLevel.slice(0, 5)
  }