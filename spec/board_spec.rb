require './lib/board'

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
  end
end
