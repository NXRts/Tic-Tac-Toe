import 'package:flutter/material.dart';
import 'game_page.dart';
import 'input_page.dart'; // Import halaman input untuk memulai permainan baru

class ResultPage extends StatelessWidget {
  final String winnerName;
  final String player1Name;
  final String player2Name;
  final bool startNewGame;

  ResultPage({
    required this.winnerName,
    required this.player1Name,
    required this.player2Name,
    this.startNewGame = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Permainan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pemenang: $winnerName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (startNewGame) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                        player1Name: player1Name,
                        player2Name: player2Name,
                      ),
                    ),
                  );
                } else {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                startNewGame ? 'Main Lagi' : 'Tutup',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
