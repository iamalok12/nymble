class Player {
  static const x = 3;
  static const o = 5;
  static const empty = 2;
}

class Game {
  static const boardLength = 9;
  List<int>? board;
  static List<int>? initGameBoard() =>
      List.generate(boardLength, (index) => Player.empty);
  int winnerCheck(int player, int index, int turn, List<int> board) {
    if (turn < 10) {
      if (board[0] * board[1] * board[2] == 27 ||
          board[0] * board[1] * board[2] == 125 ||
          board[3] * board[4] * board[5] == 27 ||
          board[3] * board[4] * board[5] == 125 ||
          board[6] * board[7] * board[8] == 27 ||
          board[6] * board[7] * board[8] == 125 ||
          board[0] * board[3] * board[6] == 27 ||
          board[0] * board[3] * board[6] == 125 ||
          board[1] * board[4] * board[7] == 27 ||
          board[1] * board[4] * board[7] == 125 ||
          board[2] * board[5] * board[8] == 27 ||
          board[2] * board[5] * board[8] == 125 ||
          board[0] * board[4] * board[8] == 27 ||
          board[0] * board[4] * board[8] == 125 ||
          board[2] * board[4] * board[6] == 27 ||
          board[2] * board[4] * board[6] == 125) {
        return 555;
      }
      else {
        int posWin = findIndexForWinOrBlock(board, 0, 1, 2, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 3, 4, 5, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 6, 7, 8, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 0, 3, 6, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 1, 4, 7, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 2, 5, 8, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 0, 4, 8, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 2, 4, 6, turn.isOdd ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 0, 1, 2, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 3, 4, 5, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 6, 7, 8, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 0, 3, 6, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 1, 4, 7, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 2, 5, 8, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 0, 4, 8, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }
        posWin = findIndexForWinOrBlock(board, 2, 4, 6, turn.isEven ? 5 : 3);
        if (posWin != 0) {
          return posWin;
        }

        return 999;
      }
    }
    return 999;
  }
  int findIndexForWinOrBlock(List<int> board, int a, int b, int c, int player) {
    if (board[a] * board[b] * board[c] == player * player * 2) {
      if (board[a] == 2) return a;
      if (board[b] == 2) return b;
      if (board[c] == 2) return c;
    }
    return 0;
  }
  int computerPlay(List<int> board) {
    return 5;
  }
}
