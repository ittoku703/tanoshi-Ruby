# -----------------------------------------------------------------------
# Array#collectのような動作をするmy_collectメソッドを作成してください。
# 引数としてeachメソッドを持つオブジェクトを受け取って書く要素をブロック
# として処理する
# -----------------------------------------------------------------------
def my_collect(obj, &block)
  result = []
  if block
    obj.each { |i| result << block[i] }
  else
    $stderr.puts "block empty!"
  end
  return result
end

ary = my_collect([1, 2, 3, 4, 5]) do |i| 
  i * 2
end
p ary   #=> [2, 4, 6, 8, 10]

# -----------------------------------------------------------------------
# Symbol#to_procメソッドを使ったサンプルの結果を確認してください
# -----------------------------------------------------------------------
to_class = :class.to_proc
p to_class.call("test")     #=> String
p to_class.call(123)        #=> Integer
p to_class.call(2 ** 100)   #=> Integer

# -----------------------------------------------------------------------
# 実行するたびにcallメソッドでそれまでに与えられた引数の合計を返すProc
# メソッドを返すメソッドを完成させてください。
# -----------------------------------------------------------------------
def accumlator
  total = 0
  Proc.new do |x|
    total += x
  end
end

acc = accumlator
p acc.call(1)      #=> 1
p acc.call(2)      #=> 3
p acc.call(3)      #=> 6
p acc.call(4)      #=> 10

