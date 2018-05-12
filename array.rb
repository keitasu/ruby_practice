p Array.new(5, 1)

# ブロックはnewを呼び出した際に評価される
array = Array.new(3, 'naive')
array[0].reverse!

p array

# 配列の要素数を調べる
array = [4, 4, 2, 3]

p array.length
p array.empty?
p [].empty?

# 引数に与えた要素が存在するか
p array.include?(4)

# 2つの配列から新しい配列を作る
# 配列同士を連結した配列
p [1, 2, 3] + [4, 5]

# 要素を取り除いた配列
p [4, 4, 3, 2] - [4, 3]

# 共通の要素からなる配列
p [1, 2, 3] & [2, 3, 4]

# n回繰り返した配列
p [1, 2, 3] * 2

# 要素の取得
array = [4, 4, 2, 3]

# 添字参照
p array[2]

# 開始位置と長さ、または添字を範囲で指定できる
p array[2, 2]
p array[2..4]

# 複数の添字の要素を配列で返す
p array.values_at(1)
p array.values_at(1, 3)

# 先頭や末尾の要素を得る
# 先頭の要素か、先頭からn個の要素を得る
p array.first
p array.first(2)

# 末尾の要素か、末尾からn個の要素を得る
p array.last
p array.last(2)

# 自身からランダムに要素を返す
p array.sample
# 個数を指定する
p array.sample(2)

# 配列から特定のキーを持つ要素を返す
# 1つ目の要素をキーとして扱う
ary = [[:foo, 4], [:bar, 2], [:baz, 3]]
p ary.assoc(:bar)

# 要素の追加と削除
# 0番目の位置に代入
array[0] = 5
p array

# 自身のサイズを上回る添字を指定された場合はnilで埋められる
array[10] = 1
p array

# 配列の末尾に要素を追加する
array = [4, 4, 2]

# 末尾に要素を追加する
array << 3
p array
array.push 3
p array

# 末尾から要素を取り出す
p array.pop
p array

# 先頭から要素を取り出す
p array.shift
p array

# 先頭に要素を追加する
array.unshift 4
p array

# 各要素にブロックを実行して、結果が真となった要素以外を取り除く
array = [1, 2, 3, 4]
array.select! {|v| v.even? }
p array

# reject!はselect!の逆
array = [1, 2, 3, 4]
array.reject! {|v| v.even? }
p array

# select!やreject!はレシーバが更新されなかった場合、nilを返す
# keep_ifやdelete_ifはレシーバが更新されなかった場合も常にレシーバを返す
array = [1, 2, 3, 4]

# delete_ifとreject! (レシーバが更新されないように常にfalseを返す)
p array.delete_if {|v| false }
p array.reject! {|v| false }

# keep_ifとselect! (レシーバが更新されないように常にtrueを返す)
array.keep_if {|v| true }
array.select! {|v| true }

# 引数の値と等しい要素をすべて削除する。
array = [4, 4.0, 2, 3]
array.delete 4
p array

# 指定した添字の要素
array = [4, 4, 2, 3]
array.delete_at 1
p array

# 配列の整形
array = [false, nil, 0, "", []]
# 配列の要素からnilを取り除く
p array.compact
p array

# 破壊的なcompact!
array.compact!
p array

# 配列から重複を取り除く
array = [4, 4, 4.0, 2]
p array.uniq
p array

# 破壊的なuniq!
array.uniq!
p array

# 自身の順序と逆にした配列を返す
array = [4, 4, 2, 3]
p array.reverse

# 元のオブジェクトは更新されない
p array

# reverse!で自身を破壊する
array.reverse!
p array

# 多次元配列を平らにする
array = [4, [4, [2, 3]]]
p array.flatten
p array

# 破壊的なflatten
array.flatten!
p array

# sort!やsort_by!で破壊的に変更する
array = [4, 4, 2, 3]
array.sort!
p array

array = ['fooo', 'fooo', 'fo', 'foo']
array.sort_by! {|v| v.length }
p array

# map!
people = %w(Alice Bob Charlie)
people.map! {|person| person.upcase }
p people

# 配列を行列に見立てて行と列の入れ替えを行い、新しい配列を返す
array = [['a', 'b', 'c'], [1, 2, 3]]

# 行と列を入れ替えた配列を得る
p array.transpose

# 二次元配列でないとエラーを吐く
# 配列のサイズが異なった場合も同様
# [1, 2, 3, 4].transpose
# [['a', 'b'], [1, 2, 3]]

# 自身と引数に渡された配列から、配列の配列を作成する。
array = [1, 'a']
p array.zip([2, 'b'], [3, 'c'])

# 二分探索
array = [1, 3, 5, 7, 9]
p array.bsearch {|n| n > 6 }
p array.bsearch {|n| n > 10 }

# 要素の連結
array = [24, 1, 365]
p array.join
p array.join('-')


