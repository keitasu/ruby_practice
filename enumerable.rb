# 繰り返しの度にインクリメントされる値と一緒に繰り返す
%w(Alice Bob Charlie).each_with_index do |name, index|
  puts "#{index}: #{name}"
end

# 末尾から逆順に取り出す
(1..3).reverse_each do |val|
  puts val
end

# 要素をn個ずつで区切って繰り返す
(1..5).each_slice 2 do |a, b|
  p [a, b]
end

# n個の連続した要素を1つずつずらしながら繰り返す
(1..4).each_cons 2 do |a, b|
  p [a, b]
end

# 要素が特定の条件を満たしているか
# 全ての要素が真ならばtrueを返す
p [true, true, true].all?
p [false, true, false].all?

# 全ての要素が偽ならtrueを返す
p [false, false, false].none?

# 1つでも真の要素があればtrueを返す
p [true, true, false].any?
p [false, false, false].any?

# 1つだけ真であればtrueを返す
p [true, false, false].one?
p [true, true, false].one?

# 上記のメソッドにはブロックを渡せる
# 要素が全て整数ならtrueを返す
p [4, 4, 2, 3].all? { |v| v.is_a?(Integer)}
p [4, 4, 'two'].all? { |v| v.is_a?(Integer)}

# 部分的な要素の取得

p %w(Alice Bob Charie).grep(/a/i) # /a/iにマッチする要素
p ['a', 'b', 3, 4].grep(String) # 文字列である要素

object = Object.new
p object.methods.grep(/\?/)

# 戻り値が最初に真になった要素を返す
array = [4, 4, 2, 3]
p array.detect { |v| v.even? }

# ブロックの戻り値が真となった要素を全て返す
# rejectは逆の動作をする
array = [4, 4, 2, 3]
p array.select { |v| v.even? }
p array.reject { |v| v.even? }


array = [1, 2, 3, 4, 5]
# 先頭から任意の数の要素を配列として返す
p array.take(3)
# 任意の数の要素をスキップして残りの要素の配列を返す
p array.drop(3)

# 畳み込み演算
p [4, 4, 2, 3].inject(0) {|result, num|
  result + num
}

# 繰り返しとオブジェクトの更新
p %w(Alice Bob Charlie).each_with_object({}) {|name, result|
  result[name] = name.length
}

# 要素をまとめる
array = ['1', 2.0, 3.0, [4]]
p array.group_by { |val| val.class }

# ブロックを真偽値として扱い、自信を2つのグループに分ける
array = [1, 2, 3, 4, 5]
p array.partition {|n| n.even? }

# 特定のパターンが出現した際にその前後で区切っていく
lines = <<EOS.lines
1st paragraph

2nd
paragraph
EOS

p lines.slice_before("\n").to_a
p lines.slice_before {|line| line == "\n" }.to_a

# 最大値と最小値
range = (1..10)
p range.max
p range.min
p range.minmax

# 最大、最小を独自に計算する
# 最大、最小が重複する場合は、どの要素が返されるか不定
people = %w(Alice Bob Charlie)
p people.min_by {|s| s.length }
p people.max_by {|s| s.length }
p people.minmax_by {|s| s.length }

# ソート
people = %w(Bob Alice Charlie)

# 要素でソートする
p people.sort

# 要素の長さでソートする(1)
p people.sort {|a, b| a.length <=> b.length }

# 要素の長さでソートする(2)
p people.sort_by {|name| name.length }
