# frozen_string_literal: true

class IsbnInitializer
  attr_accessor :data, :format

  def initialize(data: nil, format: nil)
    @data = data
    @format = format
  end

  def process
    raise InvalidFormat if format == nil || formatter_class == nil

    raise InvalidData unless (data =~ formatter_class.valid_regex) == 0

    formatter = formatter_class.new(isbn_number: data)
    formatter.format
  end

  def formatter_class
    case format.downcase
    when "isbn13"
      Formatters::Isbn13
    end
  end
end
