import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnertitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _clearGame();
              scoreO = 0;
              scoreX = 0;
            },
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text(
          'TicTacToe',
          style: TextStyle(fontSize: 40),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.deepPurple,
                Colors.indigo,
                Colors.purpleAccent
              ])),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 800,
              width: 800,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      image: AssetImage('images/1.png'), fit: BoxFit.cover)),
            ),
          ),
          new Center(
            child: new ClipRect(
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 9.5, sigmaY: 7),
                child: new Container(
                  width: 1080,
                  height: 1080,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(0.0),
                      color: Colors.grey.shade200.withOpacity(0.1)),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                getScoreBoard(),
                SizedBox(
                  height: 20,
                ),
                getResultButton(),
                SizedBox(
                  height: 20,
                ),
                getGridView(),
                getTurn(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Colors.white, width: 1),
          ),
          onPressed: () {
            gameHasResult = false;
            _clearGame();
          },
          child: Text(
            '$winnertitle , tap to Play again.',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 25),
          ),
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn  O' : 'Turn  X',
      style: TextStyle(
          color: Colors.white, fontSize: 32, fontWeight: FontWeight.w500),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  xOrOList[index],
                  style: TextStyle(
                      fontSize: 39.5,
                      color: xOrOList[index] == 'X'
                          ? Colors.white
                          : Colors.redAccent[400],
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void tapped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (xOrOList[index] != '') {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        xOrOList[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      _setResult(xOrOList[3], 'Winner is ' + xOrOList[3]);
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      _setResult(xOrOList[6], 'Winner is ' + xOrOList[6]);
      return;
    }
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }

    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2], 'Winner is ' + xOrOList[2]);
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      _setResult(xOrOList[0], 'Winner is ' + xOrOList[0]);
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      _setResult(xOrOList[1], 'Winner is ' + xOrOList[1]);
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      _setResult(xOrOList[2], 'Winner is ' + xOrOList[2]);
      return;
    }
    if (filledBoxes == 9) {
      _setResult('', 'Draw!');
    }
  }

  Widget getScoreBoard() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player O',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreO',
                  style: TextStyle(color: Colors.white, fontSize: 27.0),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(color: Colors.white, fontSize: 30.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$scoreX',
                  style: TextStyle(color: Colors.white, fontSize: 27.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnertitle = title;
      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == 'O') {
        scoreO = scoreO + 1;
      } else {
        scoreX = scoreX + 1;
        scoreO = scoreO + 1;
      }
    });
  }

  void _clearGame() {
    setState(() {
      for (int i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
