# 文字コード
| 符号化方式 | 主に使われるところ |
| -- | -- |
| UTF-8        | テキスト全般 |
| Shift_JIS    | Windowsのテキスト |
| EUC-JP       | Unixのテキスト |
| ISO-2022-JP  | 電子メールなど |

| 文字 | UTF-8 | Shift_JIS | EUC-JP | ISO-2022-JP |
| -- | -- | -- | -- | -- |
| あ | E38182 | 82A0 | A4A2 | 2422 |

## osによって改行文字が異なる
| OS | 改行文字 |
| -- | -- |
| Unix           | LF |
| Windows        | CR + LF |
| Mac OS 9 以前  | CR |

日本語は3bytes
