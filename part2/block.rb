#----------------------------------
# ファイルを一行ずつ取り出す。
# Pathname#each_line(*args) -> Enumerator
# ファイルを一文字ずつ取り出す。
# Pathname#each_char(*args) -> Enumerator
# ファイルを一バイトずつ取り出す。
# Pathname#each_byte(*args) -> Enumerator
# <=>演算子
# a > b => -1, a == b => 0, a > b => 1　を返す。
# %w[]で配列
# selfからmaxまで一ずつふやすながら繰り返し
# Integer#upto(max) -> Enumerator
# ブロックが与えられているか
# block_given?
# Procクラス（使い方だけ）
# ブロックを好きなタイミングで呼ぶことができるのが強み
# hello = Proc.new { |name| p name }
# Proc引数
# def hoge(&proc)
# end
# %w(...) は各単語を要素とする配列を生成するリテラルです。
ary = %w(
  Ruby is a open source programing language with a focus
  on simplicity and productivity. It has an elegant syntax
  that is natural to read and easy to write.
)

call_num = 0
sorted = ary.sort do |a, b| 
  call_num += 1
  a.length <=> b.length
end

# sorted = ary.sort { |a, b| a.length <=> b.length }
# sorted = ary.sort_by { |item| item.length }

puts "sort: #{sorted}"
puts "array: #{ary.length}"
puts "block_count: #{call_num}"

#----------------------------------
# ブロック変数を渡す。ブロックの結果を得る
#----------------------------------
def total(from, to)
  result = 0
  from.upto(to) do |num|
    if block_given?
      result += yield(num) 
    else
      result += num
    end
  end
  return result
end

p total(1, 10)    #=> 55
p total(1, 10) { |num| num ** 2 }   #=> 385

#----------------------------------
# ブロックの引数で結果がどう変化するかのテスト
#----------------------------------
def block_args_test
  yield()       # no block
  yield(1)      # 1  block
  yield(1, 2, 3)# 3 block
end

puts "ブロック変数を|a|で受け取る"
block_args_test do |a| 
  p [a]
end

puts "ブロック変数を|a, b, c|で受け取る"
block_args_test do |a, b, c| 
  p [a, b, c]
end

puts "ブロック変数を|*a|で受け取る"
block_args_test do |*a| 
  p [a]
end

#----------------------------------
# ブロックの実行を制御する
#----------------------------------
n = total(1, 10) do |num| 
  break 0 if num == 5
  num
end
p n   #=> ??(nil)

n = total(1, 10) do |num| 
  next 0 if num % 2 != 0
  num
end
p n     #=> 30

#----------------------------------
# ブロックをオブジェクトとして受け取る
#----------------------------------
hello = Proc.new do |name| 
  puts "Hello #{name}"
end

hello.call("World")
hello.call("Ruby")

# &引数名でブロックを引数に指定できる
def total2(from, to, &block)
  result = 0
  from.upto(to) do |num| 
    if block
      result += block.call(num)
    else
      result += num
    end
  end
  return result
end

p total2(1, 10)   #=> 55
p total2(1, 10) { |num| num ** 2 }    #=> 385

#----------------------------------
# ローカルとブロック変数
#----------------------------------
def call_each(ary, &block)
  ary.each(&block)
end

call_each([1, 2, 3]) { |item| p item } #=> 1\n2\n3

x = y = z = 0
ary = [1, 2, 3]
ary.each do |x, y| 
  y = x
  z = x
  p [x, y, z]
end

p [x, y, z]   #=> [0, 0, 3]

