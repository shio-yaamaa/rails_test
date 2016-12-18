module OrderHattoris
  extend ActiveSupport::Concern
  
  @@order_info = {
    new:   {for_display: "新しい順", order: "date"      , reverse: true },
    old:   {for_display: "古い順"  , order: "date"      , reverse: false},
    black: {for_display: "黒い順"  , order: "dark_level", reverse: true },
    white: {for_display: "白い順"  , order: "dark_level", reverse: false}
  }
  
  # hattori: Hattoriオブジェクト, order: シンボル or nil
  def order_hattoris(hattori, order_symbol)
    order_symbol ||= :new
    
    hattoris = hattori.order(@@order_info[order_symbol][:order])
    if @@order_info[order_symbol][:reverse]
      hattoris.reverse_order!
    end
    return hattoris
  end

end