# -----------------------------------------------------------------------
# Rubyの誕生日は1993年2月24日だそうです。そこで、今日Rubyが何歳であるか
# 計算してください
# -----------------------------------------------------------------------
require 'date'
def ruby_age
  ruby_birth = Date.new(1993, 2, 24)
  puts "Ruby is #{Date.today.year - ruby_birth.year} age!!"
end

ruby_age

# -----------------------------------------------------------------------
# "2015年9月25日午後8時17分50秒"といった文字列をTimeオブジェクトで返す
# メソッドjparsedateを定義してください。
# -----------------------------------------------------------------------
require 'time'
def jparsedate(s = '')
  return nil if s.empty?
  s = s.sub(/午後/, "AM").sub(/午後/, "PM")
  Time.strptime(s, "%Y年%m月%d日%p%H時%M分%S秒")
end

puts jparsedate("2015年9月25日午後8時17分50秒")

# -----------------------------------------------------------------------
# コマンドls -tのようにファイルの新しい時刻順に並べる
# メソッドls_tを定義してください
# -----------------------------------------------------------------------
def ls_t(path = '')
  path = '.' if path.empty?
  entries = Dir.entries(path)
  entries.reject! { |name| %r(^\.) =~ name }
  mtimes = Hash.new 
  entries.sort_by! do |name|
    mtimes[name] = File.mtime(File.join(path, name))
  end

  entries.each do |name|
    printf("%-40s %s\n", name, mtimes[name])
  end
rescue => ex
  puts ex.message
end

ls_t('')

# -----------------------------------------------------------------------
# Dateクラスを使って今月の1日と月末の日付と曜日を求め、カレンダーを表示
# させてください
# -----------------------------------------------------------------------
#     MONTH_NAME YEAR
# Su Mo Tu We Th Fr Sa
#              1  2  3
#  4  5  6  7  8  9 10
# 11 12 13 14 15 16 17
# 18 19 20 21 22 23 24
# 25 26 27 28 29 30
require 'date'
def calendar(date)
  # 引数はDateクラスのみ適用
  date = Date.today unless date.class == Date
  # 見出し
  calendar_header = " #{Date::MONTHNAMES[date.month]} #{date.year}\n"
  # 曜日
  calendar_week = Date::DAYNAMES.collect do |day|
    sprintf("%.2s ", day)
  end
    .join + "\n"
  # 日数
  first_date = Date.new(date.year, date.month, 1)
  last_date = Date.new(date.year, date.month, -1)
  # Rangeで月初と月終わりをEnumする
  day = (first_date..last_date).collect do |date|
    date.wday == 6 ? sprintf("%2d\n", date.day) : sprintf("%2d ", date.day)
  end
    .join
  calendar_day = '   ' * first_date.wday + day + "\n"
  # 最後に出力
  puts calendar_header + calendar_week + calendar_day
end

calendar(Date.new(1996, 7, 3))
