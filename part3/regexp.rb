# ----------------------------------------------------------------------
# 正規表現は実際に触って覚えるのが一番！
# 宣言
# Regexp.new
# %r()
#
# Regexp =~ String
# [ABC]   A, B, C
# [a-z0-9]    a, 8, x
# A.C   ABC, ADC, AEC 
# abc\s   abc def, abc\tDEF, abc\ndef
# \d 0から9、\w 英数字、\A 文字列の先頭、\z 文字列の末尾
# * 0回以上の繰り返し
# A*C   AhogeC, AbarC, AC
# + 1回以上の繰り返し
# A+C     AAC, ACC, AAACCC
# ? 0または1回以上の繰り返し
# A?C     ABC, AZC, AhogeC, AC
# n回の繰り返し
# A{5}C     AAAAAC
# n~m回の繰り返し
# A{2,10}C    AAAC, AAAAAC, AAAAAAAAAAC
# 0回以上の繰り返しのうち最短の部分
# A*?C      AhogeC, ABC, AC
# 1回以上の繰り返しのうち最短の部分
# A+?C      AAC, ACC, AC
# ()は文字列単位で表現できる
# ^(ABC)*$      ABCABC, ABCABCABC, ABC
# | はどちらか1つに当てはまるものにマッチする。
# ^(ABC|DEF)*$      ABC, DEF, ABCABC, DEFDEF
# オプション
# /i(Regexp::IGNORECASE) 大文字小文字を無視、
# /x(Regexp::EXTENDED) 正規表現内の空白と、#の後ろ（コメント）を無視する
# /m(Regexp::MULTILINE) . が改行文字にもマッチする
# キャプチャ
# ()で囲まれた部分にマッチした文字列を、$1, $2...に格納する
# キャプチャが必要ない場合は、(?:)を使う。
# $` マッチした部分より前の文字列
# $& マッチした部分の文字列
# $' マッチした部分より後の文字列
# 正規表現を使うメソッド
# String.sub(pattern, replace) 最初にマッチした部分を置き換え
# String.gsub(pattern, replace) マッチした全ての部分を置き換え
# String.scan(pattern) マッチした部分を取り出す（置き換えない）
# ----------------------------------------------------------------------
re1 = Regexp.new("abc*def")
re2 = Regexp.new(Regexp.quote("abc*def"))
p [(re1 =~ "abc*def"), (re2 =~ "abc*def")]      #=> [nil, 0]

# キャプチャ
/(.)(.)(.)/ =~ "abc"
p [$1, $2, $3]
/C./ =~ "ABCDEF"
p [$`, $&, $']      #=> ["AB", "CD", "EF"]

# subメソッドとgsubメソッド
s = "abc  g\thi"
p s.sub(/\s+/, ' ')     #=> "abc g\thi"
p s.gsub(/\s+/, ' ')      #=> "abc g hi"

s = "abracatabra"
substr = s.sub(/.a/) do |matched| 
  '<'+matched.upcase+'>'
end
gsubstr = s.gsub(/.a/) do |matched| 
  '<'+matched.upcase+'>'
end
p [substr, gsubstr]     #=> ["ab<RA>catabra", "ab<RA><CA><TA>b<RA>"]

# scanメソッド
p s.scan(/.a/)      #=> ["ra", "ca", "ta", "ra"]
p s.scan(/(.)(a)/)  #=> [["r", "a"], ["c", "a"], ["t", "a"], ["r", "a"]]

# URLを正規表現する
s = "https://www.example.com/foo/?name=bar#baz"
url_reg = %r|^(([^:/?#]+):)?(//([^/?#]*))?([^?#]*)(\?([^#]*))?(#(.*))?|
s =~ url_reg
p [$1, $2, $3, $4, $5, $6, $7, $8, $9]       #=> ["https:", "https", "//www.example.com", "www.example.com", "/foo/", "?name=bar" , "name=bar", "#baz", "baz"]

