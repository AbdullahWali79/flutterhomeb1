import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void playSound(int soundNumber) {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/note$soundNumber.wav"),
    );
  }

  Expanded createButton({Color? color, int soundNumber = 1}) {
    return Expanded(
      child: ElevatedButton(
        child: Text("Button $soundNumber"),
        onPressed: () {
          playSound(soundNumber);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              createButton(color: Colors.red, soundNumber: 1),
              createButton(color: Colors.green, soundNumber: 2),
              createButton(color: Colors.yellow, soundNumber: 3),
            ],
          ),
        ),
      ),
    );
  }
}
