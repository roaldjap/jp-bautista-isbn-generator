require "./lib/formatters/isbn_13"

RSpec.describe Formatters::Isbn13 do
  let(:sample_isbn_no) { "978160309492" }

  subject { described_class.new(isbn_number: sample_isbn_no) }

  describe "#weighted_digits" do
    context "when the ISBN number is valid" do
      it "generates an array of numbers containing the weighted digits" do
        expect(subject.weighted_digits).to eq(expected_digits(sample_isbn_no))
      end
    end
  end

  describe "#last_digit" do
    context "when the ISBN number is valid" do
      it "computes the last digit" do
        expect(subject.last_digit).to eq(expected_last_digit(sample_isbn_no))
      end
    end
  end

  describe "#process" do
    context "when the ISBN number is valid" do
      it "computes generates the ISBN13 number" do
        expect(subject.format).to eq([sample_isbn_no, expected_last_digit(sample_isbn_no)].join(""))
      end
    end
  end

  private
    def expected_digits(isbn_number)
      isbn_number.chars.map(&:to_i).map.with_index do |num, idx|
        idx.even? ? num * 1 : num * 3
      end
    end

    def expected_last_digit(isbn_number)
      remainder = expected_digits(isbn_number).sum % 10
      last_digit = 10 - remainder

      last_digit == 10 ? 0 : last_digit
    end
end
