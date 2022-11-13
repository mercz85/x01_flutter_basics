import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/constants.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/screens/chat_screen.dart';

/*
[Keyboard] [Error01]: when using textfields, the keyboard pops up and you get pixels overflow error
https://www.youtube.com/watch?v=2E9iZgg5TOY

https://stackoverflow.com/questions/46551268/when-the-keyboard-appears-the-flutter-widgets-resize-how-to-prevent-this
*/
class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //[Error01]: resizeToAvoidBottomInset avoid textinput to disappear (resizes?) when keyboard appears
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        //[Error01]: SingleChildScrollView avoid pixels overflow
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              //[HeroAnimation]
              Hero(
                tag: kLogoTag,
                key: Key('logo_registration'),
                child: Container(
                  height: 200.0,
                  child: Image.asset('assets/flash_chat/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ChatScreen.id);
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
