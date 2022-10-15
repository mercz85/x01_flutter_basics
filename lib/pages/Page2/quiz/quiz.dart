import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:x01_flutter_basics/pages/Page2/quiz/quiz_brain.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  int questionNumber = 0;

  List<Icon> scoreKeeper = [];
  void checkAnswer(bool answer) {
    setState(() {
      if (quizBrain.getQuestionAnswer() == answer) {
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.isFinished() == false) {
        quizBrain.nextQuestion();
      } else {
        showFinishAlert();
        quizBrain.reset();
        scoreKeeper.clear();
      }
    });
  }

//[alertDialog]
  void showFinishAlert() {
    Alert(
      context: context,
      style: AlertStyle(animationDuration: Duration(milliseconds: 600)),
      type: AlertType.success,
      title: "CONGRATULATIONS!",
      desc: "Let's start again",
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                quizBrain.getQuestionText(),
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () {
              checkAnswer(true);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.green),
            child: const Text(
              'True',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: () {
              checkAnswer(false);
            },
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'False',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: scoreKeeper,
            ),
          ),
        )
      ],
    );
  }
}
