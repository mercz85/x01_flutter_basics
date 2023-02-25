// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/models/task_data.dart';

import '../models/task.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //[provider] Consumer
    return Consumer<TaskData>(
      //taskData = Provider.of<TaskData>(context)
      builder: (context, taskData, child) {
        //[ListView.builder]
        return ListView.builder(
            itemCount: taskData.tasksCount,
            itemBuilder: (context, index) {
              return TaskTile(
                taskTitle: taskData.tasks[index].name,
                isChecked: taskData.tasks[index].isDone,
                checkBoxCallback: (bool? checkBoxState) {
                  // setState(() {
                  //   Provider.of<TaskData>(context).tasks[index].toggleDone();
                  // });
                },
              );
            });
      },
    );
  }
}
