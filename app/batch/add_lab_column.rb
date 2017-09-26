include Color

Hattori.all.each do |hattori|
  lab = rgb2lab([hattori.r, hattori.g, hattori.b])
  hattori.l_star = lab[0]
  hattori.a_star = lab[1]
  hattori.b_star = lab[2]
  hattori.save
end