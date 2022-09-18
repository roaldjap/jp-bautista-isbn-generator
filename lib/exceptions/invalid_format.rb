class InvalidFormat < StandardError
  def initialize(message = "Invalid Format. Please try again.")
    super(message)
  end
end
