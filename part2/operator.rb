#-----------------------------
# 論理演算子
#-----------------------------
# name = "Ruby"
# if name
#   name = "Ruby"
# end
name = name || "Ruby"
name ||= "Ruby"
p name

# item = nil
# ary = ["hoge", "bar", "baz"]
# if ary
#   item = ary.first
# end
ary ||= ["hoge", "bar", "baz"]
item = ary && ary.first
item = ary&.first
p item

#-----------------------------
# 条件演算子
#-----------------------------
a = 1
b = 2
max = a > b ? a : b
p max

#-----------------------------
# 範囲演算子
#-----------------------------
sum ||= 0
# for i in 1..5
#   sum += 1
# end
(1..5).each { sum += 1 } 
p sum

class Point
  attr_accessor :x, :y

  def initialize(x=0, y=0)
    @x, @y = x, y
  end

  def inspect
    "#{x}, #{y}"
  end

  def +(other) = self.class.new(x + other.x, y + other.y)
  def -(other) = self.class.new(x - other.x, y - other.y)

  def +@ = dup
  def -@ = self.class.new(-x, -y)
  def ~@ = self.class.new(-y, x)

  def [](index)
    case index
    when 0 then x
    when 1 then y
    else raise ArgumentError, "out of range `#{index}`"
    end
  end

  def []=(index, val)
    case index
    when 0 then self.x = val
    when 1 then self.y = val
    else raise ArgumentError, "out of range `#{index}`"
    end
  end
end

point0 = Point.new(3, 6)
point1 = Point.new(1, 8)
p point0            #=> (3, 6)
p point1            #=> (1, 8)
p point0 + point1   #=> (4, 14)
p point0 - point1   #=> (2, -2)

point = Point.new(20, 60)
p +point           #=> (20, 60)
p -point           #=> (-20, -60)
p ~point           #=> (-60, 20)

point = Point.new(3, 7)
p point[0]         #=> 3 
p point[1] = 2     #=> 2
p point[1]         #=> 2
# p point[2]       #=> ArgumentError!!!

