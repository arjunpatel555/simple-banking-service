require 'csv_reader'

include CSV_Reader

TEST_CSV_FILE = "spec/lib/csv_reader.csv"

describe "read/1" do
  it 'returns nil when arg is not string' do
    expect(CSV_Reader.parse_from_file(nil)).to eq(nil)
  end

  it 'returns nil when file is not a csv' do
    expect(CSV_Reader.parse_from_file("spec/lib/csv_reader.txt")).to eq(nil)
  end

  it 'returns an array of csv contents, from valid csv file' do
    expected_array = [
      ["1", "Hello"],
      ["2", "World"],
    ]
    expect(CSV_Reader.parse_from_file(TEST_CSV_FILE)).to eq(expected_array)
  end
end
