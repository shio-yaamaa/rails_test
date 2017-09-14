require 'rubygems'
require 'sqlite3'

# get from the source

colors = []

src_db = SQLite3::Database.new('/app/assets/japanese_colors.sqlite3')

src_db.execute('select * from japanese_color') do |row|
  #rowは結果の配列
  puts row.join("\t")
end
src_db.close

# add to the destination

#colors.each do |color|
#  JapaneseColor.create(
#    hex: color[0],
#    name: color[1]
#  )
#end