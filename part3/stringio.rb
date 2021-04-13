# -----------------------------------------------------------------------
# IO class stringIO
# 文字列にIOと同じインターフェースを持たせるためのクラス。
# -----------------------------------------------------------------------
require "stringio"
sio = StringIO.new("hoge", "r+")
p sio.read
sio.rewind
p sio.read(1)
sio.write("OGE")
sio.rewind
p sio.read

