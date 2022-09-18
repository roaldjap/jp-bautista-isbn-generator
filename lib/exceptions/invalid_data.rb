class InvalidData < StandardError
  def initialize(message = "Invalid Data. Please enter a valid ISBN number.")
    super(message)
  end
end
