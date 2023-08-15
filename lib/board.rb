class Board
  HEADER = " 1 2 3 4 5 6 7\n".freeze

  def initialize
    @array = initialize_array
  end

  def draw
    puts HEADER + draw_body
  end

  private

  def initialize_array
    [
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _],
      %w[_ _ _ _ _ _ _]
    ]
  end

  def draw_body
    @array.map do |line|
      "|#{line.join(' ')}|"
    end.join("\n")
  end
end
