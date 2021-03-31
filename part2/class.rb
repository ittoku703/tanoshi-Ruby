# クラス
# class Hoge
#   Version = "1.0"     定数
#   @@count = 0         クラス変数
#   attr_reader :name   参照のみ可能
#   attr_writer :name   変更のみ可能
#   attr_accessor :name   参照と変更が可能
# 
#   初期化
#   initialize(myname = "hoge")
#     @name = myname
#   end
# end
# 
# 定数呼び出し
# Hoge::Version
# クラス変数呼び出し
# Hoge.count
# 
# length, count, sizeメソッドの違い
# length, sizeは同じエイリアス
# countは、引数が取れるので、特定の要素の数を取得できる。
# 
# aliasの使い方
# 同じ機能を複数の名前で使うときに使用
# alias 別の名前　元の名前
# 
# undefは定義したメソッドを消去する
# undef メソッド名
# 
# 特異メソッド
# 任意のオブジェクト（変数）にメソッドを追加できる
# class << 変数名
#   定義
# end
# 
# モジュールの使い方
# 複数のクラスで共通したメソッドを利用できる
# includeでモジュールを適用(名前空間)
# module Hoge
#   共通で使用したいメソッド
#   hoge_methodを公開
#   module_function :hoge_method
# end
# 
# class HogeClass
#   include Hoge
#   このクラスの固有メソッド
# end
# 
# FileTest.exist?("PATH")     ファイルの存在を調べる
# FileTest.size("PATH")       ファイルのサイズを調べる
# 
# Class.include?(Class)       includeされているか調べる
# Class.ancestors             軽症の関係のあるクラスを一覧表示
# 
#---------------------------------
# 基本的なクラスの使い方
#---------------------------------
class HelloWorld
  Version = "1.0"
  @@count = 0
#   attr_reader :name   # 参照のみ可能
#   attr_writer :name   # 変更のみ可能
  attr_accessor :name   # 参照と変更が可能

  #---------------------------------
  # 初期化
  #---------------------------------
  def initialize(myname = "Ruby")
    @name = myname
  end

  #---------------------------------
  # クラス変数を参照する
  #---------------------------------
  def HelloWorld.count
    @@count
  end

  def hello
    puts "Hello world. i\'m #{@name}."
    @@count += 1
  end

#   def name
#     @name
#   end
# 
#   def name=(value)
#     @name = value
#   end
  
  def greet
    puts "Hi, i\'m #{self.name}."
  end

  def pub
    puts "pub is a public method."
  end

  def pri
    puts "pri is a private method."
  end

  def pro
    puts "pro is a protected method."
  end

  # インスタンスメソッドとして公開
  public :pub
  # 外側からアクセスできない
  private :pri
  # 同一のクラスならアクセスできる
#   protected :hello
end

bob = HelloWorld.new("Bob")
alice = HelloWorld.new("Alice")
ruby = HelloWorld.new

bob.hello
bob.name = "bobby"
bob.hello
p "HelloWorld version is #{HelloWorld::Version}."
p "HelloWorld count is #{HelloWorld.count}."
bob.pub
# error --> bob.pri

#---------------------------------
# protectedメソッドの仕様例
#---------------------------------
class Point
  attr_accessor :x, :y
  protected :x=, :y=

  def initialize(x=0.0, y=0.0)
    @x, @y = x, y
  end

  def swap(other)
    tmp_x, tmp_y = @x, @y
    @x, @y = other.x, other.y
    other.x, other.y = tmp_x, tmp_y

    return self
  end
end

p = Point.new
p_hoge = Point.new(1.0, 9.0)
pp "swap before: #{[ p.x, p.y]}"
p.swap(p_hoge)
pp "swap after: #{[ p.x, p.y]}"

#---------------------------------
# クラスの拡張（メソッドを追加）
#---------------------------------
class String
  def count_word
    ary = self.split(/\s+/)
    return ary.size
  end
end

str = "Just Another Ruby Newbie."
p "str word count is #{str.count_word}"

#---------------------------------
# 継承
#---------------------------------
class RingArray < Array
  def [](i)
    idx = i % size
    super(idx)
  end
end

wday = RingArray["sun", "mon", "tues", "wednes", "thurs", "fri", "satur"]
p "wday[6]: #{wday[6]}"
p "wday[11]: #{wday[11]}"
p "wday[15]: #{wday[15]}"
p "wday[-1]: #{wday[-1]}"

#---------------------------------
# aliasとundef
#---------------------------------
class C1 
  def hello
    "Hello"
  end

  def hoge
    "hoge"
  end
end

class C2 < C1
  alias old_hello hello
  undef hoge

  def hello
    "#{old_hello}, again."
  end
end

obj = C2.new
p obj.old_hello
p obj.hello

#---------------------------------
# 特異メソッド
#---------------------------------
str = "Ruby"
class << str
  def hello
    "Hello #{self}"
  end
end

p str.hello

#---------------------------------
# module
#---------------------------------

module HelloModule
  Version = "1.0"

  def hello(name)
    puts "Hello #{name}"
  end
  module_function :hello
end

p "HelloModule version is #{HelloModule::Version}."
HelloModule.hello("kaz")
# include 例
# include HelloModule
# p "HelloModule version is #{Version}."
# hello("kaz")

#--------------------------------------
# ダックタイピング
#--------------------------------------

def fetch_and_downcase(ary, index)
  if str = ary[index]
    return str.downcase
  end
end
 
# ary = ["Boo", "Foo", "Woo"]
# p fetch_and_downcase(ary, 1)

hash = {0 => "Boo", 1 => "Foo", 3 => "Woo"}
p fetch_and_downcase(hash, 1)

