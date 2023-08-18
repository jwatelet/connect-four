class Player

  attr_reader :name, :token

  def initialize(hash)
    @name = hash[:name]
    @token = hash[:token]
  end
end
