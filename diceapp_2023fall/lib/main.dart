
import 'package:flutter/material.dart';

import 'clikabledice.dart';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.brown,
        body: Center(
          child: Dice(),
        ),
      ),
    );
  }
}


