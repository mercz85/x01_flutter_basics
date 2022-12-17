import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
/*
[Firestore] Create index:
https://stackoverflow.com/questions/50305328/firestore-whereequalto-orderby-and-limit1-not-working
https://firebase.google.com/docs/firestore/query-data/indexing
 */

const double kTopBarHeight = 40;
//[firestore]
final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //[auth]
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //late User loggedInUser;

  final messageTextController = TextEditingController();
  String messageText = '';

  void getCurrentUser() {
    try {
      loggedInUser = _auth.currentUser!;
      print(loggedInUser?.email);
    } catch (e) {
      print(e);
    }
  }
//[firestore] GET
/*
  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs) {
      print(message.data());
    }

    // Prints:
    // I/flutter (28002): {sender: hola@gmail.com, text: Buenos dias}
    // I/flutter (28002): {sender: angela@email.com, text: Hello}
  }
*/
//[firestore] STREAM SUBSCRIPTION
/*
  void messagesStream() async {
    //Listen to the stream of messages coming from the database
    //when a new message is added into the database, we receive a new snapshot
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }
  */

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //[keyboardHide] GestureDetector + FocusScope -> onTap: () => FocusScope.of(context).unfocus(),
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
          MessagesStream(),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    messageTextController.clear();
                    try {
                      //[firestore] ADD + timestamp to order (¿or customize firebase document id?)
                      _firestore.collection('messages').add({
                        'timestamp': FieldValue.serverTimestamp(),
                        'text': messageText,
                        'sender': loggedInUser?.email,
                      }).then((value) => print('sent ok'));
                    } catch (e) {
                      print(e);
                    }
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

class MessagesStream extends StatelessWidget {
  //const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //[firestore] Stream Subscription + StreamBuilder + order
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(), //_firestore.collection('messages').snapshots() - We order it first

      builder: (context, snapshot) {
        List<Widget> messageBubbles = [];

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot
            .data!.docs.reversed; //.reversed --> Last message at the bottom
        final currentUser = loggedInUser?.email;
        String messageText = '';
        String messageSender = '';
        Widget messageBubble;
        //print(messages[0]);
        for (var message in messages) {
          messageText = message['text'];
          messageSender = message['sender'];

          messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          //Expanded to avoid the list push down the Container to send messages
          child: ListView(
            //[ListView] to make it scrollable and stick to bottom
            reverse: true, //Stick list to bottom
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            //[keyboardHide] ListView + keyboardDismissBehavior
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  //const MessageBubble({Key? key}) : super(key: key);
  MessageBubble({required this.sender, required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.blueGrey,
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
                topLeft: isMe ? const Radius.circular(30) : Radius.circular(0),
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30),
                topRight: isMe
                    ? const Radius.circular(0)
                    : const Radius.circular(30)),
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
