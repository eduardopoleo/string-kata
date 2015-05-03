module StringCalculator
  def self.add(string)
    return 0 if string == "" 
    validate(string)
    string, delimiter = calculate_delimiter(string)
    numbers_array = extract_numbers(string, delimiter)
    result = sum(numbers_array)
  end

  def self.extract_numbers(string, delimiter)
    string.gsub("\n", delimiter).split(delimiter).select{|num| num.size <= 3 || num == "1000"}
  end

  def self.sum(array)
    array.map(&:to_i).reduce(:+)
  end

  def self.calculate_delimiter(string)
    delimiter = ","
    if string.include?("//")
      if string =~ /\/\/\[.+\]/
        delimiter = string.scan(/\/\/\[(.+)\]/).flatten[0]
        string = string[(delimiter.size + 4)..-1]
      else 
        delimiter = string[2]
      end
    end
    [string, delimiter]
  end

  def self.validate(string) 
    neg_numbers = string.scan(/-\d+/)
    if neg_numbers.size == 1
      raise "You have a negative number"
    elsif neg_numbers.size > 1
      raise "You have these negative numbers: #{neg_numbers}"
    end
  end
end
