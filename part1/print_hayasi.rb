names = ["小林", "林", "高野", "盛岡"]
reg = /林/

names.each do |name|
  puts name if reg =~ name
end

