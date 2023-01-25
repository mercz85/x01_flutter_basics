import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      textColor: Colors.black87,
      title: Text(
        'This is a task.',
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckBox(
        checkBoxState: isChecked,
        //[CallBack Function] to setState down the tree
        toggleCheckBoxState: (bool? newValue) {
          setState(() {
            isChecked = newValue!;
          });
        },
      ),
    );
  }
}

class TaskCheckBox extends StatelessWidget {
  final bool checkBoxState;
  final Function(bool?) toggleCheckBoxState; //[CallBack Function]

  TaskCheckBox(
      {required this.checkBoxState, required this.toggleCheckBoxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: const BorderSide(
        color: Colors.black87,
        width: 1.5,
      ),
      value: checkBoxState,
      onChanged: toggleCheckBoxState,
      activeColor: Colors.lightBlueAccent,
    );
  }
}
