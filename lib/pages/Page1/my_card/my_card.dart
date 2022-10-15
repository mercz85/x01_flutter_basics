import 'package:flutter/material.dart';
/* 
BUG 83108
[Flutter 2.2] ListTile ignores tileColor/selectedTileColor if parent Container has color #83108
https://github.com/flutter/flutter/issues/83108
Solution:
https://github.com/flutter/flutter/pull/86355/commits/9341a6b1d0d2852ee3c7eb413bbbdc9327f425c8
 
 */

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    //To fix BUG 83108 we use Material instead of Container
    return Material(
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            //[images]
            backgroundImage: AssetImage('assets/gatito.jpg'),
            radius: 60,
          ),
          Text(
            'Milo the kitten',
            //[fonts]
            style: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('FLUTTER DEVELOPER',
              //[fonts]
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(
            height: 20.0,
            width: 150,
            child: Divider(
              thickness: 0.8,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.teal,
              ),
              title: Text(
                '+34 123 456 789',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.pink,
                ),
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: Icon(
                Icons.mail,
                color: Colors.teal,
              ),
              title: Text(
                'milo@email.com',
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*

                 child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.teal,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        'johnnydeep@gmail.com',
                        style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 20.0),
                      ),
                    ],
                  ),

*/