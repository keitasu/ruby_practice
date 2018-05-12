class Ruler
  include Comparable

  attr_accessor :length

  def initialize(len)
    self.length = len
  end

  def <=>(other)
    # lengthの結果を返す
    length <=> other.length
  end
end

short = Ruler.new(30) # 短い定規
long = Ruler.new(100) # 長い定規

p short < long
p short > long
p short <= long
p short >= long
p short == long
p short != long

# <=>演算子を実装してする場合の条件
# ・自身が引数よりも大きければ1（正の整数）
# ・自身が引数と等しければ0
# ・自身が引数よりも小さければ-1（負の整数）
# ・比較できなければnil

# clamp
# 引数で指定された上限と下限に収まる様に値を返す
min = Ruler.new(30)
max = Ruler.new(50)

p Ruler.new(20).clamp(min, max)
p Ruler.new(35).clamp(min, max)
p Ruler.new(55).clamp(min, max)
