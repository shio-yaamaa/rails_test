rails runner app/batch/filename.rb

rails runner app/batch/add_hattori.rb --category 2 --title "第0話 タイトル" --description "説明" --date 2000-00-00 --hex 000000
description is optional

categories
1: コミック
2: アニメ
3: 映画
4: ゲーム
5: その他

How to edit
h = Hattori.find(id)
h.title = ""
h.save

edit_hex.rb
.../edit_hex.rb --id 0 --hex 000000ex