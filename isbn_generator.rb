#!/usr/bin/env ruby
# frozen_string_literal: true

["./lib/exceptions/*.rb", "./lib/formatters/*.rb"].each do |dir|
  Dir.glob(dir).each { |file| require file }
end

require "./isbn_initializer"

if ARGV.length == 1
  format = "ISBN13"
  initializer = IsbnInitializer.new(data: ARGV.first, format: format)
  puts "#{format.upcase} Number: #{initializer.process}"
else
  puts "Invalid arguments provided!"
end
