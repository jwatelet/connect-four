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

  def win?(token)
    horizontal_four?(token) || vertical_four?(token) || diagonal_four?(token)
  end

  def game_over?
    @table.map do |line|
      line.include?(EMPTY)
    end.all?(false)
  end

  private

  def diagonal_four_to_the_right?(token)
    @table.each_with_index do |line, line_index|
      line.each_with_index do |_cell, column_index|
        count = 0
        x = column_index
        y = line_index
        loop do
          if @table[y][x] == token
            count += 1
          else
            count = 0
          end
          y += 1
          x += 1
          return true if count == 4
          break if y >= @table.size
        end
      end
    end
    false
  end

  def diagonal_four_to_the_left?(token)
    reversed_table = reverse_table
    reversed_table.each_with_index do |line, line_index|
      line.each_with_index do |_cell, column_index|
        count = 0
        x = column_index
        y = line_index
        loop do
          if reversed_table[y][x] == token
            count += 1
          else
            count = 0
          end
          y += 1
          x += 1
          return true if count == 4

          break if y >= reversed_table.size
        end
      end
    end
    false
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
