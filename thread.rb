files = %w(array.rb dir.rb time.rb)

threads = files.map do |file|
  Thread.fork {
    num = File.readlines(file).length
    "#{file}: #{num}"
  }
end

puts threads.map(&:value)

# メインスレッド
puts Thread.main

# 現在実行中のスレッド
puts Thread.current

# 全てのスレッドの配列
puts Thread.list

# 変数の扱い
# スレッドは同じプロセス上の他のスレッドとメモリを共有する
for item in %w(foo bar baz)
  Thread.fork item do |value|
    sleep 1 # 確実にforループが終わるのを待つ

    puts value # 全てのスレッドで各要素の値が表示される
  end
end

(Thread.list - [Thread.current]).each &:join # 子スレッドの終了を待つ

# スレッド固有のデータ
thread = Thread.fork do
  Thread.current[:status] = 'in progress'

  # do something
end

sleep 0.1

# スレッド固有のデータを参照する
puts thread[:status]

# 字面が同じであれば文字列のキーでもアクセスできる
puts thread['status']

# ライフサイクル
t = Thread.fork { sleep 1}

# 状態を文字列で得る
puts t.status

# スレッドが生きているか
puts t.alive?

# スレッドが停止または終了しているか
puts t.stop?

t = Thread.fork do
  # 自スレッドを停止
  Thread.stop

  puts 'hi!'
end

sleep 0.1
puts t.status
puts t.run

t.join

# t = Thread.fork do
#   begin
#     loop do
#       # do somethind
#     end
#   ensure
#       puts 'ensureing...'
#   end
# end

# # 例外を発生させる
# puts t.raise

# begin
#   t.join
# rescue
#   # 異常終了している
#   puts t.status
# end

# スレッドの優先順位
current = Thread.current

puts current.priority

# 現在のスレッド
current = Thread.current
current.priority = 3

# 新たなスレッドを作成
Thread.fork {
  puts Thread.current.priority
}.join