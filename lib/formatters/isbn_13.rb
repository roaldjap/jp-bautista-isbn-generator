# frozen_string_literal: true

module Formatters
  class Isbn13
    attr_accessor :isbn_number

    def initialize(isbn_number: nil)
      @isbn_number = isbn_number
    end

    def self.valid_regex
      /[0-9]{12}/
    end

    def last_digit
      remainder = weighted_digits.sum % 10
      last_digit = 10 - remainder

      last_digit == 10 ? 0 : last_digit
    end

    def weighted_digits
      isbn_number.chars.map(&:to_i).map.with_index do |num, idx|
        idx.even? ? num * 1 : num * 3
      end
    end

    def format
      [isbn_number, last_digit].join("")
    end
  end
end
