require 'csv'

module CSV_Reader
  def parse_from_file(file)
    return nil unless file.is_a? String
    return nil unless File.extname(file) == ".csv"
    CSV.read(file)
  end
end

