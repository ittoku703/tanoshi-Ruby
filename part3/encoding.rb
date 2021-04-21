# -----------------------------------------------------------------------
# encoding: EUC-JP
# 擬似変数
# __ENCODING__ 現在のスクリプトエンコーディング
# マジックコメントはスクリプトエンコーディングを指定するときに使われる。
# Unixの !#/bin/bash のようなもの
# encoding: utf-8
# ASCII-8BITはバイナリデータ、バイト列を表現するためのエンコーディング。
# 正規表現を行うときはエンコードを揃える必要がある
#
# \u{ ... }でコードポイントを記述できる。
#
# Encoding.list
# Encoding.name_list
#   エンコード一覧を返す
# Encoding.compatible?(s1, s2)
#   2つの文字列の互換性をチェックする。
# Encoding.default_external
#   デフォルトの外部エンコーディング(入出力)を返す
# Encoding.default_internal
#   デフォルトの内部エンコーディング(プログラム)を返す
# Encoding.find(name)
#   エンコーディング名nameに対応するEncodingオブジェクトを返す。
#
# enc.name
# enc.names
#   encのエンコーディング名を返す
# enc.force_encoding(name)
#   encのエンコードをnameのエンコードに強制変換する
# enc.valid_encoding?
#   encのエンコーディングが適切かどうか判定する
# -----------------------------------------------------------------------
p __ENCODING__

"あいうえお".each_codepoint { |cp| $stdout << '\u' << cp.to_s(16) }
  #=> \u3042\u3044\u3046\u3048\u304a
puts

puts "\u{3042 3044 3046 3048 304a}"   #=> あいうえお

s1 = "こんにちは"
p s1.encoding         #=> #<Encoding:UTF-8>
s2 = s1.encode("EUC-JP")
p s2.encoding         #=> #<Encoding:EUC-JP>

# 互換性をチェック(連結できるかどうか)
p Encoding.compatible?("AB".encode("EUC-JP"), "あ".encode("UTF-8"))
  #=> #<Encoding:UTF-8>
p Encoding.compatible?("あ".encode("EUC-JP"), "あ".encode("UTF-8"))
  #=> nil

p [Encoding.default_external, Encoding.default_internal]
  #=> [#<Encoding:UTF-8>, nil]

p Encoding.find("shift_jis")
  #=> #<Encoding:Shift_JIS>

p Encoding.find("shift_jis").name #=> "Shift_JIS"
p Encoding.find("ASCII-8BIT").names #=> ["ASCII-8BIT", "BINARY"]

s = [127,0,0,1].pack("C4")
p [s, s.encoding] #=> ["\x7F\x00\x00\x01", #<Encoding:ASCII-8BIT>]

s = "こんにちは"
s.force_encoding("Windows-31J") if s.valid_encoding?
p s.encoding

