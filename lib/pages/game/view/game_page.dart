import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/pages/game/widgets/widgets.dart';
import 'package:othello/providers/providers.dart';
import 'package:othello/utils/utils.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  List<BoardSquare> generateSquares(BoardService boardService) {
    List<BoardSquare> boardSquares = [];
    Matrix<Square> squares = [];
    Board board = boardService.board;
    for (int i = 0; i < board.rows; i++) {
      List<Square> row = [];
      for (int j = 0; j < board.columns; j++) {
        Square square = Square(color: Colors.green);

        // Set the white pieces
        if ((i == (board.rows / 2 - 1) && j == (board.columns / 2 - 1)) ||
            (i == (board.rows / 2) && j == (board.columns / 2))) {
          Piece toAdd = Piece(
            color: Colors.white,
            position: Pair<int, int>(i, j),
          );
          square.setPiece(toAdd);
          boardService.players[Colors.white]!.addPiece(toAdd);
        }

        // Set the black pieces
        if ((i == (board.rows / 2 - 1) && j == (board.columns / 2)) ||
            (i == (board.rows / 2) && j == (board.columns / 2 - 1))) {
          Piece toAdd = Piece(
            color: Colors.black,
            position: Pair<int, int>(i, j),
          );
          square.setPiece(toAdd);
          boardService.players[Colors.black]!.addPiece(toAdd);
        }
        row.add(square);
        boardSquares.add(BoardSquare(row: i, column: j));
      }
      squares.add(row);
    }
    board.setSquares(squares);
    return boardSquares;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int boardDimension = ref.watch(boardDimensionProvider);
    BoardService boardService = ref.watch(boardServiceProvider);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const PlayerPanel(playerColor: Colors.black),
            ),
            Flexible(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(3.0),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      mainAxisSpacing: 1.5,
                      crossAxisSpacing: 1.5,
                      crossAxisCount: boardDimension,
                      children: generateSquares(boardService),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const PlayerPanel(playerColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
