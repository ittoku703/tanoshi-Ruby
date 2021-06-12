require 'csv'

filename = "test.csv"

csv_text = <<~CSV_TEXT
  Ruby,1995
  Rust,2010
CSV_TEXT
  
IO.write filename, csv_text

# Read

# load file one line at a time
CSV.foreach filename do |row|
  p row
end
#=> ["Ruby", "1995"]
#   ["Rust", "2010"]

# load file one time.
p CSV.read filename
#=> [["Ruby", "1995"], ["Rust", "2010"]]

# load string line at a time
CSV.parse csv_text do |row|
  p row
end
#=> ["Ruby", "1995"]
#   ["Rust", "2010"]

p CSV.parse csv_text
#=> [["Ruby", "1995"], ["Rust", "2010"]]

# Write

# write file
CSV.open(filename, "wb") do |csv|
  csv << %w(row of CSV data)
  csv << %w(another row)
end

# write string
csv_string = CSV.generate do |csv|
  csv << %w(row of CSV data)
  csv << %w(another row)
end

# convert on line
csv_string = %w(CSV data).to_csv
csv_array = "CSV,String".parse_csv

# Short cut
CSV           { |csv_out| csv_out << %w{my data here} }
CSV(csv = "") { |csv_str| csv_str << %w{my data here} }
CSV($stderr)  { |csv_err| csv_err << %w{my data here} }

