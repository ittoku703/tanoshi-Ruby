# -----------------------------------------------------------------------
# 標準入力: 組み込み変数STDINに割り当てられ、グローバル変数$stdinから
# 参照される
# 標準出力: 組み込み変数STDOUTに割り当てられ、グローバル変数$stdoutから
# 参照される
# 標準エラー出力: 組み込み変数STDERRに割り当てられ、
# グローバル変数$stderrから参照される
# ttyはteletypeの略
# 
# io.tty? 
# File.open(file[, mode[, perm]][, opt])
# mode
# "r" : 読み込み専用
# "r+": 読み込み書き込み用
# "w" : 書き込み専用。ファイルがなければ新規作成。ある場合ファイルを空にする
# "w+": 読み込み、書き込み用
# "a" : 追加書き込み専用。ファイルがなければ新規作成
# "a+": 読み込み追加書き込み用。ファイルがなければ新規作成
# opt
# :mode   引数modeと同じ
# :extern_encoding    外部エンコーディングを使用する。
# :internal_encoding    内部エンコーディングを使用する。
# :encoding   外部、内部エンコーディングを使用する。
# :textmode   trueの時、モードにtを指定する
# :binmode    trueの時、モードにbを指定する
# :autoclose    falseのとき、FileオブジェクトがGCで回収される際にファイルを閉じない。
# file.close
# また、File.openメソッドにブロックを渡すと、自動的にファイルを閉じる。
# file.closed?
# File.read(file[, length[, offset])
# File.binread(file[, length[, offset])
# offsetには先頭何バイト目から読み込むかを指定
# File.write(file, data[, offset])
# File.binwrite(file, data[, offset])
# 入力操作
# io.gets(rs)   
# # io.each(rs)
# io.each_line(rs)
# io.readlines(rs)
# IOオブジェクトからデータを一行読み込む。
# io.eof?
# io.lineno
# io.lineno=(number)
# 現在の行数を出力
# io.each_char    一文字
# io.each_byte    1バイト
# io.getc         一文字
# io.ungetc(ch)   ch文字戻す
# io.getbyte      1バイト
# io.ungetbyte(byte)    byteバイト戻す
# io.read(size)   sizeぶん読み込む
# 出力操作
# io.puts(s0, s1, ...)
# io.putc(ch)
# io.printf(fmt, arg0, arg1, ...)
# io.write(s)   
# io << s
# ファイルポインタ
# io.pos, io.pos=(position)
# io.seek(offset, whence)
# whence
# IO::SEEK_SET    offsetの位置にファイルポインタを移動
# IO::SEEK_CUR    offsetの位置からファイルポインタを移動
# IO::SEEK_END    ファイル末尾からoffsetぶん移動
# io.rewind     ファイルポインタを先頭に、linenoもゼロにする
# io.truncate(size)   ファイルの長さをsizeにする
#
# 改行文字の変換を行う。テキストモード
# 改行文字の変換を行わない。バイナリモード
# io.binmode    バイナリモードに変更（テキストモードには戻せない）
# バッファリング
# io.flush    バッファにたまっているデータを吐き出す。
# io.sync     flushを宣言できる
#
# io.set_encoding(encoding)
#   "外部エンコーディング:内部エンコーディング"の形式でエンコードを指定する
# -----------------------------------------------------------------------
FILENAME = "hoge.txt"
# リダイレクトすると、$stdioはファイルを書き込み、$stderrはコンソールに出力する
$stdout.puts "stdout output!!!"
$stderr.puts "stderr output!!!"

# 標準入力がコンソールかどうかの判定
p $stdin.tty?
  #=> terminal true, pipe false, irb true, vim true

# -----------------------------------------------------------------------
# ファイル入出力
# -----------------------------------------------------------------------
# File.write(FILENAME, "Hello World!\n")
# p File.read(FILENAME)

# -----------------------------------------------------------------------
# 基本的な入出力
# -----------------------------------------------------------------------
# while line = $stdin.gets
#   line.chomp!
# end
# p io.eof?   #=> true
# $stdin.each_line do |line|
#   printf("%3d: %s", $stdin.lineno, line)
# end
# File.open(FILENAME) do |io|
#   p io.getc
#   io.ungetc("b")
#   p io.gets
# end
# io << "bar " << "baz"
# -----------------------------------------------------------------------
# Buffering
# -----------------------------------------------------------------------
# filename = "buffering.txt"
# File.open(filename, "w") do |file|
#   3.times do |i|
#     file.sync = true
#     file.write ("a" * 5)
#     puts "#{i+1}: #{File.size(filename)}"
#   end
# end
# puts "result: #{File.size(filename)}"
# p File.read(filename)

# -----------------------------------------------------------------------
# コマンドのやりとり
# -----------------------------------------------------------------------
# pattern = Regexp.new(ARGV[0])
# filename = ARGV[1]
# if /.gz$/ =~ filename
#   file = IO.popen("zcat #{FILENAME}")
# else
#   file = File.open(FILENAME)
# end
# file.each_line do |line| 
#   print line if pattern =~ line
# end

