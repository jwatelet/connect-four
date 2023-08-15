require './lib/board'
require './lib/token'

describe Board do
  let(:board) { Board.new }

  describe '#draw' do
    describe 'when the board is empty' do
      it 'prints the empty board in the console' do
        result = <<~BOARD
           1 2 3 4 5 6 7
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
        BOARD

        expect { board.draw }.to output(result).to_stdout
      end
    end

    describe 'when the board contains a token' do
      let(:array) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(array: array) }

      it 'prints the empty board whith one token in the console' do
        result = <<~BOARD
           1 2 3 4 5 6 7
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ #{RED} _ _ _ _|
        BOARD

        expect { board.draw }.to output(result).to_stdout
      end
    end

    describe 'when the board contains multiple tokens' do
      let(:array) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, YELLOW, '_', '_', '_']
        ]
      end
      let(:board) { Board.new(array: array) }

      it 'prints the board with many tokens in the console' do
        result = <<~BOARD
           1 2 3 4 5 6 7
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ _ _ _ _ _|
          |_ _ #{RED} _ _ _ _|
          |_ _ #{RED} #{YELLOW} _ _ _|
        BOARD

        expect { board.draw }.to output(result).to_stdout
      end
    end
  end
end
