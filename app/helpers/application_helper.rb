module ApplicationHelper
  
  # \n etc. to <br>
  # simple_format provides similar effect, but it affects the <p> depth
  def br(string)
    raw(html_escape(string).gsub(/\r\n|\r|\n/, "<br>"))
  end
  
  # date
  @@day_of_week = ["日", "月", "火", "水", "木", "金", "土"]
  
  def date_for_show(date)
    date.strftime("%Y年%m月%d日(#{@@day_of_week[date.wday]})")
  end
  
  # menu: 'list', 'upload', 'compare'
  def menu_underline?(menu, path)
    return path.include?(menu)
  end
  
end
