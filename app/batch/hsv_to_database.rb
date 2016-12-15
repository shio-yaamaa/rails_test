include Color
Hattori.all.each do |hattori|
  h, s, v = rgb2hsv([hattori.r, hattori.g, hattori.b])
  hattori.h = h
  hattori.s = s
  hattori.v = v
  hattori.save
end