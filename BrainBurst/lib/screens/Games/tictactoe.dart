import 'dart:math';

import 'package:flutter/material.dart';

enum Player { X, O, computer }

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> squares = List.generate(9, (_) => ''); // Initialize empty board
  Player currentPlayer = Player.X;

  void _handleTap(int index) {
    if (squares[index] == '' && _checkWinner() == '') {
      setState(() {
        squares[index] = currentPlayer
            .toString()
            .split('.')
            .last; // Get player symbol (X or O)
        currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
        if (currentPlayer == Player.O) {
          _computerMove();
        }
        String winner = _checkWinner();
        if (winner != '') {
          _updateWinnerMessage(winner);
        } else if (currentPlayer == Player.O) {
          _computerMove();
        }
      });
    }
  }

  String _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (squares[i] == squares[i + 3] &&
          squares[i] == squares[i + 6] &&
          squares[i] != '') {
        return squares[i];
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (squares[i] == squares[i + 1] &&
          squares[i] == squares[i + 2] &&
          squares[i] != '') {
        return squares[i];
      }
    }

    // Check diagonals
    if (squares[0] == squares[4] &&
        squares[0] == squares[8] &&
        squares[0] != '') {
      return squares[0];
    }
    if (squares[2] == squares[4] &&
        squares[2] == squares[6] &&
        squares[2] != '') {
      return squares[2];
    }

    // Check for tie
    bool isTie = true;
    for (int i = 0; i < 9; i++) {
      if (squares[i] == '') {
        isTie = false;
        break;
      }
    }
    if (isTie) {
      return 'Tie';
    }

    return '';
  }

  void _resetGame() {
    setState(() {
      squares = List.generate(9, (_) => '');
      currentPlayer = Player.X;
      _updateWinnerMessage(''); // Clear winner message
    });
  }

  void _computerMove() {
    int? bestMoveIndex = _findBestMove(Player.O);
    if (bestMoveIndex != null) {
      _handleTap(bestMoveIndex);
    }
  }

  int? _findBestMove(Player player) {
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (squares[i] == '') {
        availableMoves.add(i);
      }
    }
    if (availableMoves.isEmpty) return null;
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  void _updateWinnerMessage(String winner) {
    setState(() {
      currentPlayer = Player.X; // Reset current player for next game
    });
  }

  Widget _buildSquare(int index) {
    return MaterialButton(
      onPressed: () => _handleTap(index),
      color: Colors.blue[200],
      minWidth: 100,
      height: 100,
      child: Text(
        squares[index],
        style: TextStyle(fontSize: 40),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String winner = _checkWinner();

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[200],
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winner == ''
                  ? 'Current Player: ${currentPlayer == Player.X ? "X" : "O"}'
                  : 'Winner: $winner',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(0),
                SizedBox(width: 10),
                _buildSquare(1),
                SizedBox(width: 10),
                _buildSquare(2),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(3),
                SizedBox(width: 10),
                _buildSquare(4),
                SizedBox(width: 10),
                _buildSquare(5),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(6),
                SizedBox(width: 10),
                _buildSquare(7),
                SizedBox(width: 10),
                _buildSquare(8),
              ],
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: _resetGame,
              child: Text('Reset Game'),
              color: Colors.green[300],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}
