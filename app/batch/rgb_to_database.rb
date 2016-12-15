include Color
Hattori.all.each do |hattori|
  r, g, b = hex2rgb(hattori.hex)
  hattori.r = r
  hattori.g = g
  hattori.b = b
  hattori.save
end