colorNames = if colorNames? then colorNames else undefined
inAjax = if inAjax? then inAjax else false

getColorNames = (func) ->
  if colorNames
    return if func != null then func() else null
  inAjax = true
  $.getJSON('japanese_colors/get_japanese_colors') #('color_names/get_color_names')
    .done (data) ->
      inAjax = false
      func() if func != null
      colorNames = data

@nameThatColor = (rgb) ->
  getColorNames ->
    hsl = rgb2hsl rgb
    
    difference = 0

    candidate = null
    candidateDifference = -1
    
    for colorName in colorNames
      if rgb[0] == colorName.rgb[0] && rgb[1] == colorName.rgb[1] && rgb[2] == colorName.rgb[2]
        return colorName
      rgbDifference = 0
      rgb.forEach (element, index) ->
        rgbDifference += Math.pow element - colorName.rgb[index], 2
      hslDifference = 0
      hsl.forEach (element, index) ->
        hslDifference += Math.pow element - colorName.hsl[index], 2
      difference = rgbDifference + hslDifference * 2
      
      if candidate == null || difference < candidateDifference
        candidate = colorName
        candidateDifference = difference
    
    return candidate
    # 日本語訳つけるなら一致したときとRubyの方もね

getColorNames(null)