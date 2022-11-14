import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/constants.dart';

import '../components/rounded_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WellcomeScreen extends StatefulWidget {
  WellcomeScreen({Key? key}) : super(key: key);

  static const String id = 'wellcome_screen';

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

//[CustomAnimation] SingleTickerProviderStateMixin (1 AnimationController) vs TickerProviderStateMixin (> 1 AnimationController)
class _WellcomeScreenState extends State<WellcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController animationControllerIconSize;
  //Animation: Not necessary if you want to use just the controller value
  late Animation animationIconSize;

  late AnimationController animationControllerTitleColor;
  late Animation animationTitleColor;

  @override
  void initState() {
    //[CustomAnimation] AnimationController animationControllerIconSize
    animationControllerIconSize = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      upperBound: 60, //change value range: 0 to 60 (default 0 to 1)
    )
      ..forward()
      ..addListener(() {
        //Listen to value changes to modify state
        setState(() {});
      });

    //[CurvedAnimation] If you don´t want value progression to be linear
    animationIconSize = CurvedAnimation(
      parent: animationControllerIconSize,
      curve: Curves.decelerate,
    );

    //[CustomAnimation] AnimationController animationControllerTitleColor
    animationControllerTitleColor = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        //Listen to value changes to modify state
        setState(() {});
      })
      ..addStatusListener((status) {
        //[CustomAnimation] animation loop
        if (status == AnimationStatus.completed) {
          animationControllerTitleColor.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationControllerTitleColor.forward();
        }
      });
    //[ColorTween]
    animationTitleColor =
        ColorTween(begin: Colors.yellow.shade800, end: Colors.white)
            .animate(animationControllerTitleColor);

    super.initState();
  }

  @override
  void dispose() {
    //[CustomAnimation] dispose
    animationControllerIconSize.dispose();
    animationControllerTitleColor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                //[HeroAnimation]
                Hero(
                  tag: kLogoTag,
                  key: const Key('logo_wellcome'),
                  child: Container(
                    child: Image.asset('assets/flash_chat/logo.png'),
                    //[CustomAnimation] controller.value use
                    height: animationControllerIconSize.value,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    //[ColorTween] animation.value use
                    color: animationTitleColor.value,
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
