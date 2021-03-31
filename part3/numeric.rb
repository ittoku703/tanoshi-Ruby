#----Numericのクラス構成---------------------------------
# Numeric ----> Integer ----> Fixnum (普通の整数)
# |                      |--> Bignum (大きな整数)
# | ----------> Float (浮動小数点数)
# | ----------> Rational (有理数)
# | ----------> Complex (複素数)
#
# 数値のリテラル
# 0o123 8進数表記, 0x 16進数表記 0b 2進数表記
# 1.23e4(12300.0) 指数表記, 123r(123/1) 有理数, 123i 虚数の123i
# PI    円周率(3.141592653589793)
# E     自然対数の底e(2.71821828459045)
# 疑似乱数は計算によって乱数のように見える値のこと。
# upto, downto, stepメソッドはブロックを与えなければEnumeratorオブジェクトを
# 返す。それによってブロック変数として得られつ数値をEnumerator#collect
# メソッドで収集したりできる。
# Comparableモジュール(<, <=, ==, >=, >, between?)
# a <=> bの結果
# a < b = -1, a == b = 0, a > b = 1
# 関数一覧
# Rational(分子, 分母)で生成する。
# Rational#numerator -> Integer 分子を返します。
# Rational#denominator -> Integer 分母を返します。
# Complex(実数部、虚数部)生成する
# Complex#real -> Numeric 自身の実数を返す
# complex#imaginary -> Numeric 自身の虚部を返す
#--------------------------------------------------------
# ruby2.4.0からFixnum, BignumはIntegerクラスのエイリアスとなった
n = 2 ** 10
p n.class #=> Integer
n = 2 ** 1000
p n.class #=> Integer
# 分数の計算はRationalクラスを使う
a = Rational(2, 5)
b = Rational(1, 3)
p [a, b]    #=> [(2/5), (1/3)]
c = a + b
p c         #=> (11/15)
p c.to_f    #=> 0.7333333333333333
p [c.numerator, c.denominator] #=> [11, 15]
# Complex
c = Complex(1, 2) ** 2
p c   #=> (-3+4i)
p [c.real, c.imaginary]   #=> [-3, 4]

# 割った数と余りを返す
p 10.divmod(3)    #=> [3, 1]
# 浮動小数点, 分数、複素数に変換
p 10.to_f, 1.5.to_r, 1.5.to_c
# 四捨五入
p 0.12.round(1)
# ceilは上の数に、floorは下の数を返す
p 1.5.ceil, 1.5.floor
# ビット演算
def pb(i) 
  # 整数の末尾8ビットを2真数表示する
  printf("%08b\n", i & 0b11111111)
end
b = 0b11110000
pb(b)   #=> 11110000
pb(~b)  #=> 00001111
pb(b & 0b00010001)    #=> 00010000
pb(b | 0b00010001)    #=> 11110001
pb(b ^ 0b00010001)    #=> 11100001
pb(b >> 3)        #=> 00011110
pb(b << 3)        #=> 10000000
# 乱数
p Random.rand     #=> random_number
p Random.rand(100)  #=> 0から99までの乱数

r1 = Random.new(1)
p [r1.rand, r1.rand]    #--|
r1 = Random.new(1)      #  |
p [r1.rand, r1.rand]    #--|--> 同じ値

require 'securerandom'
p SecureRandom.random_bytes(12)   #=> ランダムなバイト列
p SecureRandom.base64(12)     #=> ランダムな英数字と記号
# 数え上げ
ary = []
10.times { |i| ary << i }
p ary     #=> [1, 2, 3, ..., 9]
ary = []
2.upto(10) { |i| ary << i }
p ary     #=> [2, 3, 4... , 10]
ary = []
10.downto(2) { |i| ary << i }
p ary     #=> [10, 9, 8 ... 2]
ary = []
2.step(10, 3) { |i| ary << i }
p ary     #=> [2, 5, 8]
ary = 2.step(10).collect{ |i| i * 2 }
p ary     #=> [4, 6, 8, 10, ... 20]
# 丸め誤差
a = 0.1 + 0.2
b = 0.3
p [a, b, a == b]  #=> [0.30...4, 0.3, false]
# Rationalクラスを使うと正しい結果を得られる
a = 1 / 10r + 2 / 10r
b = 3 / 10r
p [a, b, a == b]  #=> [(3/10), (3/10), true]
# Comparableモジュール
class Vector
  include Comparable
  attr_accessor :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def scalar = Math.sqrt(x ** 2 + y ** 2)
  def <=>(other) = scalar <=> other.scalar
end

v1 = Vector.new(2, 6)
v2 = Vector.new(4, -4)
p [v1 <=> v2, v1 < v2, v1 > v2]   #=> [1, false, true]

