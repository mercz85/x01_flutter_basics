import 'package:flutter/foundation.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/models/task.dart';

//[provider] ChangeNotifier
class TaskData extends ChangeNotifier {
  List<Task> tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'buy eggs'),
    Task(name: 'buy cat food')
  ];

  int get tasksCount {
    return tasks.length;
  } //int get taskCount => tasks.length;

  void addTask(String newTitle) {
    final task = Task(name: newTitle);
    tasks.add(task);
    //[provider] notifyListeners
    notifyListeners();
  }
}
