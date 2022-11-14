# x01_flutter_basics

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## REMOVE Warning: Mapping new ns to old ns
https://stackoverflow.com/questions/68789848/warning-mapping-new-ns-to-old-ns-and-emulator-stopping-abruptly
https://stackoverflow.com/questions/66992420/when-i-try-to-sync-project-with-gradle-files-a-warning-pops-up

## HOW TO: [search topic keyword in project]
splashScreen [flutter_native_splash](https://www.youtube.com/watch?v=8ME8Czqc-Oc ; https://pub.dev/packages/flutter_native_splash )
3) To create the flutter_native_splash run in your vscode Terminal (inside your project folder):
flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml

bottomNavigationBar [bottomNavigationBar] (https://www.youtube.com/watch?v=XasJNwAlCy4&list=PLutrh4gv1YI8ap4JO23lN81JOSZJ3i5OO&index=13)
bottomNavigationBar > 3 BottomNavigationBarItems [bottomNavigationBar > 3 items](https://stackoverflow.com/questions/52199196/flutter-bottomnavigationbar-not-working-with-more-than-three-items)

customTabs with PageView [customTabButton](https://www.youtube.com/watch?v=mhcgTYzZPv0)
tab navigation in page [tabs] 

assets/images [images]

fonts [fonts]

usefull snippets [snippets] (https://marketplace.visualstudio.com/items?itemName=Nash.awesome-flutter-snippets)

simple setState for Statefull widget [setState]
[math_Random] [Interpolation] [MaterialStateProperty_Color] [double.infinity]

get style from widget to modify it [styleFrom] 
[playAudio]

[alertDialog] 
how to add minHeight to a widget [minHeight]

[appTheme] [colorScheme]
0. Color from hex: #0A0E21 = 0xFF0A0E21  (ex. Color(0xFF0A0E21))
1. Hex Opacity Values:
   https://gist.github.com/creativecreatorormaybenot/8710f6f752f6a0f2cae13abb538f0e8e#hex-opacity-values
2. Theme and ColorSchema
  https://docs.flutter.dev/release/breaking-changes/theme-data-accent-properties
3. Default values of ColorSheme.dark()
  https://api.flutter.dev/flutter/material/ColorScheme/ColorScheme.dark.html

FontAwesomeIcons [icons]

how to align text to baseline in Row [rowBaselinAlignText]
[slider] 
SliderTheme.of(context).copyWith(...) [sliderTheme]
[doubleToInt]

compose a button from RawMaterialButton (instead of FAB)[buttonComposition]

 to see different 'views' in the same Tab clicking on button[extractMethod]

 [Visibility] (https://stackoverflow.com/questions/44489804/how-to-show-hide-widgets-programmatically-in-flutter)

 Ignore file secrets.json to store APIs personal keys, etc [.gitignore]

 [geolocation] 
 to use when the app doesn´t ask for permissions properly [permissions]

 to read from JSON [jsonDecode]
 [http]
 how to read a JSON file and parse json list to Map [readJSONFile]

 [spinner]

 pass data between screens using Navigator [passDataNavigator]
 pass data to statefull widget to it´s state [passDataConstructor]

 check for strings [NullOrEmpty]

 shift from Material to Cupertino depending on Platform [Cupertino] [Platform]
 
 add headers like for example api keys [HTTPHeaders]
 get asyncronous information and update screen [async]
 api comsumption [api]

 using namedRoutes to navigate between screens [namedRoutes]
 when using TEXTFIELDS, the KEYBOARD pops up and you get BOTTOM OVERFLOWED by PIXELS error [Error01] [Keyboard]
you need: 2 Hero Widgets, 1 shared tag, 1 Navigator based screen transition[HeroAnimation]
you need: 1 Ticker, 1 AnimationController, 1 Animation value [CustomAnimation] [CurvedAnimation] [ColorTween]