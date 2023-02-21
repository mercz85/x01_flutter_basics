import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final Function(bool?) checkBoxCallback;

  TaskTile(
      {required this.taskTitle,
      this.isChecked = false,
      required this.checkBoxCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.black87,
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        onChanged: checkBoxCallback,
        value: isChecked,
        side: const BorderSide(
          color: Colors.black87,
          width: 1.5,
        ),
        activeColor: Colors.lightBlueAccent,
      ),
    );
  }
}

// class TaskCheckBox extends StatelessWidget {
//   final bool checkBoxState;
//   final Function(bool?) toggleCheckBoxState; //[CallBack Function]

//   TaskCheckBox(
//       {required this.checkBoxState, required this.toggleCheckBoxState});

//   @override
//   Widget build(BuildContext context) {
//     return Checkbox(
//       side: const BorderSide(
//         color: Colors.black87,
//         width: 1.5,
//       ),
//       value: checkBoxState,
//       onChanged: toggleCheckBoxState,
//       activeColor: Colors.lightBlueAccent,
//     );
//   }
// }
