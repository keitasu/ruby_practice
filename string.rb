# 空の文字列か
puts 'forbar'.empty?
puts ''.empty?

# 文字列の長さ
puts 'forbar'.length
puts 'てにおは'.length
puts 'てにおは'.bytesize

# 引数の文字列を自身が含んでいるか
puts 'Alice Bob Charlie'.include?('bob')

# 引数に指定した文字列から始まるか
puts 'Highlight'.start_with?('High')

# 文字列の連結
puts 'Pine' + 'apple'

# 文字列の繰り返し
puts 'Hello' * 3

# フォーマットした文字列
puts 'Result: %04d' % 42

# 部分文字列の取得
str = 'The Answer to life, the universe, and everythind: 42'

puts str.slice(4) # 位置を指定
puts str.slice(4, 6) # ある範囲の文字列を開始位置と取得文字数で指定
puts str.slice(4..9) # ある範囲の文字列を範囲で指定
puts str.slice(/[0-9]+/) # 正規表現で指定

puts str.slice(-2, 2)

# 以下ショートハンド
puts str[4]
puts str[4, 6]
puts str[4..9]
puts str[/[0-9]+/]

# 文字列の整形
str = ' hi \t '

puts str.strip # 両端から除去
puts str.rstrip # 右端から除去
puts str.lstrip # 左端から除去

puts 'hi    \n\n'.chomp # 文字列の末尾にある改行コードを1つだけ取り除く
puts 'users'.chop # 文字列の末尾を1文字取り除く

# 同じ文字が連続している場合に1まとめにする
puts 'Wooooooooooo'.squeeze # 重複した文字を全て取り除いた文字列
puts 'aabbccdd'.squeeze('abc') # a,b,cのうち重複した文字を取り除いた文字列

puts 'ABC'.downcase # 全てを小文字にした文字列
puts 'abc'.upcase # 全て大文字にした文字列
puts 'Abc'.swapcase # 大文字と小文字を入れ替えた文字列
puts 'tiTle'.capitalize # 先頭の文字だけを大文字にした文字列

# あるパターンに最初にマッチした文字列を置換する
puts '24-1-365'.sub(/[0-9]+/, 'x')
# マッチした文字列を全て置換する
puts '24-1-36'.gsub(/[0-9]+/, 'x')

# subやgsubは第二引数にブロックを渡せる
puts '24-1-365'.gsub(/[0-9]+/) { |str| str.to_i.succ }

# 直前にマッチした値の情報は組み込み変数の$や$&,$1などからも参照できる
puts '24-1-365'.gsub(/([0-9]+)/) { $1.to_i.succ }

# 文字列を配列に変換
str = 'Alice, Bob, Charlie'

# 文字列か正規表現で分割する
puts str.split(' ')
puts str.split(/, \s+/)

# 要素が2つの配列になるとそれ以上分割しない
puts str.split(/, \s+/, 2)

# 文字列から文字列の配列を得る
puts 'Alice'.split(//)
puts 'Alice'.each_char.to_a

# 文字ごとの繰り返し
'ブフウ'.each_char { |c| puts "#{c}-" }

# バイトごとの繰り返し
'る'.each_byte do |byte|
  puts byte
end

# 行ごとの繰り返し
"Alice\nBon\nCharlie".each_line do |line|
  puts line
end

# エンコーディングの扱い
puts 'てにおは'.encoding

# エンコーディングを変更する
str = 'こんにちは'
puts str.encoding

new_str = str.encode(Encoding::EUC_JP)
puts new_str.encoding

# 破壊的メソッド
str = 'こんにちは'
puts str.encoding
str.encode!(Encoding::EUC_JP)
puts str.encoding

# Frozen string literal
# .freezeのついた文字列リテラルは同じ内容なら同じオブジェクトを参照する
same = [
  'same'.freeze,
  'same'.freeze,
  %(same).freeze
]

p same.map(&:object_id)




