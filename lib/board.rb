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

  def horizontal_four?(token)
    count = 0
    @table.each do |line|
      line.each do |cell|
        break if count == 4

        if cell == token
          count += 1
        else
          count = 0
        end
      end
    end
    count == 4
  end

  def vertical_four?(token)
    count = 0
    @table.transpose.each do |line|
      line.each do |cell|
        break if count == 4

        if cell == token
          count += 1
        else
          count = 0
        end
      end
    end
    count == 4
  end

  def diagonal_four?(token)
    diagonal_four_to_the_right?(token) || diagonal_four_to_the_left?(token)
  end

  private

  def diagonal_four_to_the_right?(token)
    count = 0
    @table.each_with_index do |line, line_index|
      line.each_with_index do |_cell, column_index|
        loop do
          break if count == 4 || line_index >= @table.size

          if @table[line_index][column_index] == token
            count += 1
          else
            count = 0
          end
          line_index += 1
          column_index += 1
        end
      end
    end
    count == 4
  end

  def diagonal_four_to_the_left?(token)
    reversed_table = reverse_table
    count = 0
    reversed_table.each_with_index do |line, line_index|
      line.each_with_index do |_cell, column_index|
        loop do
          break if count == 4 || line_index >= reversed_table.size

          if reversed_table[line_index][column_index] == token
            count += 1
          else
            count = 0
          end
          line_index += 1
          column_index += 1
        end
      end
    end
    count == 4
  end

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

  def reverse_table
    @table.map do |line|
      line.reverse
    end
  end
end
