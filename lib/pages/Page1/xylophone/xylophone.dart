import 'package:audioplayers/audioplayers.dart'; //[playAudio]
import 'package:flutter/material.dart';

class Xilophone extends StatelessWidget {
  const Xilophone({Key? key}) : super(key: key);
//[playAudio]
  void playSound(int noteNumber) {
    final player = AudioCache();
    player.play('notes/note$noteNumber.wav');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              playSound(1);
            },
            child: const Text(''),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              playSound(2);
            },
            child: Text(''),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
            ),
          ),
        ),
        XilophoneTab(noteNumber: 3, color: Colors.yellow),
        XilophoneTab(noteNumber: 4, color: Colors.green),
        XilophoneTab(noteNumber: 5, color: Colors.teal),
        XilophoneTab(noteNumber: 6, color: Colors.blue),
        XilophoneTab(noteNumber: 7, color: Colors.purple)
      ],
    );
  }
}

class XilophoneTab extends StatelessWidget {
  //const XilophoneTab({Key? key}) : super(key: key);
  final int noteNumber;
  final Color color;
  XilophoneTab({required this.noteNumber, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1, //default is 1
      child: TextButton(
        onPressed: () {
          //[playAudio]
          final player = AudioCache();
          player.play('notes/note$noteNumber.wav');
        },
        child: Text(''),
        //[styleFrom]
        style: TextButton.styleFrom(
            backgroundColor:
                color), //ButtonStyle(backgroundColor: MaterialStateProperty.all(color),),
      ),
    );
  }
}
