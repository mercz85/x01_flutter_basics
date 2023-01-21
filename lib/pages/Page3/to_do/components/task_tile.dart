import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.black87,
      title: Text('This is a task.'),
      trailing: Checkbox(
        side: const BorderSide(
          color: Colors.black87,
          width: 1.5,
        ),
        value: false,
        onChanged: ((chaged) {}),
      ),
    );
  }
}
