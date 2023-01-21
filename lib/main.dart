import 'package:flutter/material.dart';
import 'package:x01_flutter_basics/pages/Page2/view.dart';
import 'package:x01_flutter_basics/pages/Page3/view.dart';

import 'pages/Page1/view.dart';
//[firebase]
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/Page4/view.dart';

//[snippets] mateapp --> creates a new almost empty MaterialApp
//void main() => runApp(MyApp());
Future<void> main() async {
  //[firebase]
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

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
    Page3(),
    Page4(),
  ];

  //onSurface: Colors.red,);

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Color(0xFF0A0E21);

    //[colorScheme] examples
    final ColorScheme colorScheme = ThemeData.dark().colorScheme.copyWith(
          primary: baseColor,
          secondary: Colors.purple,
          surface: baseColor,
        );

    final ColorScheme colorSchemeSeed =
        ColorScheme.fromSeed(seedColor: Colors.purple);

    //[appTheme] examples
    final ThemeData theme = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: baseColor,
      bottomAppBarColor: baseColor,
      colorScheme: colorScheme,
    );

    final ThemeData theme2 = ThemeData.from(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
        backgroundColor: const Color(0xFF09ED8A),
        accentColor: Colors.purple,
      ),
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
          // [appTheme]
          backgroundColor: theme.bottomAppBarColor,
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
              label: 'Page3 State',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_baseball),
              label: 'Page4',
            ),
          ],
        ),
      ),
    );
  }
}
