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

group = ThreadGroup.new
thread = Thread.fork do
  sleep 1
  # do something
end

# グループにスレッドを追加
group.add thread

# グループのスレッド一覧
puts group.list

# Mutex
def countup
  File.open 'counter', File::RDWR | File::CREAT do |f|
    last_count = f.read.to_i

    f.rewind
    f.write last_count + 1
  end
end

# Mutexで排他処理を行う
mutex = Mutex.new

10.times.map {
  Thread.fork {
    mutex.synchronize { countup }
  }
}.map(&:join)

puts File.read('counter').to_i

# Queue
queue = Queue.new

# ワーカースレッドを3つ用意
workers = 3.times.map { |t|
  Thread.fork {
    while req = queue.deq
      puts "Worker#{ t } processing.."
      req.call
    end
  }
}

# 10個のリクエストをenqueueする
10.times do |t|
  queue.enq -> {
    sleep 1 # do something
  }
end

# 全てのキューが処理されるまで待つ
sleep 1 until queue.empty?

# キューが空になったので全スレッドがqueueを待っている
p workers.map(&:status)

# 再度キューに追加
3.times do |t|
  queue.enq -> {
    sleep 1 # do something
  }
end

# キューを処理している最中の状態を確認
p workers.map(&:status)

# 全てのキューが処理されるまで待つ
sleep 1 until queue.empty?

class Bucket
  def initialize(limit = 5)
    @appendable = ConditionVariable.new # 出力されるまで待つためのもの
    @flushable = ConditionVariable.new # 行数が一定数に達するまで待つためのもの
    @lock = Mutex.new # @outのロック
    @limit = limit # @outの行数が@limitに達したら@flushableになる
    @out = '' # 出力される文字列
  end

  def append(str)
    @lock.synchronize {
      @appendable.wait(@lock) unless appendable?

      @out << str

      @flushable.signal if flushable?
    }
  end

  def flush
    @lock.synchronize {
      @flushable.wait(@lock) unless flushable?

      puts '-' * 10
      puts @out

      @out = ''
      @appendable.signal if appendable?
    }
  end

  private

  def appendable?
    @out.lines.count < @limit
  end

  def flushable?
    !appendable?
  end
end

bucket = Bucket.new

# 何らかの処理をしてbucketに結果を書き込む
t1 = Thread.fork {
  15.times do |t|
    sleep rand # 処理にかかる些細な時間
    bucket.append "line: #{ t }\n"
  end
}

# bucketに書き込まれた処理結果を一定数ごとに出力する
t2 = Thread.fork {
  3.times do
    bucket.flush
  end
}

[t1, t2].map(&:join)