# -----------------------------------------------------------------------
# 変数$:にはRubyのライブラリのディレクトリやファイルが置かれています。
# Rubyが利用できるライブラリのファイルを出力するprint_librariesを定義
# してください。
# -----------------------------------------------------------------------
def print_libraries
  $:.each do |path| 
    next unless FileTest.directory?(path)
    Dir.open(path) do |dir| 
      dir.each do |name| 
        puts name if name =~ %r(\.rb$)
      end
    end
  end
end

print_libraries

# -----------------------------------------------------------------------
# Unixのduコマンドのように、ファイルの大きさとディレクトリの大きさを
# 再起的に掘り下げて出力するメソッドduを定義してください。
# du(調べるディレクトリ)
# -----------------------------------------------------------------------
require 'find'
def du(path = '')
  path = '.' if path.empty?
  result = 0

  if FileTest.directory?(path)
    Find.find(path) do |f|
      if FileTest.file?(f)
        result += File.size(f)
      end
    end
    puts "#{result}\t#{path}"
    return result
  elsif FileTest.file?(path)
    puts "#{path} is not directory!"
  else 
    puts "unknown path #{path}"
  end
end

du("")

