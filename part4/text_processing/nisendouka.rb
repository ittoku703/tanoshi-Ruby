require 'open-uri'

url = "https://www.aozora.gr.jp/cards/001779/files/56647_58167.html"
filename = "nisendouka.txt"

File.open(filename, "w") do |f|
  text = String.new
  html = URI.open(url, "r:shift_jis").read
  in_header = true
  text_start = /<div class="main_text">/
  text_end =   /<div class="bibliographical_information">/
  html_tag =   /<[^>]+>/
  html.each_line do |line|
    # タイトルを代入
    text += line.gsub(html_tag, '') if /<title>/ =~ line
    # 本文までスキップする
    (in_header && text_start !~ line) ? next : in_header = false
    # 本文が終わったら抜ける
    break if text_end =~ line
    # htmlタグを書き込まずに代入
    text += line.gsub(html_tag, '')
  end
  f.write text.encode("utf-8")
end

