import 'package:flutter/material.dart';
import 'package:othello/logic/board/board.dart';
import 'package:othello/logic/player/models/player.dart';
import 'package:othello/utils/direction.dart';

class BoardController extends BoardService {
  BoardController({
    required super.board,
    required super.currentPlayer,
  });

  @override
  bool addPiece(Piece toAdd) {
    // We obtain the opponent adjacent pieces by getting all the adjacent
    // pieces of the position in which we want to place the piece and leaving
    // only the adjacent pieces that have a different color.
    List<Piece> opponentAdjacentPieces = obtainAdjacentPieces(toAdd)
        .where((piece) => piece.color != toAdd.color)
        .toList();

    // The piece we want to place is adjacent to any opponent piece if
    // the list of enemy adjacent pieces is not empty.
    bool isAdjacentToOpponentPiece = opponentAdjacentPieces.isNotEmpty;

    // A position is occupied if the square in that position contains a piece.
    bool isOccupied =
        board.squares[toAdd.position.row][toAdd.position.column].cotainsPiece();

    // We declare the flag in order to know if we could place the piece.
    bool placed = false;

    // If the piece we want to place is adjacent to at least one opponent piece and
    // the position we want to place it it's not occupied, then we could set the piece in the
    // board.
    if (isAdjacentToOpponentPiece && !isOccupied) {
      // Now we have to check that this positioning ensures at least one capture.
      // To do this we iterate the opponent adjacent pieces
      for (Piece opponents in opponentAdjacentPieces) {
        // We obtain the direction in which we are going to move in order to capture
        // opponent pieces.
        Direction lineDirection = obtainDirection(toAdd, opponents);

        // Based on the opponent piece and the direction, we obtain the pieces in that
        // path that can be captured.
        List<Piece> piecesToConvert =
            obtainPiecesToConvert(toAdd, lineDirection);

        // The final filter to know if we can add the piece in this position is that the
        // path obtained is not empty.
        bool isValid = piecesToConvert.isNotEmpty;

        // If it is valid then we set the piece on the board and then convert the pieces
        // in the path obtained.
        if (isValid) {
          // If the piece has not been placed before (because, until now, there was no
          // valid path to ensure a capture) then we place it on the board and set the
          // flag to true, in order to prevent multiple paintings on the UI.
          if (!placed) {
            board.squares[toAdd.position.row][toAdd.position.column]
                .setPiece(toAdd);
            placed = true;
            currentPlayer.addPiece(toAdd);
          }

          // Convert the pieces founded to the color of the current player.
          convertPieces(piecesToConvert, currentPlayer.color);
        }

        // If it is not valid we go through all the other opponent's adjacent pieces until
        // we can find a valid path.
      }
    }

    return placed;
  }

  @override
  void addPlayer(Player toAdd) {
    players[toAdd.color] = toAdd;
  }

  @override
  void changeCurrentPlayer(Player nextPlayer) {
    currentPlayer = nextPlayer;
  }

  @override
  void changeTurn(Color nextPlayerColor) {
    Player nextPlayer = players[nextPlayerColor]!;
    changeCurrentPlayer(nextPlayer);
    checkForGameOver();
  }

  @override
  void checkForGameOver() {
    bool hasMovements = hasPossibleMovements();
    int maximumPieces = (board.columns * board.rows) ~/ 2;
    // TODO: Display the messages in the UI, not in the console.
    if (currentPlayer.placedPieces.isEmpty) {
      // Show text displaying that this player has lost the game.
      print("${currentPlayer.name} has lost beacuse he has no placed pieces");
    } else if (!hasMovements) {
      // Show text displaying that this player has lost the game.
      print(
          "${currentPlayer.name} has lost beacuse he has no more possible movements.");
    } else if (currentPlayer.getPlayablePieces(maximumPieces) <= 0) {
      print(
          "${currentPlayer.name} has lost beacuse he can no loger place pieces");
      // Show text displaying that this player has lost the game.
    }
  }

  @override
  bool checkForPath(Piece initialPiece, Direction direction) {
    late int limit, horizontalLimit, currentRow, currentColumn;
    final bool Function() condition;
    final void Function() advance;

    switch (direction) {
      case Direction.up:
        limit = 0;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column;
        condition = () => currentRow >= limit;
        advance = () => currentRow--;
        break;
      case Direction.down:
        limit = board.rows;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column;
        condition = () => currentRow < limit;
        advance = () => currentRow++;
        break;
      case Direction.left:
        limit = 0;
        currentRow = initialPiece.position.row;
        currentColumn = initialPiece.position.column - 1;
        condition = () => currentColumn >= limit;
        advance = () => currentColumn--;
        break;
      case Direction.right:
        limit = board.columns;
        currentRow = initialPiece.position.row;
        currentColumn = initialPiece.position.column + 1;
        condition = () => currentColumn < limit;
        advance = () => currentColumn++;
        break;
      case Direction.upLeft:
        limit = 0;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column - 1;
        condition = () => currentRow >= limit && currentColumn >= limit;
        advance = () {
          currentRow--;
          currentColumn--;
        };
        break;
      case Direction.downLeft:
        limit = board.rows;
        horizontalLimit = 0;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column - 1;
        condition =
            () => currentRow < limit && currentColumn >= horizontalLimit;
        advance = () {
          currentRow++;
          currentColumn--;
        };
        break;
      case Direction.upRight:
        limit = 0;
        horizontalLimit = board.columns;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column + 1;
        condition =
            () => currentRow >= limit && currentColumn < horizontalLimit;
        advance = () {
          currentRow--;
          currentColumn++;
        };
        break;
      case Direction.downRight:
        // As the columns and rows are equal, we can use either of
        // the two values;
        limit = board.columns;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column + 1;
        condition = () => currentRow < limit && currentColumn < limit;
        advance = () {
          currentRow++;
          currentColumn++;
        };
        break;
    }

    while (condition()) {
      Square currentSquare = board.squares[currentRow][currentColumn];
      if (currentSquare.cotainsPiece()) {
        if (currentSquare.piece!.color == currentPlayer.color) {
          return false;
        }
      } else {
        return true;
      }
      advance();
    }

    return false;
  }

  @override
  void convertPieces(List<Piece> piecesToConvert, Color color) {
    // We convert the pieces on the path by changing their color to the current player's.
    for (Piece piece in piecesToConvert) {
      piece.setColor(color);
      board.squares[piece.position.row][piece.position.column].setPiece(piece);
    }

    // We obtain the opponent player.
    Player opponent = (color == Colors.black)
        ? players[Colors.white]!
        : players[Colors.black]!;

    // We add the converted pieces to the current player played pieces.
    currentPlayer.addPieces(piecesToConvert);

    // We remove the opponent pieces converted from his list of played pieces.
    opponent.removePlacedPieces(piecesToConvert);
  }

  @override
  bool hasPossibleMovements() {
    List<Piece> currentPlayerPieces = currentPlayer.placedPieces;
    for (Piece piece in currentPlayerPieces) {
      // We obtain the opponent adjacent pieces by getting all the adjacent
      // pieces of the position in which we want to place the piece and leaving
      // only the adjacent pieces that have a different color.
      List<Piece> opponentAdjacentPieces = obtainAdjacentPieces(piece)
          .where((piece) => piece.color != currentPlayer.color)
          .toList();

      // The piece we want to place is adjacent to any opponent piece if
      // the list of enemy adjacent pieces is not empty.
      bool isAdjacentToOpponentPiece = opponentAdjacentPieces.isNotEmpty;

      // If the piece has at least one adjacent opponent piece, then there could
      // be a possible movement.
      if (isAdjacentToOpponentPiece) {
        // We have to see if there is an existing path for at least one of the opponent
        // adjacent pieces.
        for (Piece opponents in opponentAdjacentPieces) {
          // We obtain the direction in which we are going to move in order to find a
          // path.
          Direction lineDirection = obtainDirection(piece, opponents);

          // We check if there is a possible path for a capture. If there is then
          // there is a possible movement for that player.
          bool pathExists = checkForPath(piece, lineDirection);

          if (pathExists) {
            return true;
          }
        }
      }
    }
    return false;
  }

  @override
  List<Piece> obtainAdjacentPieces(Piece piece) {
    List<Piece> pieces = [];
    // Has a piece on the left and doesn't get out of the map.
    if (piece.position.column - 1 > 0 &&
        board.squares[piece.position.row][piece.position.column - 1]
            .cotainsPiece()) {
      pieces.add(
          board.squares[piece.position.row][piece.position.column - 1].piece!);
    }

    // Has a piece on the right and doesn't get out of the map.
    if (piece.position.column + 1 < board.columns &&
        board.squares[piece.position.row][piece.position.column + 1]
            .cotainsPiece()) {
      pieces.add(
          board.squares[piece.position.row][piece.position.column + 1].piece!);
    }

    // Has a piece upwards and doesn't get out of the map.
    if (piece.position.row - 1 > 0 &&
        board.squares[piece.position.row - 1][piece.position.column]
            .cotainsPiece()) {
      pieces.add(
          board.squares[piece.position.row - 1][piece.position.column].piece!);
    }

    // Has a piece downwards and doesn't get out of the map.
    if (piece.position.row + 1 < board.rows &&
        board.squares[piece.position.row + 1][piece.position.column]
            .cotainsPiece()) {
      pieces.add(
          board.squares[piece.position.row + 1][piece.position.column].piece!);
    }

    if (board.allowDiagonals) {
      // Has a piece in the down-righ diagonal and doesn't get out of the map.
      if (piece.position.row + 1 < board.rows &&
          piece.position.column + 1 < board.columns &&
          board.squares[piece.position.row + 1][piece.position.column + 1]
              .cotainsPiece()) {
        pieces.add(board
            .squares[piece.position.row + 1][piece.position.column + 1].piece!);
      }

      // Has a piece in the down-left diagonal and doesn't get out of the map.
      if (piece.position.row + 1 < board.rows &&
          piece.position.column - 1 > 0 &&
          board.squares[piece.position.row + 1][piece.position.column - 1]
              .cotainsPiece()) {
        pieces.add(board
            .squares[piece.position.row + 1][piece.position.column - 1].piece!);
      }

      // Has a piece in the up-right diagonal and doesn't get out of the map.
      if (piece.position.row - 1 > 0 &&
          piece.position.column + 1 < board.columns &&
          board.squares[piece.position.row - 1][piece.position.column + 1]
              .cotainsPiece()) {
        pieces.add(board
            .squares[piece.position.row - 1][piece.position.column + 1].piece!);
      }

      // Has a piece in the up-left diagonal and doesn't get out of the map.
      if (piece.position.row - 1 > 0 &&
          piece.position.column - 1 > 0 &&
          board.squares[piece.position.row - 1][piece.position.column - 1]
              .cotainsPiece()) {
        pieces.add(board
            .squares[piece.position.row - 1][piece.position.column - 1].piece!);
      }
    }
    return pieces;
  }

  @override
  Direction obtainDirection(Piece begin, Piece end) {
    int horizontalDirection = begin.position.column - end.position.column;
    int verticalDirection = begin.position.row - end.position.row;
    if (horizontalDirection == 0) {
      return verticalDirection > 0 ? Direction.up : Direction.down;
    } else if (board.allowDiagonals &&
        horizontalDirection != 0 &&
        verticalDirection != 0) {
      if (horizontalDirection == -1 && verticalDirection == -1) {
        return Direction.downRight;
      } else if (horizontalDirection == -1 && verticalDirection == 1) {
        return Direction.upRight;
      } else if (horizontalDirection == 1 && verticalDirection == -1) {
        return Direction.downLeft;
      } else {
        return Direction.upLeft;
      }
    } else {
      return horizontalDirection < 0 ? Direction.right : Direction.left;
    }
  }

  @override
  List<Piece> obtainPiecesToConvert(Piece initialPiece, Direction direction) {
    late int limit, horizontalLimit, currentRow, currentColumn;
    final bool Function() condition;
    final void Function() advance;
    final List<Piece> result = [];
    bool containsDifferentColor = false;
    late bool isAnOpponentPiece;

    switch (direction) {
      case Direction.up:
        limit = 0;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column;
        condition = () => currentRow >= limit;
        advance = () => currentRow--;
        break;
      case Direction.down:
        limit = board.rows;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column;
        condition = () => currentRow < limit;
        advance = () => currentRow++;
        break;
      case Direction.left:
        limit = 0;
        currentRow = initialPiece.position.row;
        currentColumn = initialPiece.position.column - 1;
        condition = () => currentColumn >= limit;
        advance = () => currentColumn--;
        break;
      case Direction.right:
        limit = board.columns;
        currentRow = initialPiece.position.row;
        currentColumn = initialPiece.position.column + 1;
        condition = () => currentColumn < limit;
        advance = () => currentColumn++;
        break;
      case Direction.upLeft:
        limit = 0;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column - 1;
        condition = () => currentRow >= limit && currentColumn >= limit;
        advance = () {
          currentRow--;
          currentColumn--;
        };
        break;
      case Direction.downLeft:
        limit = board.rows;
        horizontalLimit = 0;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column - 1;
        condition =
            () => currentRow < limit && currentColumn >= horizontalLimit;
        advance = () {
          currentRow++;
          currentColumn--;
        };
        break;
      case Direction.upRight:
        limit = 0;
        horizontalLimit = board.columns;
        currentRow = initialPiece.position.row - 1;
        currentColumn = initialPiece.position.column + 1;
        condition =
            () => currentRow >= limit && currentColumn < horizontalLimit;
        advance = () {
          currentRow--;
          currentColumn++;
        };
        break;
      case Direction.downRight:
        // As the columns and rows are equal, we can use either of
        // the two values;
        limit = board.columns;
        currentRow = initialPiece.position.row + 1;
        currentColumn = initialPiece.position.column + 1;
        condition = () => currentRow < limit && currentColumn < limit;
        advance = () {
          currentRow++;
          currentColumn++;
        };
        break;
    }

    while (condition()) {
      Square currentSquare = board.squares[currentRow][currentColumn];
      if (currentSquare.cotainsPiece()) {
        isAnOpponentPiece = currentSquare.piece!.color != initialPiece.color;
        if (isAnOpponentPiece) {
          containsDifferentColor = true;
          result.add(currentSquare.piece!);
        } else if (containsDifferentColor) {
          return result;
        }
      } else {
        return [];
      }
      advance();
    }

    result.clear();

    return result;
  }
}
