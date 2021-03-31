f_name = ARGV[0]
file = File.open(f_name)
file.each_line do |line|
  print line
end
file.close

