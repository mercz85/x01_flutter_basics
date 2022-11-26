import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/constants.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/screens/chat_screen.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/constants.dart';

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
  //[auth]
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool passwordObscureText = true;

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
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                obscureText: passwordObscureText,
                //keyboardType: TextInputType.visiblePassword,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  suffixIcon: GestureDetector(
                    child: Icon(Icons.visibility,
                        color: passwordObscureText == true
                            ? Colors.white
                            : Colors.grey),
                    onTap: () {
                      setState(() {
                        passwordObscureText =
                            passwordObscureText == true ? false : true;
                      });
                    },
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
                    onPressed: () async {
                      try {
                        //[auth]
                        UserCredential newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser.user != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
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
