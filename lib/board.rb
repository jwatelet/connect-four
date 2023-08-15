class Board
  HEADER = " 1 2 3 4 5 6 7\n".freeze

  def initialize(**hash)
    @array = initialize_array(hash)
  end

  def draw
    puts HEADER + draw_body
  end

  private

  def initialize_array(hash)
    if hash[:array].nil?
      [
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _]
      ]
    else
      hash[:array]
    end
  end

  def draw_body
    @array.map do |line|
      "|#{line.join(' ')}|"
    end.join("\n")
  end
end
