import 'package:flutter/material.dart';
import 'models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  //[provider] we pass the provider with its context
  final TaskData taskDataProvider;
  AddTaskScreen(this.taskDataProvider);

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 40,
        ),
        child: Column(
          children: [
            const Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 20,
              ),
            ),
            TextField(
              style: const TextStyle(
                color: Colors.black87,
              ),
              cursorColor: Colors.lightBlue,
              cursorHeight: 20,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
              autofocus: true, //opened keyboard
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.lightBlueAccent),
              ),
              onPressed: () {
                //[provider] notifyListeners
                // Provider.of<TaskData>(context, listen: true)
                //     .addTask(newTaskTitle);
                taskDataProvider.addTask(newTaskTitle);
                Navigator.pop(context);
              },
              child: const Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
