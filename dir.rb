# 現在のディレクトリ
puts Dir.pwd

# 実行しているユーザーのホームディレクトリ
puts Dir.home

# 実行中のプロセスのカレントディレクトリを変更する
# Dir.chdir '/home'

puts Dir.pwd

# Dir.chdirはブロックを受け取れる
# ブロック実行後は元のディレクトリに戻る

Dir.chdir '/home' do |path|
  puts path
  puts Dir.pwd
end

puts Dir.pwd


# ファイル一覧を取得
puts Dir.entries(Dir.pwd)

# ディレクトを開いて一覧を取得する
Dir.open '/home' do |dir|
  puts dir.entries
end

# 与えられたパターンにマッチするファイルパス一覧の配列を返す
puts Dir.glob "#{ Dir.pwd }/*"

# ディレクトリを再帰的に辿る
# puts Dir.glob "#{ Dir.home }/**/*.jpg"

# ディレクトリを開く
dir = Dir.open Dir.pwd

# 現在開いているディレクトリ名
puts dir.path

# ファイル一覧を取り出す
dir.each do |file|
  puts file
end

# 読み込み位置を先頭に巻き戻す
puts dir.rewind

# 現在の読み込み位置を返す
puts dir.pos

# 現在の位置のファイル名を返し、読み込み位置を1つ進める
puts dir.read

# 読み込み位置を任意の場所に移動する
dir.pos = 3

puts dir.pos

# ディレクトリを閉じる
dir.close

# ディレクトリの操作
# ディレクトリを作成する
Dir.mkdir 'foo', 0755

# ディレクトリの移動（リネーム）
File.rename 'foo', 'bar'

# ディレクトリの削除
Dir.rmdir 'bar'
# 以下のメソッドでも可能
# Dir.unlink 'bar'
# Dir.delete 'bar'

# ディレクトリの状態を確認する
# ディレクトリが存在するか
dir = 'foo' # 存在しないディレクトリ
puts Dir.exist?(dir)
Dir.mkdir(dir)
puts Dir.exist?(dir)
Dir.delete(dir)

# 指定されたディレクトリが空かどうかを調べる
dir_1 = 'bar' # 存在しないディレクトリ名
dir_2 = File.join(dir_1, 'baz')
Dir.mkdir(dir_1) # ディレクトリを作成する
puts Dir.empty?(dir_1)
Dir.mkdir(dir_2) # ディレクトリ内にさらにディレクトリを作成する
puts Dir.empty?(dir_1)
