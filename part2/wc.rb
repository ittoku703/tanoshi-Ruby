l_total = 0       # 行数の合計
w_total = 0       # 単語数の合計
c_total = 0       # 文字数の合計
ARGV.each do |file|
  begin
    input = File.open(file)
    l = 0       # 行数
    w = 0       # 単語数
    c = 0       # 文字数
    input.each_line do |line|
      l += 1
      c += line.size
      line.sub(/^\s+/, "")
      ary = line.split(/\s+/)
      w += ary.size
    end
    input.close
    printf("%8d %8d %8d %s\n", l, w, c, file)
    l_total += l
    w_total += w
    c_total += c
  rescue => ex
    print ex.message, "\n"
  end
end

printf("%8d %8d %8d %s\n", l_total, w_total, c_total, "total")

