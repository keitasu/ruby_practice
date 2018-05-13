# ミュータブルなオブジェクトはキーに向かない
array = [1, 2]

p array.hash
array.reverse!
p array.hash

# 繰り返し処理
hash = {one: 1, two: 2}

# キーと値を繰り返す
hash.each do |key, val|
  puts "#{key}: #{val}"
end

# キーだけを繰り返す
hash.each_key do |key|
  puts key
end

# 値だけを取り出す
hash.each_value do |val|
  puts val
end

# 値の更新/追加/削除
hash = {}
hash[:foo] = 'bar'

p hash

hash.delete(:foo)

p hash

# ハッシュから特定のエントリだけを残して破壊的に更新する
hash = {foo: 1, bar: 2, baz: 3}

# 値の整数が奇数であれば残す
hash.select! {|key, val| val.odd? }
p hash

hash = {foo: 1, bar: 2, baz: 3}

# 値の整数が奇数であれば取り除く
hash.reject! {|key, val| val.odd? }
p hash

# 戻り値にselfを期待する場合はkeep_ifとdelete_ifを使う
hash = {foo: 1, bar: 2, baz: 3}

# 変更が無くても常にselfを返す
p hash.keep_if {|key, val| true }
p hash.delete_if {|key, val| false }

# selectやrejectは常に新しいhashを返す
hash = {foo: 1, bar: 2, baz: 3}

p hash.select {|key, val| val.odd? }
p hash.reject {|key, val| val.odd? }

# ブロックの実行結果で置き換えたhashを返す
names = {a: 'alice', b: 'bob', c: 'carol'}

p names.transform_values {|name| name.capitalize }

# 破壊的なやつ
names.transform_values! {|name| name.capitalize }
p names

# マージ
a = {one: 'A', two: nil}
b = {two: 'B', three: 'C'}

# aをbにマージ(twoは重複しているので上書きされる)
p a.merge(b)

# オプションのようなハッシュ引数にデフォルト値を持たせたいときに便利
def keywords(**options)
  default = {alice: 'ありす', bob: 'ぼぶ'} # デフォルト値のハッシュ
  hash    = default.merge(options)

  hash
end

p keywords bob: 'ボブ'

# 破壊的なやつ
hash = {one: 'A'}

hash.merge! two: 'B'
p hash

# キーと値の入れ替え
hash ={one: 1, two: 2}.invert
p hash

hash ={foo: 1, bar: 1}.invert # どちらも同じ要素なので片方が消える
p hash

# キーや値が存在しているか
hash = {foo: nil}

# 値がnilの場合と区別がつかない
p hash[:unknown]
p hash[:foo]

# 存在を確認するにはhas_key?を用いる
p hash.has_key?(:unknown)
p hash.has_key?(:foo)

# Hash#has_key?と同様の動作をするメソッド
p hash.key?(:foo)
p hash.member?(:foo)
p hash.include?(:foo)

# 指定した値を持つエントリが存在するか確認する
hash = {foo: 'bar'}

p hash.has_value?('bar')
p hash.has_value?('baz')

# Hash#has_value?を同じ
p hash.value?('bar')

# キーや値の取得
h = {one: 'A', two: 'B', three: 'C'}
p h.keys

# 特定の値を持つキーを返す
# 同じキーが存在する場合に何が返されるかは不定
hash = {one: 'A', two: 'B', three: 'C'}
p hash.key('B')

# 値の配列を返す
hash = {one: 'A', two: 'B', three: 'C'}
p hash.values
# 任意のキーだけを得る
p hash.values_at(:three, :two)

# 複数の値を一度に変数に代入する
three, two = hash.values_at(:three, :two)
p two
p three

# ネストしたハッシュから値を取り出す
# digは存在しないキーを指定してもNoMethodErrorが発生せずに
# nilが返る
hash = {
  alice: {books: {wonder: 1865}},
  charlie: {} 
}

p hash[:alice][:books][:wonder]
p hash.dig(:alice, :books, :wonder)

# デフォルト値
has_default = Hash.new('undefined')
p has_default['foo']

# デフォルト値として返る値は全て同一のオブジェクト
# 破壊的な変更をした際には全てのデフォルト値に影響がでる
has_default = Hash.new('naive')
value       = has_default['foo']

p value.reverse! # 破壊的な操作

p has_default['foo']

# デフォルト値にはブロックを渡せる
has_default = Hash.new {|hash, key| Time.now }

p has_default['foo']
sleep 1
p has_default['foo']

# 添字参照したタイミングでブロックが実行されブロックの値が戻り値となる
# Hash#default_procで既にあるHashオブジェクトにもデフォルト値を設定できる

has_default = {}
p has_default['foo']

# デフォルトの固定値を設定する
has_default.default = 'bar'
has_default['foo']

# デフォルト値を返す手続きオブジェクトを設定する
has_default.default_proc = ->(hash, key) { Time.now }
p has_default['foo']

# ハッシュの戻り値を参照する
# 値が存在しない場合の戻り値をブロックで指定できる
hash = {} # 空のハッシュ

p hash.fetch('foo', 'default')
p hash.fetch('foo') {|key| key }
# p hash.fetch('foo') # KeyErrorが発生する

# ハッシュの変換
p a = {one: 1, two: 2}.to_a

p a.assoc(:one)

# 要素が偶数個の配列
ary = ['key1', 'one', 'key2', 'two']
p Hash[*ary]

# 配列の配列を返す
ary = [['key1', 'one'], ['key2', 'two']]
p Hash[ary]
