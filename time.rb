# 地方時の時刻を返す
p Time.now
p Time.new

p Time.now.zone
p Time.now.getutc

# UNIXエポックからの経過秒数を、整数、浮動小数点数、有理数で得る
now = Time.now

p now.to_i
p now.to_f
p now.to_r

# 文字列に変換
p now.to_s

# Timeオブジェクトから年月日や時分秒などの情報を得る
now = Time.now
p now.year
p now.month
p now.day
p now.hour
p now.min
p now.sec

# ナノ秒の部分を整数で返す(Time#to_fよりもより正確)
p now.nsec

# 曜日を日曜(0)から土曜(6)までの整数で返す
p now.wday

# 1月1日を1として年を通しての経過日数を返す
p now.yday

# 比較
# 一見等しい
a = Time.now
b = Time.now

# 実は異なる（ナノ秒を比較するとわかる）
# trueになる時もあるが確実ではない
p a == b
p a.nsec
p b.nsec

# ComparableモジュールをincludeしているのでTimeオブジェクト同士で比較できる
past = Time.now
sleep 1
future = Time.now

p past <=> future
p past< future
p past <= future
p past > future
p past >= future

# 加算/減算
now = Time.now

# 右辺は秒数として扱われる
p now + 1
p now - 1

# 差分となる秒数が浮動小数点数で返る
a = Time.now
sleep 1
b = Time.now

p b - a

# Timeオブジェクトの作成
# Unitエポックを取得
p Time.at(0)

# UTCとして取得
p Time.at(0).getutc

# 遥か昔・遠い未来
p Time.at(-11676128400)
p Time.at(2208956400)

# UTCを得る例
p Time.utc(2011, 4, 1, 5, 30, 20, 100)
p Time.utc(2011)

# Time#to_aで秒、分、時、日、月、年、曜日(0-6)、その年の通算日数、夏時間か否か、
# タイムゾーンが得られる

p args = Time.now.to_a

# UTCとしてTimeオブジェクトを得る
p Time.utc(*args)

# 地方時としてTimeオブジェクトを得る
p Time.local(*args)

# 文字列表現
now = Time.now
p now.strftime('%Y/%m/%d %H:%M:%S')

# より細かく指定する
now = Time.now

# 数字で桁数を指定
p now.strftime('%Y')
p now.strftime('%010Y')

# _で、0埋めではなく空白埋めにする
p now.strftime('%_10Y')

# -で、左寄せにする（０や空白で埋めない）
p now.strftime('%m')
p now.strftime('%-m')

# #で、大文字であれば小文字に、小文字であれば大文字にする
p now.strftime('%p')
p now.strftime('%P')
p now.strftime('%#p')
p now.strftime('%#P')

# ^で、大文字にする
p now.strftime('%B')
p now.strftime('%^B')


