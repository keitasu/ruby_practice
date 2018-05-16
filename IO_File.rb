# ファイルの読み込み
file = File.open('fname.txt') # ファイルを開く
puts file.read                # ファイルの内容を全て読み込んで出力する
file.close                    # ファイルを閉じる

File.open 'fname.txt' do |file|
  puts file.read
end

# 一行ずつ出力する
File.open 'fname.txt' do |f|
  f.each_line do |line|
    puts line
  end
end

puts File.read('fname.txt')

File.open 'fname.txt', 'w' do |f|
  f.write 'Hello' # ファイルに”Hello”と書き込む
end

# r  |  読み込みモード
# r+ |  読み書き両用
# w  |  新規作成して書き込みモード
# W+ |  新規作成して読み書き両用モードで開く
# a  |  追記書き込みモードで開く
# a+ |  読み込み/追記書き込みモードで開く

# ファイルfooを書き込みモードで開く（ファイルが存在しなければ作成する）
File.open 'foo', File::WRONLY | File::CREAT do |f|
  # puts\nと書き込み
  f.puts 'puts'

  # 改行文字(\n)だけを書き込み
  f.puts

  # "print"と書き込み
  f.print 'print'

  # "007"と書き込み
  f.printf "%3d", 7

  # "a"と書き込み
  f.putc 97
end

# ファイルgreetingに"Hello"と書き込む
File.write 'greeting.txt', 'Hello'

# アクセス位置の操作
# ファイルを読み込み、追記モードで開く
File.open 'fname.txt', 'a+' do |f|
  f.puts '文字列を追記'

  # アクセス位置を先頭に戻す
  f.rewind
  
  # 先頭から末尾までの文字列を取得して出力する
  puts f.read
end

File.open 'fname.txt' do |f|
  # 先頭から10進んだ位置(f.seek(10, IO::SEEK_SET)と同じ)
  f.seek 10

  # 現在の位置から10戻った位置
  f.seek -10, IO::SEEK_CUR

  # 末尾から10戻った位置
  f.seek -10, IO::SEEK_END
end

# 任意の位置に移動する
File.open 'fname.txt' do |f|
  # 任意の位置に移動する
  f.pos = 30

  # 現在の位置を返す
  puts f.pos
end

# エンコーディングの扱い
File.open 'fname.txt' do |f|
  # 外部エンコーディングをUTF-8に設定
  f.set_encoding('UTF-8')

  # 外部エンコーディングをEUC-JP, 内部エンコーディングをUTF-8に設定
  # 読み込んだ文字列はEUC-JPからUTF-8に、書き込む文字列はUTF-8からEUC-JPに変換される
  f.set_encoding('EUC-JP', 'UTF-8')

  # :で区切って指定することもできる
  f.set_encoding('EUC-JP:UTF-8') 
end

# 外部エンコーディングをEUC-JP、内部エンコーディングをUTF-8としてファイルを開く
File.open 'fname.txt', 'r:euc-jp:utf-8' do |f|
  puts f.external_encoding # "EUC-JP"と表示
  puts f.internal_encoding # "UTF-8"と表示
end

# ファイルのロック
File.open 'counter', File::RDWR | File::CREAT do |f|
  f.flock File::LOCK_EX

  count = f.read.to_i
  f.rewind

  f.write count.succ
end

File.open 'foo' do |f|
  # 最後にアクセスした日時
  puts f.atime

  # 最後に状態を変更した日時
  puts f.ctime

  # 最後に更新した日時
  puts f.mtime

  # ファイルファイズ
  puts f.size
end

# ファイルに関する情報の取得
File.open 'foo' do |f|
  # 最後にアクセスした日時
  puts f.atime

  # 最後に状態を変更した日時
  puts f.ctime

  # 最後に更新した日時
  puts f.mtime

  # ファイルサイズ
  puts f.size
end

stat = File.open('foo', &:stat)
# ファイルタイプ
puts stat.ftype
puts stat.file?
puts stat.directory?
puts stat.symlink?
puts stat.pipe?
puts stat.socket?

# ファイルの状態
puts stat.writable?
puts stat.readable?
puts stat.executable?

# 自身がオーナーか
puts stat.owned?

# ファイルオーナーの情報
puts stat.gid
puts stat.uid

# inode番号
puts stat.ino

# デバイス番号
puts stat.dev

# ファイルの操作
# ファイル名の変更
# File.rename 'src', 'dest'

# ファイルの移動
# File.rename 'src', 'dir/dest'

# ファイルの削除
# File.unlink 'fname'

# シンボリックリンク
# File.symlink 'origin', 'sym'

# ハードリンク
# File.link 'origin', 'link'

# ファイルモードの指定（モードは8進数で指定）
# File.chmod 0600, 'fname'

# オーナー、グループの変更
# File.chown 216, 216, 'fname'

# 属性や状態の取得
fname = 'fname.txt'

# ファイルの最終アクセス日時、最後に状態を変更した日時、最終更新日時
puts File.atime(fname)
puts File.ctime(fname)
puts File.mtime(fname)

# ファイルの存在
puts File.exist?(fname)

# ファイルの状態
puts File.owned?(fname)
puts File.executable?(fname)
puts File.readable?(fname)
puts File.writable?(fname)

# ファイルタイプ
puts File.ftype(fname)
puts File.file?(fname)
puts File.directory?(fname)
puts File.pipe?(fname)
puts File.socket?(fname)
puts File.symlink?(fname)

# ファイルサイズ
puts File.size(fname)
puts File.zero?(fname)

# より詳しい情報を得る
puts File.stat(fname)

# ファイルパスの操作
fname = 'fname.txt'

# ファイルのあるディレクトリパス
puts File.dirname(fname)

# ファイル名
puts File.basename(fname)

# 拡張子を除いたファイル名
puts File.basename(fname, '.*')

# ファイルの拡張子
puts File.extname(fname)

# ファイルパス同士を連結する（可変長引数をとる）
puts File.join('usr/local', 'bin/ruby')

# dirnameとbasenameの配列
puts File.split('/usr/local/bin/ruby')

# ディレクトリを指定して絶対パスを得る(File.absolute_path)
puts File.expand_path('fname', '/path/to/there')

# ディレクトリパスを省略するとカレントディレクトリが使用される
puts File.expand_path('..', __FILE__)

# - を展開した絶対パスを得る
puts File.expand_path('-')

# File.absolute_pathは先頭の-を展開しない
puts File.absolute_path('-')

# シンボリックリンクから実際のファイルの絶対パスを得る
# puts File.realpath('symlink')

# ファイルはKernel.#openでも開ける
open('foo') { |f| puts f.read }

# コマンドの実行
open('|uname -a') { |io| puts io.read }

# 子プロセスの作成
open '|-', 'w' do |io|
  if io
    # 親プロセスではブロック引数がIOオブジェクト
    io.puts 'hello, world!'
  else
    # 子プロセスではブロック引数がnil
    p gets
  end
end

