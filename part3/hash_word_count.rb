# ----------------------------------------------------------------------
# Part3/Hashクラス
# 単語数を数えるプログラム
# ----------------------------------------------------------------------
count = Hash.new(0)

# word count!!!
File.open(ARGV[0]) do |f| 
  f.each_line do |line| 
    words = line.split
    words.each do |word| 
      count[word] += 1
    end
  end
end

# output!!!
count.sort{ |a, b| a[1] <=> b[1] }
count.each { |key, value| print "#{key}: #{value}\n" } 

