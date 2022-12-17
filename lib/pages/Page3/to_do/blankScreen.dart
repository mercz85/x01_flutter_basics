import 'package:flutter/material.dart';

class BlankScreen extends StatefulWidget {
  BlankScreen({Key? key}) : super(key: key);

  static const String id = '';

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade300,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Center(
              child: Text(
                'EVA',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
