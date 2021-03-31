puts "breakの例: "
i = 0
['Perl', 'Python', 'Ruby', 'Scheme'].each do |lang|
  i += 1
  break if i == 3
  p [i, lang]
end

puts "nextの例: "
i = 0
['Perl', 'Python', 'Ruby', 'Scheme'].each do |lang|
  i += 1
  next if i == 3
  p [i, lang]
end

