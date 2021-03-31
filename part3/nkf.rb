require 'nkf'

s = "あアぁｱヴバパｳﾞ01０１abABａｂＡＢ"
# 原文
p s
# -w 半角を全角にする
p NKF.nkf("-w", s)
# -x 半角をそのままにする
p NKF.nkf("-xw", s)
# ひらがなをカタカナに変換
p NKF.nkf("-h1 -w", s)
# カタカナをひらがなに変換
p NKF.nkf("-h2 -w", s)

s = "育ち盛り　弁当"
# 全角空白を半角空白に変換
p NKF.nkf("-Z1 -w", s)
# 文字コードをsjisに変換
p NKF.nkf("-s", s)

s = "〜鎌倉幕府〜"
# ic 文字コード、oc 出力コード、変換できなければ下駄線に置き換える
p NKF.nkf("--ic=UTF-8 --oc=CP932 --fb-subchar=0x3013", s)
# sjisからUTF-8に変換
p s.encode("Shift_JIS", "UTF-8")

s = "Test🥺"
s2 = NKF.nkf("--ic=UTF-8 --oc=CP932 --fb-subchar=0x3013", s)
p s2.encode("UTF-8", "Shift_JIS")

