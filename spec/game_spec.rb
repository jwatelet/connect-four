require_relative '../lib/game'
require_relative '../lib/token'
require_relative '../lib/player'

describe Game do
  let(:game) { Game.new }
  let(:board) { Board.new }
  let(:player1) { Player.new(name: 'Player 1', token: RED) }
  let(:player2) { Player.new(name: 'Player 2', token: YELLOW) }
  describe '#end_game' do
    describe 'when the player 1 wins' do
      it "write 'player 1 wins'" do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        allow(game).to receive(:player_wins?).with(player1).and_return(true)
        allow(game).to receive(:player_wins?).with(player2).and_return(false)
        expect { game.end_game }.to output("Player 1 wins\n").to_stdout
      end
    end
    describe 'when the player 2 wins' do
      it "write 'player 2 wins'" do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        allow(game).to receive(:player_wins?).with(player1).and_return(false)
        allow(game).to receive(:player_wins?).with(player2).and_return(true)
        expect { game.end_game }.to output("Player 2 wins\n").to_stdout
      end
    end
    describe 'when the game is over with no winners' do
      it 'writes game over' do
        game.instance_variable_set(:@player1, player1)
        game.instance_variable_set(:@player2, player2)
        game.instance_variable_set(:@board, board)
        allow(game).to receive(:player_wins?).with(player1).and_return(false)
        allow(game).to receive(:player_wins?).with(player2).and_return(false)
        allow(board).to receive(:game_over?).and_return(true)
        expect { game.end_game }.to output("GAME OVER !\n").to_stdout
      end
    end
  end
end
