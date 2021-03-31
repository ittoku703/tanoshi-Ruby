def grep(pattern, f_name)
  file = File.open(f_name)
  file.each_line do |line| 
    print line if pattern =~ line
  end
  
  file.close
end

