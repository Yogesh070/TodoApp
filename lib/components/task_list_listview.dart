import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/task_tile.dart';
import 'package:todoapp/controllers/task_data_controller.dart';

class TaskLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: taskdata.taskCount,
          itemBuilder: (context, index) {
            final task = taskdata.tasks[index];
            return TaskTile(task: task);
          },
        );
      },
    );
  }
}
