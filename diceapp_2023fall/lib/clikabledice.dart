import 'package:flutter/material.dart';
import 'dart:math';

class Dice extends StatefulWidget {
  @override
  _DiceState createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int diceNumber1 = 1;
  int diceNumber2 = 1;
  void rollDice1() {
    setState(() {
      diceNumber1 = Random().nextInt(6) + 1;
    });
  }
  void rollDice2() {
    setState(() {
      diceNumber2 = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Roll the Dice!',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 20),
        Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  rollDice1();
                },
                child: Image.asset(
                  'images/dice$diceNumber1.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: (){
                  rollDice2();
                },
                child: Image.asset(
                  'images/dice$diceNumber2.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),


          ],
        ),
        SizedBox(height: 30),

      ],
    );
  }
}
