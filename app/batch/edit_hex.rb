require 'optparse'
require 'active_support'
require 'active_support/core_ext'
include Color

params = ARGV.getopts("", "id:", "hex:").with_indifferent_access

if !params[:hex]
  p "オプションが足りません"
else
  rgb = hex2rgb(params[:hex])
  hsv = rgb2hsv(rgb)
  lab = rgb2lab(rgb)
  
  hattori = Hattori.find(params[:id])
  
  p hattori.update(
    hex: params[:hex],
    r: rgb[0],
    g: rgb[1],
    b: rgb[2],
    h: hsv[0],
    s: hsv[1],
    v: hsv[2],
    l_star: lab[0],
    a_star: lab[1],
    b_star: lab[2],
    dark_level: dark_level(rgb)
  )
end