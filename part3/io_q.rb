# ------------------------------------------------------------------------
# テキストファイルからデータを読み込み、行数、単語数、文字数を数える
# プログラムを作成してください
# ------------------------------------------------------------------------
filename = "hoge.txt"
text = <<-EOB
i am kaz.
mice to meet you.
EOB
File.open(filename, "w") do |io|
  io.write(text)
end

line_count = word_count = char_count = 0
File.open(filename, "r") do |io| 
  io.each_line { line_count += 1 }
  io.rewind
  io.each_line { |line| word_count += line.split(' ').length }
  io.rewind
  io.each_char { char_count += 1 }
end

puts File.read(filename)
puts "line: #{line_count}, word: #{word_count}, char: #{char_count}."

# ------------------------------------------------------------------------
# テキストファイルからデータを読み込み、行を逆順に、最初の行のみ残して削除、
# 最後の行のみ残して削除するスクリプトを作成してください。
# ------------------------------------------------------------------------
File.open(filename, "w") do |io| 
  10.times { |i| io.write("#{i+1}\n") }
end

reverse_text = IO.readlines(filename).reverse
File.open(filename, "w") do |io| 
  io.write(reverse_text.first)
  io.write(reverse_text.last)
end

puts File.read(filename)

# ------------------------------------------------------------------------
# tailコマンドと似たことができるメソッドtailを定義してください。
# tail(行数、ファイル名)
# ------------------------------------------------------------------------
File.open(filename, "w") do |io| 
  100.times { |i| io.write("#{i+1}\n") }
end

def tail(line_num = 10, filename)
  text = IO.readlines(filename)
  range = Range.new(text.length-line_num-1, text.length-1)
  puts text[range].join
end

tail(5, filename)

# ------------------------------------------------------------------------
# Fileオブジェクトへの出力が何バイトまでバッファリングされるか調べる
# スクリプトを作成してください。
# ------------------------------------------------------------------------
buf_count = 0
File.open(filename, "w") do |io| 
  while buf_count < 10000
    buf_count += 1
    io.write("a")
    size = File.size(filename)
    puts "bufferSize: #{buf_count}" if buf_count == size
  end
end


