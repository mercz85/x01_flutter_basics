import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/models/task.dart';

//[provider] ChangeNotifier
class TaskData extends ChangeNotifier {
  List<Task> _tasks = [Task(name: 'Buy cat food')];
  //To avoid acces to list.add without using addTask (notifyListeners) we make
  // tasks private and create a get with an UnmodifableListView
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get tasksCount {
    return _tasks.length;
  }

  void addTask(String newTitle) {
    final task = Task(name: newTitle);
    _tasks.add(task);
    //[provider] notifyListeners
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
