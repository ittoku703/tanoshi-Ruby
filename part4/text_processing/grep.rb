# $`    マッチした部分の前の文字列を取得
# $'    マッチした部分の後も文字列を取得
pattern = Regexp.new(ARGV[0])
filename = ARGV[1]
len = ARGV[2].to_i

count = 0
File.open(filename) do |f|
  f.each_line do |line|
    if pattern =~ line
      line.scan(pattern) do |s|
        pre, post = $`, $'
        puts "#{pre[-len,len]}<<#{s}>>#{post[0,len]}"
        count += 1
      end
    end
  end
end
puts "count: #{count}"

# カウント数だけを出力
# count = 0
# File.read(filename).scan(pattern) do |s|
#   count += 1
# end
# puts "count: #{count}"

