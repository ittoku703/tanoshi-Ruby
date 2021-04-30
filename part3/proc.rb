# ----------------------------------------------------------------------
# ブロックをコンテキストとともにオブジェクト化した手続きオブジェクトです。
# ローカル変数のスコープを導入しないことを除いて名前のない関数のように使える
# ダイナミックローカル変数は Proc ローカルの変数として使えます。
# to_procメソッドはブロックを指定する時に&オブジェクトの形式で引数を渡すと
# object.to_procが自動的に呼ばれる。
# 手続きと同時に変数などの環境を保持する手続きオブジェクトを
# プログラミング用語でクロージャという。
# &:メソッド名とは
# & 手続きオブジェクトをブロックに変換するショートハンド
# :メソッド Rubyのシンボル
#
# Proc.new{...}
# Proc{...}
#
# インスタンスメソッド
# prc.call(args, ...)
# prc[args, ...]
# prc.yield(args, ...)
# prc.(args, ...)
# prc === arg
# prc.arity
#   ブロック変数の数を返す
# prc.parameters
#   prcのブロック変数の詳細な情報を返す。
#   :opt       省略可能な変数
#   :req       必須な変数
#   :rest      *args形式で受け取る残りの変数
#   :key       キーワード引数の形式の変数
#   :keyset    **args形式で受け取る残りの変数
#   :block     ブロック
# prc.lambda?
# prc.source_location
#   [ソースファイル名、行番号]の形式で返す。
# ----------------------------------------------------------------------
# Helloプログラム
hello = Proc.new { |name| puts "Hello #{name}" }
hello.call("Ruby")    #=> Hello Ruby

# 閏年を判定する
leap = Proc.new do |year|
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end
p [leap.call(2000), leap[2013], leap.call(Time.now.year)]
  #=> [true, false, false]

# 配列も引数にできる
double = Proc.new do |*args|
  args.map { |i| i * 2 }
end
p [double.call(1, 2, 3), double[1, 2, 3]]
  #=> [[2, 4, 6], [2, 4, 6]]

# lambda式
prc = Proc.new { |a, b, c| p [a, b, c] }
prc.call(1, 2)    #=> [1, 2, nil]
prc = lambda { |a, b, c| p [a, b, c] }
prc.call(1, 2) rescue p "ArgumentError: wrong number of arguments"
square = -> n { return n ** 2 }
p square[5]   #=> 25

# 引数にProcをブロックとして受け取る
def total(from, to, &block)
  result = 0
  from.upto(to) do |num|
    result += block ? block.call(num) : num
  end
  return result
end

p [total(1, 10), total(1, 10) { |num| num ** 2 }]
  #=> [55, 385]

# to_procメソッド
p %w[42, 39, 56].map { |i| i.to_i }
p %w[42, 39. 56].map(&:to_i)
p [Integer, String, Array, Hash, File, IO].sort_by(&:name.downcase)

# カウントアップする
def counter
  c = 0
  Proc.new { c += 1 }
end

count = counter
p [count.call, count.call, count.call]    #=> [1, 2, 3]

# インスタンスメソッド
prc = Proc.new { |a, b| a + b }
p [prc.call(1, 2), prc[3, 4], prc.yield(5, 6), prc.(7, 8), prc === [9, 10]]
  #=> [3, 7, 11, 15, 19]

fizz = Proc.new { |n| n % 3 == 0 }
buzz = Proc.new { |n| n % 5 == 0 }
fizzbuzz = Proc.new { |n| fizz[n] && buzz[n] }
(1..15).each do |i|
  case i
  when fizzbuzz then printf("%02d is Fizz Buzz\n", i)
  when fizz     then printf("%02d is Fizz\n", i)
  when buzz     then printf("%02d is Buzz\n", i)
  end
end

prc = Proc.new { |a, b, c| a + b + c }
p prc.arity   #=> 3
prc = Proc.new { |*args| args }
p prc.arity   #=> -1

prc0 = proc{nil}
prc1 = proc{|a| a }
prc2 = lambda{|a, b| [a, b] }
prc3 = lambda{|a, b=1, *c| [a, b, c] }
prc4 = lambda{|a, &block| [a, block] }
prc5 = lambda{|a: 1, **b| [a, b] }

p prc0.parameters #=> []
p prc1.parameters #=> [[:opt, :a]]
p prc2.parameters #=> [[:req, :a], [:req, :b]]
p prc3.parameters #=> [[:req, :a], [:opt, :b], [:rest, :c]]
p prc4.parameters #=> [[:req, :a], [:block, :block]]
p prc5.parameters #=> [[:key, :a], [:keyrest, :b]]

p [prc0.lambda?, prc5.lambda?]    #=> [false, true]

p [prc1.source_location, prc2.source_location]
  #=> [["proc.rb", 109], ["proc.rb", 110]]


