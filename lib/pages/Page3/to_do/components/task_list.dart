// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../models/task.dart';
import 'task_tile.dart';

class TasksList extends StatefulWidget {
  const TasksList(this.tasks);
  final List<Task> tasks;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    //[ListView.builder]
    return ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            taskTitle: widget.tasks[index].name,
            isChecked: widget.tasks[index].isDone,
            checkBoxCallback: (bool? checkBoxState) {
              setState(() {
                widget.tasks[index].toggleDone();
              });
            },
          );
        });
    //[ListView]
    /*
    return ListView(
      children: [
        TaskTile(taskTitle: tasks[0].name, isChecked: tasks[0].isDone),
        TaskTile(taskTitle: tasks[1].name, isChecked: tasks[1].isDone),
        TaskTile(taskTitle: tasks[2].name, isChecked: tasks[2].isDone),
      ],
    );
    */
  }
}
