import 'package:flutter/material.dart';
import 'result_page.dart';

class GamePage extends StatefulWidget {
  final String player1Name;
  final String player2Name;

  GamePage({required this.player1Name, required this.player2Name});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, '')); // Papan permainan 3x3
  bool player1Turn = true; // Menandai giliran pemain 1

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Player 1: ${widget.player1Name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            _buildBoard(),
            Text(
              'Player 2: ${widget.player2Name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return GestureDetector(
              onTap: () {
                _onTileTapped(row, col);
              },
              child: Container(
                width: 80.0,
                height: 80.0,
                margin: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    board[row][col],
                    style: TextStyle(
                      fontSize: 40.0,
                      color: board[row][col] == 'X' ? Colors.red : board[row][col] == 'O' ? Colors.green : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  void _onTileTapped(int row, int col) {
    if (board[row][col].isEmpty) {
      setState(() {
        board[row][col] = player1Turn ? 'X' : 'O';
        player1Turn = !player1Turn; // Ganti giliran pemain
        _checkWinner(row, col);
      });
    }
  }

  void _checkWinner(int row, int col) {
    String symbol = board[row][col];
    // Periksa baris dan kolom
    if (board[row][0] == symbol && board[row][1] == symbol && board[row][2] == symbol ||
        board[0][col] == symbol && board[1][col] == symbol && board[2][col] == symbol) {
      _showResult(symbol);
    }
    // Periksa diagonal
    if ((board[0][0] == symbol && board[1][1] == symbol && board[2][2] == symbol) ||
        (board[0][2] == symbol && board[1][1] == symbol && board[2][0] == symbol)) {
      _showResult(symbol);
    }
    // Periksa seri
    if (!board.any((row) => row.any((cell) => cell.isEmpty))) {
      _showResult('Seri');
    }
  }

  void _showResult(String winner) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          winnerName: winner,
          player1Name: widget.player1Name,
          player2Name: widget.player2Name,
        ),
      ),
    );
  }
}
