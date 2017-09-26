require 'optparse'
require 'active_support'
require 'active_support/core_ext'
include Color
include ColorDifference

params = ARGV.getopts("", "category:", "title:", "description:", "date:", "hex:").with_indifferent_access

if !(params[:category] && params[:title] && params[:date] && params[:hex])
  p "オプションが足りません"
else
  rgb = hex2rgb(params[:hex])
  hsv = rgb2hsv(rgb)
  lab = rgb2lab(rgb)
  
  p Category.find(params[:category].to_i).hattoris.create(
    title: params[:title],
    description: params[:description] ? params[:description] : "",
    date: Date.parse(params[:date]),
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