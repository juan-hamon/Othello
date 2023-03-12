import 'package:othello/logic/board/models/models.dart';

typedef Matrix<T> = List<List<T>>;

class Board {
  int rows;
  int columns;
  bool allowDiagonals;
  Matrix<Square> squares;

  Board({
    required this.rows,
    required this.columns,
    required this.allowDiagonals,
    this.squares = const [],
  });

  void setAllowDiagonals(bool nValue) {
    allowDiagonals = nValue;
  }

  void setSquares(Matrix<Square> nSquares) {
    squares = nSquares;
  }
}
