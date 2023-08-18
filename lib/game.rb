require_relative 'display'
require_relative 'token'
require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @display = Display.new
    @board = Board.new
    @player1 = Player.new(name: 'Player 1', token: RED)
    @player2 = Player.new(name: 'Player 2', token: YELLOW)
  end

  def start
    @display.puts_general_instruction
    @display.puts_player_information(@player1)
    @display.puts_player_information(@player2)
    @display.puts_game_instruction
    game_loop
    end_game
  end

  def game_loop
    loop do
      @board.draw
      player_turn(@player1)
      break if @board.win?(@player1.token) || @board.game_over?

      player_turn(@player2)
      break if @board.win?(@player2.token) || @board.game_over?
    end
  end

  def end_game
    @display.puts_player_win(@player1) if player_wins?(@player1)
    @display.puts_player_win(@player2) if player_wins?(@player2)
    @display.puts_game_over if @board.game_over?
  end

  def player_wins?(player)
    @board.win?(player.token)
  end

  def player_turn(player)
    column_id = gets_column_number
    @board.add!(column_id, player.token)
    @board.draw
  end

  def gets_column_number
    column_number_string = ''
    loop do
      validate = false
      column_number_string = gets.chomp

      if %w[1 2 3 4 5 6 7].include?(column_number_string)
        validate = true
      else
        @display.puts_only_column_number_error
        @display.puts_game_instruction
      end
      break if validate
    end
    column_number_string.to_i
  end
end
