require_relative 'token'

class Board
  attr_reader :table

  HEADER = " 1 2 3 4 5 6 7\n".freeze

  def initialize(**hash)
    @table = initialize_table(hash)
  end

  def draw
    puts HEADER + draw_body
  end

  def add!(column_id, token)
    @table.reverse.each do |line|
      if line[column_id - 1] == EMPTY
        line[column_id - 1] = token
        break
      end
    end
  end

  private

  def initialize_table(hash)
    if hash[:table].nil?
      [
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _],
        %w[_ _ _ _ _ _ _]
      ]
    else
      hash[:table]
    end
  end

  def draw_body
    @table.map do |line|
      "|#{line.join(' ')}|"
    end.join("\n")
  end
end
