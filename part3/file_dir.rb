# -----------------------------------------------------------------------
# File class
# File.rename(before, after)
# File.delete(file)
# File.unlink(file)
# File.stat(path)
# dev   ファイルシステムの装置番号
# ino   i-node番号
# mode    ファイル属性
# nlink   リンクの数
# uid     ファイル所有者のユーザID
# gid     ファイル所有者のグループID
# rdev    ファイルシステムのデバイスの種類
# size    ファイルサイズ
# blksize     ファイルシステムのブロックサイズ
# blocks      ファイルに割り当てられたブロック数
# atime       最終参照時刻
# mtime       最終修正時刻
# ctime       最終変更時刻
# File.ctime(path)
# File.mtime(path)
# File.atime(path)
# File.utime(atime, mtime, path)
# File.chmod(mode, path)
# File.chown(owner, group, path)
#
# Dir class
# Dir.pwd
# Dir.chdir(directory_path)
# Dir.open(path)
# Dir.close
# dir.read
# Dir.glob
# *     全てのファイル名を取得
# .*    全ての隠しファイル名を取得
# %w(*.html, *.htm)   拡張子.html, .htmのファイル名を取得
# */*.html    サブディレクトリにある拡張子.htmlのファイル名を取得
# Dir.mkdir(path)
# Dir.rmdir(path)
#
# FileTest modules
# exist?(path)          pathが存在すればtrue
# file?(path)           pathがファイルであればtrue
# directory?(path)      pathがディレクトリであればtrue
# owned?(path)          pathの所有ユーザと実行ユーザが同じであればtrue
# grpowned?(path)       pathの所有グループと実行グループが同じであればtrue
# readable?(path)       読み込み可能ならtrue
# writable?(path)       書き込み可能ならtrue
# executeable?(path)    実行可能ならtrue
# size(path)            pathのサイズを返す。
# size?(path)           sizeが0以上ならtrue
# zero?(path)           sizeが0ならtrue
# File.basename(path[, suffix])       pathの後ろの部分を返す。
# File.dirname(path)    pathの最初の部分を返す。
# File.extname(path)    pathのbasenameの拡張子を返す
# File.split(path)
# File.join(name1[, name2, ...])
# File.expand_path(path[, default_dir])     
#   相対パス名pathをディレクトリ名default_dirに基づいて絶対パス名に変換する
#   また、「~ユーザ名」でユーザのホームディレクトリを取得する。
#
# Find Library
# Find.find(dir) { |path| ... }
#   dir以下の全てのファイルをpathに渡す。
# Find.prune
#   現在検索中のディレクトリ以下のパスを飛ばす
#
# tempfile Library
# 処理の途中でファイルが必要となった時に使う。
# 処理が終わると自動的に削除される
#
# fileutils class
# FileUtils.cp(from, to)
# FileUtils.cp_r(from, to)
# FileUtils.mv(before, after)
# FileUtils.compare(from, to)     ファイルの内容を比較。
# fileutils.install(from, to[, option])     ファイルをコピー。
#   ただし、toのファイルの内容がfromと一致していたらコピーしない
#
# -----------------------------------------------------------------------
filename = "hoge.txt"
dirname = "hoge"

# -----------------------------------------------------------------------
# traverse
# -----------------------------------------------------------------------
Dir::mkdir(dirname) rescue puts "error: #{dirname} exists."
File::open("#{dirname}/#{filename}", "w").close 

# pathのディレクトリ下のファイルを表示
# def traverse(path)
#   path = '.' if path.nil?
#   # pathがフォルダの時
#   if File.directory?(path)
#     dir = Dir.open(path)
#     while name = dir.read
#       next if name == "."   # カレントディレクトリをスキップ
#       next if name == ".."  # 親ディレクトリをスキップ
#       traverse(path + "/" + name)
#     end
#     dir.close
#   end
#   # pathがファイルの時と、別の場合
#   if File.file?(path)
#     puts path
#   else
#     puts "unknown path: #{path}"
#   end
# end

def traverse(path)
  path = '.' if path.nil?
  reg = ["#{path}/**/*", "#{path}/**/.*"]

  Dir.glob(reg).each do |name| 
    puts name unless File.directory?(name)
  end
end

traverse(dirname)

File.delete("#{dirname}/#{filename}")
Dir.rmdir(dirname)

# -----------------------------------------------------------------------
# etc class
# -----------------------------------------------------------------------
require 'etc'

st = File.stat($:[0])
pw = Etc.getpwuid(st.uid)
p pw.name
gr = Etc.getgrgid(st.gid)
p gr.name

# -----------------------------------------------------------------------
# File::Stat
# -----------------------------------------------------------------------
File.open(filename, "w").close 
File.utime(Time.now+(60*60*24), Time.now+(60*60*24), filename)
st = File.stat(filename)
p st.ctime
p st.mtime
p st.atime

File.chmod(st.mode | 0111, filename)
printf("%o\n", st.mode)
  #=> プログラム終了後に変更される。

# -----------------------------------------------------------------------
# control filename
# -----------------------------------------------------------------------
filename = "#{Dir.pwd}/#{filename}"
p File.basename(filename, ".txt")   #=> "hoge.txt"
p File.dirname(filename)    #=> "/Users/kaz/Documents/ruby/part3"
p File.extname(filename)    #=> .txt
p File.split(filename)
  #=> ["/Users/kaz/Documents/ruby/part3", "hoge.txt"]
p File.join(Dir.pwd, "hoge")    #=> "/Users/kaz/Documents/ruby/part3/hoge"
p File.expand_path("bar")     #=> "/Users/kaz/Documents/ruby/part3/bar"
p File.expand_path("~kaz/bar")    #=> "/Users/kaz/bar"

File.delete(filename)
# -----------------------------------------------------------------------
# find Library
# -----------------------------------------------------------------------
require 'find'

IGNORES = [ %r(^\.), %r(^\.svn$), %r(^\.git$)]

# top以下のディレクトリを出力
def listdir(top)
  Find.find(top) do |path|
    if FileTest.directory?(path)
      dir, base = File.split(path)
      IGNORES.each do |re| 
        Find.prune if re =~ base
      end
      puts path
    end
  end
end

listdir("/Users/kaz/Documents/ruby")

# -----------------------------------------------------------------------
# tempfile Library
# -----------------------------------------------------------------------
require 'tempfile'

Tempfile.open(filename) do |f|
  p f.path
end

