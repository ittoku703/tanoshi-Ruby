例外処理の書き方
begin
    raise   # エラーを発生
    例外が起こるかもしれない処理
rescue => 例外オブジェクトが代入される変数
    retry   # やり直し
    例外が起こった場合の処理
ensure
    例外の有無に関わらず実行
end

こういう書き方もできる
n = Integer(val) rescue 0

またrescueに引数も渡すことができる
rescue Errno::ENOENT, Errno::EACCES

$!      最後に発生した例外
$@      最後に発生した例外の位置に関する情報

例外クラス（一部）
Exception #最上位
  |--NoMemoryError
  |--ScriptError
  |    |--LoadError
  |    |--SyntaxError
  |
  |--StandardError #独自例外クラスを生成する際に継承を推奨されているクラス
  |   |--ArgumentError
  |   |--NameError
  |   |    |--NoMethodError
  |   |
  |   |
  |   |--RuntimeError
  |   |--TypeError
  |   |--ZeroDivisionError
  |
  |--SystemExit
  |--SystemStackError

よく見るエラーメッセージ
syntax error
NameError / NoMethodError
ArgumentError
TypeEror
LoadError
[BUG] (rubyや拡張ライブラリのバグ）

