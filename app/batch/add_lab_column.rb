include ColorDifference

# add columns l, a, b

Hattori.all.each do |hattori|
  lab = rgb2lab([hattori.r, hattori.g, hattori.b])
  hattori.l = lab[0]
  hattori.a = lab[1]
  hattori.b = lab[2]
  hattori.save
end