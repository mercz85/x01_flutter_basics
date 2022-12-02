import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

const double kTopBarHeight = 40;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //[auth]
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User loggedInUser;

  void getCurrentUser() {
    try {
      loggedInUser = _auth.currentUser!;
      print(loggedInUser.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: kTopBarHeight,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: kTopBarHeight,
                child: const Text(
                  '⚡️Chat',
                  style: TextStyle(
                      fontSize: kTopBarHeight * 0.75,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: kTopBarHeight,
                  ),
                  onPressed: () {
                    //[auth] signOut
                    _auth.signOut();
                    Navigator.pop(context);
                  }),
            ],
          ),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      //Do something with the user input.
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    //Implement send functionality.
                  },
                  child: const Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
