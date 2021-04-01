# ----------------------------------------------------------------------
# Hash.new("")
# Hash["a"] = "b"
# { "a" => "b" }
# { a: "b" }
# Hash[*array]
#
# デフォルト値を指定
# Hash.default = "hoge" 
#
# 値の代入
# Hash[key] << value
# Hash.store(key, value)
#
# 初期化
# Hash.clear
#
# trueのみを除外する
# Hash.select { Bool }
# ----------------------------------------------------------------------

h = Hash.new
h.store("R", "Ruby")
p h.fetch("R")
p h.fetch("hoge", "(undef)")
p h.fetch("hoge") { String.new }

h = { "a" => "b", "c" => "d" }
p [h.keys, h.values, h.to_a]

h = Hash.new { |hash, key| hash[key] = key.upcase }
h["a"]
p [h["a"], h["x"], h["y"]]

h = { "a" => "b", "c" => "d" }
# keyを調べる
p [h.key?("a"), h.has_key?("a")]      #=> [true, true]
p [h.include?("z"), h.member?("z")]   #=> [false, false]
# 値を調べる
p [h.value?("b"), h.has_value?("z")]      #=> [true, false]
# 大きさを調べる
p [h.length, h.empty?]      #=> [2, false]
# 削除する
h.delete("c")
p h["c"]      #=> nil
p h.delete("P") { |key| "no #{key}." }    #=> "no P."
h = { R: "Ruby", P: "Perl" }
p h.delete_if { |key, value| key == :P }      #=> {:R=>"Ruby"}
p h.reject! { |key, value| key == :L }      #=> nil
# 初期化する
h.clear
p h     #=> {}
# 2つのハッシュを合わせる
p ({ "a"=>"z" }.merge({ "b"=>"x" }))    #=> {"a"=>"z", "b"=>"x"}







