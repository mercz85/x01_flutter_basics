import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WellcomeScreen extends StatefulWidget {
  WellcomeScreen({Key? key}) : super(key: key);

  static const String id = 'wellcome_screen';

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset('assets/flash_chat/logo.png'),
                  height: 60.0,
                  //height: controller.value,
                  //height: animation.value * 100,
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              text: 'Login',
              onPressed: () {
                //Go to login screen.
                //[namedRoutes]
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              text: 'Register',
              onPressed: () {
                //Go to registration screen.
                //[namedRoutes]
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
