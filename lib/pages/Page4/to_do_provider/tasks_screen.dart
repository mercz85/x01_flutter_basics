import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/add_task_screen.dart';
import 'package:x01_flutter_basics/pages/Page4/to_do_provider/models/task_data.dart';

import 'components/task_list.dart';
import 'models/task.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //[provider] we pass the provider with its context
    final taskDataProvider = Provider.of<TaskData>(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  const Text(
                    'Todoey',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${Provider.of<TaskData>(context).tasksCount} Tasks', //[provider]
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const Divider(
                    height: 10,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: TasksList(), //[provider]
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent.shade700,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          //[BottomSheet]
          showModalBottomSheet(
            //[BottomSheet size] isScrollControlled + SingleChildScrollView + MediaQuery
            isScrollControlled: true,
            context: context,
            builder: (context2) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context2).viewInsets.bottom),
                //[provider] context lost -> here we have to pass the provider
                // with a context, since showModalBottomSheet looses it
                child: AddTaskScreen(taskDataProvider),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: Colors.transparent,
          );
        },
      ),
    );
  }
}
