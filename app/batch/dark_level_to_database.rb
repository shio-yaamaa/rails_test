include Color
Hattori.all.each do |hattori|
  hattori.dark_level = dark_level([hattori.r, hattori.g, hattori.b])
  hattori.save
end