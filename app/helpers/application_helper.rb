module ApplicationHelper
  # date
  
  def date_for_show(date)
    day_of_week = ["日", "月", "火", "水", "木", "金", "土"]
    date.strftime("%Y年%m月%d日("+day_of_week[date.wday]+")")
  end
  
end
