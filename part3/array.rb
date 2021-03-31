# ----Arrayクラス---------------------------------------------------------
# 配列の先頭、末尾を操作するメソッド
# Array#unshift(*obj) -> self
# Array#push(*obj) -> self
#
# 要素を取り出す
# Array#shift -> object | nil
# Array#pop -> object | nil
#
# 要素を参照する
# Array#first(n) -> Array
# Array#last(n) -> Array
#
# 配列を連結
# Array#concat(*other_arrays) -> self
#
# 配列からnilを取り除く。
# Array#compact -> Array
#
# valと等しい配列を削除
# Array#delete(val) -> object | nil
#
# posにあるインデックスの要素を削除
# Array#delete_at(pos) -> object | nil
#
# ブロック内でtrueの物を削除する。
# Array#delete_if -> Enumerator
#
# posからlenまでのindexを削除
# Array#slice(pos, len) -> Array | nil
#
# 同じ値を削除する
# Array#uniq -> Array
#
# ブロック内で要素を判定する
# Array#collect -> Enumerator
#
# rangeの要素をブロックで削除する
# Array#fill(range) {|index| ... } -> self
#
# ブロックで判定してソートする
# Array#sort_by! -> Enumerator
# ------------------------------------------------------------------------
# Array.new
a = Array.new(5, 0)   # [0, 0, 0, 0, 0]

# シンボルの配列
lang = %i(Ruby Perl Python Scheme Pike REBOL)

# 要素の取り出し
alpha = %w(a b c d e f g)
p alpha[2, 3]   #=> ["c", "d", "e"]
p alpha.values_at(1, 3, 5)    #=> ["b", "d", "f"]

# 配列の演算
ary1, ary2 = %w(a b c), %w(b c d)
p [(ary1 & ary2), (ary1 | ary2)]    #=> [[b, c], [a, b, c, d]]
p ary1 - ary2   #=> ["a"]

# 配列を連結する（破壊的メソッド）
p lang.concat(%w(C C++ C-shape))

# ------------------------------------------------------------------------
# 破壊的メソッドとfreezeとdup
# ------------------------------------------------------------------------
a = %w(a b c d)
b = a
b.pop     # bをpopしているのに
p [a, b]  # aとbが同じ値になる
# ------------------------------------------------------------------------
a = %w(a b c d)
# a.freeze    # 変数aの内容が破壊的な操作で変更されるとErrorとなる
b = a.dup
a.pop     # 複製したaをbがコピーしているので
p [a, b]  # 値が違う
# ------------------------------------------------------------------------
a = [1, nil, nil, 2, 3, 4, nil, 5]
p a.compact!
a.delete(1)
p a   #=> [2, 3, 4, 5]
a.delete_at(2)
p a   #=> [2, 3, 5]
# ------------------------------------------------------------------------
a = [1, 2, 3, 4, 5]
p a.delete_if { |i| i > 3}      # [1, 2, 3]
# p a.reject! { |i| i > 3 }     # 同じ
p [a.slice!(0), a]    #=> [1, [2, 3]]
# ------------------------------------------------------------------------
a = [1, 2, 2, 3, 4, 5, 4, 3]
a.uniq!
p a     #=> [1, 2, 3, 4, 5]
a.shift     
a.pop
p a     #=> [2, 3, 4]
# ------------------------------------------------------------------------
a = [1, 2, 3, 4, 5]
p a.collect! {|item| item * 2 }     #=> [2, 4, 6, 8, 10]
# a = [1, 2, 3, 4, 5]
# p a.map! {|item| item * 2 }     # 同じ
# ------------------------------------------------------------------------
p [1, 2, 3, 4, 5].fill(0, 2, 3)     #=> [1, 2, 0, 0, 0]
p [1, 2, [3, 4, 5]].flatten     #=> [1, 2, 3, 4, 5]
p [1, 2, 3, 4, 5].reverse!      #=> [5, 4, 3, 2, 1]
p [4, 5, 2, 3, 1].sort!     #=> [1, 2, 3, 4, 5]
p [4, 5, 2, 3, 1].sort_by { |i| -i }     #=> [5, 4, 3, 2, 1]
# ------------------------------------------------------------------------
%w(a b c d).each_with_index do |elem, i| 
    print "#{i+1}: #{elem}, "
end
puts      #=> 1: a, 2: b, 3: c, 4: d, 
# ------------------------------------------------------------------------
a = Array.new(3, [0, 0, 0])
a[0][1] = 2 
p a     #=> [[0, 2, 0], [0, 2, 0], [0, 2, 0]]
a = Array.new(3) { [0, 0, 0] }
a[0][1] = 2
p a     #=> [[0, 2, 0], [0, 0, 0], [0, 0, 0]]
a = Array.new(5) { |i| i + 1 }
p a     #=> [1, 2, 3, 4, 5]
# ------------------------------------------------------------------------
ary1 = Array.new(5) { |i| (i+1) * 1 }
ary2 = Array.new(5) { |i| (i+1) * 10 }
ary3 = Array.new(5) { |i| (i+1) * 100 }
# ------------------------------------------------------------------------
i, result = 0, []
while i < ary1.length
    result << ary1[i] + ary2[i] + ary3[i]
    i += 1
end
p result

i, result = 0, []
ary1.zip(ary2, ary3) do |a, b, c| 
    result << a + b + c
end
p result

