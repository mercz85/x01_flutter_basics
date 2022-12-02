import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:x01_flutter_basics/pages/Page3/flash_chat/constants.dart';

import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AnimationController animationController;

  //[auth]
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';

  //[GoogleSignIn]
  final googleSignIn = GoogleSignIn();

  Future<OAuthCredential> googleLogin() async {
    //Shows pop-up to select Google account
    final googleUser = await googleSignIn.signIn();
    //Authenticates the user
    final googleAuth = await googleUser!.authentication;
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return credential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                key: Key('logo_login'),
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
                  onChanged: (value) {
                    email = value;
                  },
                  //[kConst.copywith]
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password.'),
                obscureText: true,
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        //[auth]
                        UserCredential newUser =
                            await _auth.signInWithEmailAndPassword(
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
                      'Log In',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  //[GoogleSignIn]
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        OAuthCredential credential = await googleLogin();
                        UserCredential newUser =
                            await _auth.signInWithCredential(credential);
                        if (newUser.user != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Login with Google',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
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
