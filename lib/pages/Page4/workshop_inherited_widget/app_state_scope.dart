import 'package:flutter/material.dart';

import 'app_state.dart';

//[InheritedWidget] 2. We implement our AppStateScope - InheritedWidget
class AppStateScope extends InheritedWidget {
  final AppState data;

  AppStateScope(
    this.data, {
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);
  //Method to access the inherited widget
  static AppState of(BuildContext context) {
    //Try to find the same InheritedW with the type you passed and return it to you
    //and it will notify IW that there is a new context to listen to data objects,
    //we need to notify for rebuilds
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  //We check if we should notify listeners
  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}
