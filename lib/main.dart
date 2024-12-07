// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Tictactoe(),
//   ));
// }

// class Tictactoe extends StatelessWidget {
//   Tictactoe({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xff378805),
//         foregroundColor: Colors.white,
//         title: Text("Tic-Tac-Toe"),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         height: double.infinity,
//         width: double.infinity,
//         child:Center(
//         child: Column(
//           children: [
//             Container(
//               height: 400,
//               width: 400,
//               // color: Color(0xff378805),
//               child: GridView.count(
//                 padding: EdgeInsets.all(10),
//                 crossAxisCount: 3,
//                 crossAxisSpacing: 7,
//                 mainAxisSpacing: 7,
//                 childAspectRatio: 1,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                  Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                  Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                     color: Color(0xff86dc3d),),),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 15,
//             ),
//            Container(
//             height: 50,
//             width: 150,
//             decoration: BoxDecoration(
//               color: Colors.green,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               children: [
//                 SizedBox(width: 25),
//                 Icon(Icons.replay_outlined,color: Colors.white,),
//                 // SizedBox(width: 10),
//                 TextButton(onPressed: (){}, child: Text("Play Again",style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16
//                 ),))
//               ],
//             ),
//            )
//           ],
//         ),
//       ),
//               ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Tictactoe(),
  ));
}

class Tictactoe extends StatefulWidget {
  @override
  _TictactoeState createState() => _TictactoeState();
}

class _TictactoeState extends State<Tictactoe> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  List<int> winningLine = [];

  void _handleTap(int index) {
    if (board[index] == '' && winner == '') {
      setState(() {
        board[index] = currentPlayer;
        final result = _checkWinner(currentPlayer);
        if (result != null) {
          winner = '$currentPlayer wins!';
          winningLine = result;
        } else if (!board.contains('')) {
          winner = 'It\'s a draw!';
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  List<int>? _checkWinner(String player) {
    const winPatterns = [
      [0, 1, 2], // Row 1
      [3, 4, 5], // Row 2
      [6, 7, 8], // Row 3
      [0, 3, 6], // Column 1
      [1, 4, 7], // Column 2
      [2, 5, 8], // Column 3
      [0, 4, 8], // Diagonal 1
      [2, 4, 6], // Diagonal 2
    ];
    for (var pattern in winPatterns) {
      if (pattern.every((index) => board[index] == player)) {
        return pattern;
      }
    }
    return null;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      winningLine = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdac98),
      appBar: AppBar(
        backgroundColor: Color(0xffdc8e90),
        foregroundColor: Colors.white,
        title: Text("TicTacToe"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: 400,
                    child: GridView.builder(
                      padding: EdgeInsets.all(10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 7,
                        mainAxisSpacing: 7,
                      ),
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _handleTap(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffdc8e90),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                board[index],
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (winner.isNotEmpty && winningLine.isNotEmpty)
                    CustomPaint(
                      size: Size(400, 400),
                      painter: StrikePainter(winningLine),
                    ),
                ],
              ),
              SizedBox(height: 15),
              if (winner.isNotEmpty)
                Text(
                  winner,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: _resetGame,
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xffdc8e90),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.replay_outlined, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Play Again",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StrikePainter extends CustomPainter {
  final List<int> winningLine;

  StrikePainter(this.winningLine);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final gridSize = size.width / 3;
    final start = Offset(
      (winningLine.first % 3) * gridSize + gridSize / 2,
      (winningLine.first ~/ 3) * gridSize + gridSize / 2,
    );
    final end = Offset(
      (winningLine.last % 3) * gridSize + gridSize / 2,
      (winningLine.last ~/ 3) * gridSize + gridSize / 2,
    );

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
