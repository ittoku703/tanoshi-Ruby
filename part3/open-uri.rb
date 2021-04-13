# -----------------------------------------------------------------------
# IO class open-uri
# HTTPなどのURLを普通のファイルのように開くことができるようになる。
# -----------------------------------------------------------------------
require "open-uri"

URI.open("http://www.ruby-lang.org/ja/") do |io|
  p io.base_uri
  p io.content_type
  p io.charset
  p io.content_encoding
  p io.last_modified
end

filename = "ruby-3.0.1.tar.gz"
URI.open("https://cache.ruby-lang.org/pub/ruby/3.0/#{filename}") do |io|
  File.binwrite(filename, io.read)
end

