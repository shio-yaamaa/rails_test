class HattoriObject
  include Color
  include NameThatColor
  
  @@hattoris = {} # {"id": "object", "id": "object", ...}
  
  def initialize(hattori_from_db)
    @title = hattori_from_db.title
    @description = hattori_from_db.description
    @date = hattori_from_db.date
    @color = hattori_from_db.color
    
    @rgb = hex2rgb(@color)
    @hsv = rgb2hsv(@rgb)
    @dark_level = dark_level(@rgb)
    @color_name = name_that_color(@rgb)
  end
  
  def self.load_hattoris
    if @@hattoris.size == 0
      Hattori.all.each do |hattori|
        @@hattoris[hattori.id.to_s] = HattoriObject.new(hattori)
      end
    end
  end
  
  def self.get_all_hattoris
    self.load_hattoris()
    @@hattoris
  end
  
  def self.find_hattori(id)
    @@hattoris[id.to_s]
  end
  
  def self.sort_by_dark_level(reverse = false)
    @@hattoris.sort_by! {|key, value| value.dark_level}
    if !reverse
      @@hattoris.reverse!
    end
  end
  
  def self.sort_by_date(reverse = false)
    @@hattoris.sort_by! {|key, value| value.date}
    if reverse
      @@hattoris.reverse!
    end
  end
  
end