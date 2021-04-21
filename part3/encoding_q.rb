# encoding: utf-8
# ------------------------------------------------------------------------
# EUC-JPの文字列str_eucと、Shift_JISの文字列str_sjisを連結して、
# UTF-8の文字列を返すメソッド、to_utf8(str_euc, str_sjis)を定義してください
# ------------------------------------------------------------------------
str_euc = "abc".encode("EUC-JP")
str_sjis = "def".encode("Shift_JIS")
# p [str_euc.encoding, str_sjis.encoding]
  #=> [#<Encoding:EUC-JP>, #<Encoding:Shift_JIS>]

def to_utf8(str_euc = "", str_sjis = "")
  (str_euc + str_sjis).encode("utf-8")
end

str_utf8 = to_utf8(str_euc, str_sjis)
p [str_utf8, str_utf8.encoding]
  #=> ["abcdef", #<Encoding:UTF-8>]

# ------------------------------------------------------------------------
# Shift_JISでこんにちはと書かれたテキストファイルを作り、そのファイルを
# 読み込んでUTF-8で出力するスクリプトを作ってみてください。
# ------------------------------------------------------------------------
filename = "shift_jis_file.txt"

File.open(filename, "w:Shift_JIS") do |f|
  f.write("こんにちは") 
end

puts File.read(filename).encode("utf-8")
  #=> <82><b1><82><f1><82>ɂ<bf><82><cd>
p File.read(filename).encoding
  #=> #<Encoding:UTF-8>

File.delete(filename)

# ------------------------------------------------------------------------
# str.encode("Shift_JIS")とstr.encode("Windows-31J")を実行した時に
# 結果が異なるような、UTF-8の文字列strを見つけてください。
# ------------------------------------------------------------------------
str = "🥺"

def compatible_encode(s = "")
  s_sjis = s.encode(Encoding::Shift_JIS)
  s_w31j = s.encode(Encoding::Windows_31J)

  puts "#{s} : "
  [s_sjis, s_w31j].each do |s|
    printf("%16s: %s\n", s.encoding.name, s)
  end
end

compatible_encode("abcde")
compatible_encode("あいうえお")
compatible_encode("愛上大")
compatible_encode(str) #=> Error!!!






