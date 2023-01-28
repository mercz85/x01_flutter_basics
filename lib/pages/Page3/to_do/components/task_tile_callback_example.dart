import 'package:flutter/material.dart';

class TaskTileCallbackExample extends StatefulWidget {
  const TaskTileCallbackExample({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskTileCallbackExample> createState() =>
      _TaskTileCallbackExampleState();
}

class _TaskTileCallbackExampleState extends State<TaskTileCallbackExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 20,
        //[MediaQuery]
        right: MediaQuery.of(context).size.width / 4,
      ),
      textColor: Colors.black87,
      title: Text(
        'Callback example.',
        style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
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
        color: Colors.purple,
        width: 1.5,
      ),
      value: checkBoxState,
      onChanged: toggleCheckBoxState,
      activeColor: Colors.purple,
    );
  }
}
