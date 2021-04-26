# -----------------------------------------------------------------------
# Time.new
# Time.now
# Time.mktime(year[, month[, day[, hour[, min[, sec[, usec]]]]]])
# Time.at(epoch)
#   1970/01/01からepoch秒経過したTimeオブジェクトを返す。
# パースする
# Time.parse
# Time.strptime(str, format)
#
# メソッド
# year
# month
# day
# hour
# min
# sec
# usec      マイクロ秒
# nsec      ナノ秒
# to_i      1970/01/01からの秒数
# wday      日曜日から何日目か
# mday      月の何日目か
# yday      年の何日目か
# zone      タイムゾーン
# utc_offset    UTCとの時差
#
# フォーマット
# t.to_s
# t.strftime(format)
# t.rfc2822
#   電子メールのヘッダ情報に含まれるDate:フィールドの形式でフォーマット
#   RFC(Request For Comments), RFC2822(電子メールの形式が規定)
# t.iso8601
#   ISO 8601という国際標準に則った形式でフォーマット
#
# ローカルタイム
# t.utc
# t.localtime
#
# Date classは時刻を持たない日付を操作するためのクラス
# Time classとメソッドはほぼ同じ
# Date.new(2021, 4, 26)
#
# -----------------------------------------------------------------------
t1 = Time.now
t2 = Time.at(Time.now.to_i + 999)
p [t1 < t2, t2 - t1]    #=> [true, 998.......]

p Time.now.to_s     #=> "2021-04-26 00:29:49 +0900"
p Time.now.strftime("%Y/%m/%d %X %z")     
  #=> "2021/04/26 00:39:16 +0900"

require 'time'
p Time.now.rfc2822    #=> "Mon, 26 Apr 2021 00:48:00 +0900"
p Time.now.iso8601    #=> "2021-04-26T00:48:00+09:00"

require 'time'
p Time.parse("Fri Sep 25 02:45:15 UTC 2015") #=> 2015-09-25 02:45:15 UTC
p Time.parse("H8.07.03") #=> 1996-07-03 00:00:00 +0900

p Time.strptime("平成8年7月3日", "平成%Y年%m月%d日") { |y| y + 1988 }
  #=> 1996-07-03 00:00:00 +0900
p Time.strptime("9/1/2015", "%m/%d/%Y")
  #=> 2015-09-01 00:00:00 +0900

require 'date'
d = Date.today
puts Date.new(2021, 1, 1) - Date.new(2020, 1, 1) #=> 366/1
puts d + 1, d >> 1, d << 1
#=> 2021-04-27
#=> 2021-05-26
#=> 2021-03-26

