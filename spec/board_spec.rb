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
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

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
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, YELLOW, '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

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

  describe '#add!' do
    describe 'when the board is empty and you adds a new token' do
      let(:result) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end

      it 'contains the added token' do
        board.add!(3, RED)
        expect(board.table).to eql(result)
      end
    end

    describe 'when the board contains a token and you adds a new token' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }
      let(:result) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', YELLOW, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end

      it 'contains the two tokens' do
        board.add!(3, YELLOW)
        expect(board.table).to eql(result)
      end
    end

    describe 'when the board contains a token and you adds a new token next to it' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }
      let(:result) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, YELLOW, '_', '_', '_']
        ]
      end

      it 'contains the two tokens' do
        board.add!(4, YELLOW)
        expect(board.table).to eql(result)
      end
    end

    describe 'when the board contains a column full and you try to add one inside' do
      let(:table) do
        [
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }
      let(:result) do
        [
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end

      it 'contains the two tokens' do
        board.add!(3, YELLOW)
        expect(board.table).to eql(result)
      end
    end
  end

  describe 'horizontal_four?' do
    describe 'when the board is empty' do
      it 'returns false' do
        expect(board.horizontal_four?(RED)).to be false
      end
    end

    describe 'when a line of the board contains four consecutive tokens of the same color' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', RED, RED, RED, RED, '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns true' do
        expect(board.horizontal_four?(RED)).to be true
      end
    end

    describe 'when a line of the board contains four token of the same color but discontinued' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', RED, RED, '_', RED, RED, '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns false' do
        expect(board.horizontal_four?(RED)).to be false
      end
    end
  end

  describe 'vertical_four?' do
    describe 'when the board is empty' do
      it 'returns false' do
        expect(board.horizontal_four?(RED)).to be false
      end
    end

    describe 'when a column of the board contains four consecutive tokens of the same color' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns true' do
        expect(board.vertical_four?(RED)).to be true
      end
    end

    describe 'when a column of the board contains four non consecutive tokens of the same color' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', YELLOW, '_', '_', '_', '_'],
          ['_', '_', RED, '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns false' do
        expect(board.vertical_four?(RED)).to be false
      end
    end
  end

  describe 'diagonal_four?' do
    describe 'when to board is empty' do
      it 'returns false' do
        expect(board.diagonal_four?(RED)).to be false
      end
    end

    describe 'when the board contains four consecutive tokens in diagonal line that goes to the right' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', RED, '_', '_', '_', '_'],
          ['_', '_', '_', RED, '_', '_', '_'],
          ['_', '_', '_', '_', RED, '_', '_'],
          ['_', '_', '_', '_', '_', RED, '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns true' do
        expect(board.diagonal_four?(RED)).to be true
      end
    end

    describe 'when the board contains four consecutive tokens in diagonal line that goes to the right' do
      let(:table) do
        [
          %w[_ _ _ _ _ _ _],
          %w[_ _ _ _ _ _ _],
          ['_', '_', '_', '_', YELLOW, '_', '_'],
          ['_', '_', '_', YELLOW, '_', '_', '_'],
          ['_', '_', YELLOW, '_', '_', '_', '_'],
          ['_', YELLOW, '_', '_', '_', '_', '_']
        ]
      end
      let(:board) { Board.new(table: table) }

      it 'returns true' do
        expect(board.diagonal_four?(YELLOW)).to be true
      end
    end
  end
end
