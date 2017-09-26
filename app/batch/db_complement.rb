include Color

Hattori.all.each do |hattori|
  
  if hattori.r == nil
    p "id:#{hattori.id}のrgbを補完します"
    r, g, b = hex2rgb(hattori.hex)
    hattori.r = r
    hattori.g = g
    hattori.b = b
    hattori.save
  end

  if hattori.h == nil
    p "id:#{hattori.id}のhsvを補完します"
    h, s, v = rgb2hsv([hattori.r, hattori.g, hattori.b])
    hattori.h = h
    hattori.s = s
    hattori.v = v
    hattori.save
  end
  
  if hattori.l_star == nil
    p "id:#{hattori.id}のlabを補完します"
    hattori.l_star, hattori.a_star, hattori.b_star = rgb2lab([hattori.r, hattori.g, hattori.b])
    hattori.save
  end

  if hattori.dark_level == nil
    p "id:#{hattori.id}のdark_levelを補完します"
    hattori.dark_level = dark_level([hattori.r, hattori.g, hattori.b])
    hattori.save
  end
  
end