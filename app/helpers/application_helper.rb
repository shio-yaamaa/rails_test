module ApplicationHelper
  
  # color
  
  def hex_to_rgb(hex)
    rgb = []
    3.times do |i|
      rgb.push(hex[i * 2, 2].to_i(16))
    end
    return rgb
  end
  
  def dark_level(rgb)
    100 - 100 * rgb.zip([0.299, 0.587, 0.114]).inject(0) { |sum, element|
      sum + element.inject(:*)
    } / 255
  end
  # (100 - 100 * (0.299 * R + 0.587 * G + 0.114 * B) / 255)
  
  # date
  
  def date_for_show(date)
    day_of_week = ["日", "月", "火", "水", "木", "金", "土"]
    date.strftime("%Y年%m月%d日("+day_of_week[date.wday]+")")
  end
  
end
