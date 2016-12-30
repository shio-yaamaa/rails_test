@hex2rgb = (hex) ->
  rgb = []
  for i in [0...3]
    rgb.push parseInt(hex[i*2...i*2+2], 16)
  return rgb

@rgb2hex = (rgb) ->
  rgb.reduce (
    (sum, element) ->
      sum + if element < 16 then "0#{element.toString(16)}" else element.toString(16)),
    ''

@rgb2hsv = (rgb) ->
  rgb = rgb.map (element) -> parseFloat(element) / 255
  min = Math.min.apply null, rgb
  max = Math.max.apply null, rgb
  
  # hue
  h = max - min
  if h != 0
    switch max
      when rgb[0]
        h = (rgb[1] - rgb[2]) / h
        h += 6 if h < 0
      when rgb[1]
        h = 2 + (rgb[2] - rgb[0]) / h
      when rgb[2]
        h = 4 + (rgb[0] - rgb[1]) / h
  h = Math.round h * 60
  
  # saturation
  s = max - min
  s = s * 100 / max if max != 0
  s = Math.round s
    
  # value
  v = Math.round(max * 100)
    
  [h, s, v]

# used only by name_that_color!
@rgb2hsl = (rgb) ->
  rgb = rgb.map (element) -> parseFloat(element) / 255
  min = Math.min.apply null, rgb
  max = Math.max.apply null, rgb
  delta = max - min

  l = (min + max) / 2

  s = 0
  if l > 0 && l < 1
    s = delta / (if l < 0.5 then 2 * l else 2 - 2 * l)

  h = 0
  if delta > 0
    if max == rgb[0] && max != rgb[1] then h +=     (rgb[1] - rgb[2]) / delta
    if max == rgb[1] && max != rgb[2] then h += 2 + (rgb[2] - rgb[0]) / delta
    if max == rgb[2] && max != rgb[0] then h += 4 + (rgb[0] - rgb[1]) / delta
    h /= 6

  return [parseInt(h * 255), parseInt(s * 255), parseInt(l * 255)]

@darkLevel = (rgb) ->
  coefficients = [0.299, 0.587, 0.114]
  result = 0
  rgb.forEach (element, index) ->
    result += element * coefficients[index]
  100 - 100 * result / 255
# (100 - 100 * (0.299 * R + 0.587 * G + 0.114 * B) / 255)