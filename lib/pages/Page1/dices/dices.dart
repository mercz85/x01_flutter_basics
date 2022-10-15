import 'dart:math';

import 'package:flutter/material.dart';

class Dices extends StatefulWidget {
  Dices({Key? key}) : super(key: key);

  @override
  State<Dices> createState() => _DicesState();
}

class _DicesState extends State<Dices> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
//[setState]
  void changeBoth() {
    setState(() {
      //[math_Random]
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //[double.infinity]
      height: double.infinity,
      color: Colors.red.shade500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  //[Interpolation]
                  child: Image.asset('assets/dices/dice$leftDiceNumber.png'),
                  onPressed: () {
                    setState(() {
                      leftDiceNumber = Random().nextInt(6) + 1;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextButton(
                  child: Image.asset('assets/dices/dice$rightDiceNumber.png'),
                  onPressed: () {
                    setState(() {
                      rightDiceNumber = Random().nextInt(6) + 1;
                    });
                  },
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              changeBoth();
            },
            style: ButtonStyle(
                //[MaterialStateProperty_Color]
                //backgroundColor: MaterialStateProperty.all(Colors.purple.shade100)),
                backgroundColor: MaterialStateProperty.all(Colors.purple)),
            child: const Text('CHANGE BOTH',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.pink,
                  fontSize: 20,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                )),
          )
        ],
      ),
    );
  }
}
