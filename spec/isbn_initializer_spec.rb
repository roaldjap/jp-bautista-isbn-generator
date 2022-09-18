require "./isbn_initializer"
require "./lib/exceptions/invalid_data"
require "./lib/exceptions/invalid_format"
require "./lib/formatters/isbn_13"

RSpec.describe IsbnInitializer do
  let(:sample_isbn_no) { "978160309492" }

  describe "#formatter_class" do
    context "when the format is valid" do
      subject { described_class.new(data: sample_isbn_no, format: "isbn13") }

      it "returns the appropriate formatter class" do
        expect(subject.formatter_class).to eq(Formatters::Isbn13)
      end
    end

    context "when the format is invalid" do
      subject { described_class.new(data: sample_isbn_no, format: "invalidformat") }

      it "returns nil" do
        expect(subject.formatter_class).to be_nil
      end
    end
  end

  describe "#process" do
    context "when the format is invalid" do
      subject { described_class.new(data: sample_isbn_no, format: "invalidformat") }

      it "raises an InvalidFormat exception" do
        expect { subject.process }.to raise_error(InvalidFormat)
      end
    end

    context "when the data is invalid" do
      subject { described_class.new(data: "abcdef", format: "isbn13") }

      it "raises an InvalidData exception" do
        expect { subject.process }.to raise_error(InvalidData)
      end
    end

    context "when both format and data are valid" do
      let(:expected_result) { "9781603094924" }

      subject { described_class.new(data: sample_isbn_no, format: "isbn13") }

      it "returns the correct ISBN formatted number" do
        expect(subject.process).to eq(expected_result)
      end
    end
  end
end
