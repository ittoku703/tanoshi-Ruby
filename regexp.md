## 基本的な正規表現
| 文字 | 説明 |
| -- | -- |
| .        | 任意の一文字 |
| +        | 直前の文字が一回以上繰り返し |
| *        | 直前の文字が0回以上繰り返し |
| ?        | 直前の文字が0か1個の場合 |
| +?       | 直前の文字が一回以上繰り返し |
| *?       | 直前の文字が0回以上繰り返し |
| ??       | 直前の文字が0か1個の場合 |
| |        | OR演算子 |
| \        | 直後の文字をエスケープ |
| [...]    | 括弧内のいずれかの一文字 |
| [^...]   | 括弧内以外の一文字 |
| (...)    | グループにまとめる |
| {n}      | 直前の文字の桁数を指定 |
| {n,}     | 直前の文字の最小桁数を指定 |
| {n,m}    | 直前の文字の桁幅を指定 |

## 定義済み
| 文字 | 説明 |
| -- | -- |
| \t       | タブ |
| \r       | 改行。CR |
| \n       | 改行。LF |
| \d       | Digit |
| \D       | !Digit |
| \s       | 垂直タブ以外の空白 |
| \S       | 垂直タブを含んだ空白 |
| \w       | アルファベット、アンダーバー、数字 |
| \W       | アルファベット、アンダーバー、数字以外 |

## 特定の位置関係の正規表現
| 文字 | 説明 |
| -- | -- |
| ^        | 直後の文字が行の先頭にある |
| $        | 直後の文字が行の末尾にある |
| \<       | 単語の先頭 |
| \>       | 単語の末尾 |
| \b       | 単語の先頭か末尾 |
| \B       | 単語の先頭か末尾以外 |
| \A       | ファイルの先頭 |
| \z       | ファイルの末尾 |
| \G       | 直前の一致文字列の末尾 |
