import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page1/my_card/my_card.dart';
import 'package:x01_flutter_basics/pages/Page2/view.dart';

import 'pages/Page1/view.dart';

/*
NOTES
1. Hex Opacity Values:
   https://gist.github.com/creativecreatorormaybenot/8710f6f752f6a0f2cae13abb538f0e8e#hex-opacity-values
#0A0E21 = 0xFF0A0E21
2. Theme and ColorSchema
  https://docs.flutter.dev/release/breaking-changes/theme-data-accent-properties
3. Default values of ColorSheme.dark()
  https://api.flutter.dev/flutter/material/ColorScheme/ColorScheme.dark.html
*/

//[snippets] mateapp --> creates a new almost empty MaterialApp
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//[bottomNavigationBar]
  int _currentPage = 0;

  final List<Widget> _pages = [
    Page1(),
    Page2(),
    Container(color: Colors.amber),
  ];

  //onSurface: Colors.red,);

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Color(0xFF0A0E21);
    final ColorScheme colorScheme = ThemeData.dark().colorScheme.copyWith(
          primary: baseColor,
          secondary: Colors.purple,
          surface: baseColor,
        );
    final ThemeData theme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: baseColor,
      bottomAppBarColor: baseColor,
      colorScheme: colorScheme,
    );

    return MaterialApp(
      // [appTheme]
      theme: theme,
      //themeMode: ThemeMode.dark,
      title: 'Material App',
      debugShowCheckedModeBanner: false, //remove DEBUG banner
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: _pages[_currentPage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: theme.bottomAppBarColor, //************** */
          type: BottomNavigationBarType.fixed, // > 3 BottomNavigationBarItems
          currentIndex: _currentPage,
          onTap: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Page1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Page2',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.spa),
              label: 'Page3',
            ),
          ],
        ),
      ),
    );
  }
}
