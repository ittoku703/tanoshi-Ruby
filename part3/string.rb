# frozen-string-literal: true
# ----String----------------------------------------------------------------
# %q, %Qでエスケープ文字を表現できる。%q ', %Q \'
# ヒアドキュメントは複数行の文字列を表現できる
# EOB(End Of Block), EOF(End Of File)がよく使われる。
# <<- インデントを整える、<<~ インデントを揃える
# ` `はコマンドを使うことができる
# printfは出力を返すが、sprintfは文字列で返す
# formatとsprintfは同じ
# s[n] = str
# s[n..m] = str
# s[n, len] = str
# s.slice(n)
# s.slice(n..m)
# s.slice(n, len)
#
# s.concat(string)
# s.delete(string)
# s.reverse
# 
# 文字列の整形
# String#strip
# String#upcase
# String#downcase
# String#swapcase
# String#capitalize
#
# 文字列の置き換え
# String#tr(before, after)
#
# 文字コードの変換
# String#encode(encode)
# String#encoding
#
# Unicode出力(10進数)
# String.codepoint -> enumerator
#
# nfkライブラリ
# nfk(Network Knaji code conversion Filter)は半角カナを全角かなに変換する
# ような場合に使用する。
# --------------------------------------------------------------------------
s1 = %q('hoge')
s2 = %Q("hoge")
p [s1, s2]      #=> ["'hoge'", "'hoge'"]
puts <<-EOB
<<-はEOBを揃えて表示
することができる。
EOB
puts <<~EOF
  <<~はネスとした状態でも
  正しく文字列を表現できる。
EOF
puts `ls -l /etc/hosts`  
  #=> -rw-r--r--  1 root  wheel  365  1 14 23:41 /etc/hosts

n = 65535
printf("10: %d, 16: %x\n", n, n)      # ----|
puts sprintf("10: %d, 16: %x\n", n, n)  # --|
puts format("10: %d, 16: %x\n", n, n)   # --|----同じ

p "just another ruby hacker,".length    #=> 25(.sizeも同じ)
p 'オブジェクト指向プログラミング言語'.bytesize     #=> 51
p "".empty?     #=> true

s = "さかもと:いっとく:1234/56/78:0123-456-7890"
p s.split(/:/) 
  #=> ["さかもと", "いっとく", "1234/56/78", "0123-456-7890"]

s = "abcde"
cho = [s.chop, s.chomp]
p cho
s = "abcde\n"
cho = [s.chop, s.chomp]
p cho

s = "すもももももももものうち"
p [s.index("もも"), s.rindex("もも"), s.include?("もも")]   #=> [1, 7, true]

s = "abcde"
p "こんにちはRuby".byteslice(15, 4)

s = "あ\nえ\nお\n"
p s.each_line.collect { |line| line.chomp * 3 }   
  #=> ["あああ", "えええ", "おおお"]
s = "abcde"
p s.each_byte.collect { |byte| -byte } 
  #=> [-97, -98, -99, -100, -101]

s = "AA\nBB\nCC\n"
p s.each_line.class   #=> Enumerator
p s.each_line.map { |line| line.chop }
  #=> ["AA", "BB", "CC"]
p s.each_byte.reject { |c| c == 0x0a }
  #=> [65, 65, 66, 66, 67, 67] 0x0aは改行

p "Thank you. ".strip   #=> "Thank you."

s = "My name is kaz."
p [s.upcase, s.downcase, s.swapcase, s.capitalize, s.tr("kaz", "bar")]
  #=> ["MY NAME IS KAZ.", "my name is kaz.", "mY NAME IS KAZ.", "My name is kaz.", "My name is bar."]

utf8_s = "日本語EUCの文字列"
p utf8_s.encoding
shift_jis_s = utf8_s.encode("Shift_JIS")
p shift_jis_s.encoding

# -------------------------------------------------------------------------
# nkf
# -------------------------------------------------------------------------
require 'nkf'

s = "あアぁｱヴバパｳﾞ01０１abABａｂＡＢ"
# 原文
p s
# -w 半角を全角にする
p NKF.nkf("-w", s)
# -x 半角をそのままにする
p NKF.nkf("-xw", s)
# ひらがなをカタカナに変換
p NKF.nkf("-h1 -w", s)
# カタカナをひらがなに変換
p NKF.nkf("-h2 -w", s)

s = "育ち盛り　弁当"
# 全角空白を半角空白に変換
p NKF.nkf("-Z1 -w", s)
# 文字コードをsjisに変換
p NKF.nkf("-s", s)

s = "〜鎌倉幕府〜"
# ic 文字コード、oc 出力コード、変換できなければ下駄線に置き換える
p NKF.nkf("--ic=UTF-8 --oc=CP932 --fb-subchar=0x3013", s)
# sjisからUTF-8に変換
p s.encode("Shift_JIS", "UTF-8")

s = "Test🥺"
s2 = NKF.nkf("--ic=UTF-8 --oc=CP932 --fb-subchar=0x3013", s)
p s2.encode("UTF-8", "Shift_JIS")
# -------------------------------------------------------------------------
s = "Ruby"
p s.upcase!     #=> FrozenError 

