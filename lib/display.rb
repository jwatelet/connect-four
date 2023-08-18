class Display
  def puts_general_instruction
    puts "\e[4mConnect Four!\e[0m".center(80)
    puts 'The objective of the game is to be the first to form a horizontal, '
    puts "vertical, or diagonal line of four of one's own tokens"
  end

  def puts_player_information(player)
    puts "#{player.name}, symbol : #{player.token}"
  end

  def puts_game_instruction
    puts 'Type the column number to put a token inside'
  end

  def puts_only_column_number_error
    puts 'Please enter only column number'
  end

  def puts_player_win(player)
    puts "#{player.name} wins"
  end

  def puts_game_over
    puts "GAME OVER !"
  end
end
