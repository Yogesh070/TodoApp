import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/components/task_tile.dart';
import 'package:todoapp/model/task_data.dart';
import 'package:todoapp/screens/edit_screen.dart';

class TaskLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return ListView.builder(
          itemCount: taskdata.taskCount,
          itemBuilder: (context, index) {
            final task = taskdata.tasks[index];
            return TaskTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTask(
                      selectedTask: task,
                    ),
                  ),
                );
              },
              title: task.title,
              date: task.date,
              isCompleted: task.isDone,
              priority: task.priority,
              description: task.description,
              chechboxState: (checkState) {
                taskdata.updateTask(task);
              },
            );
          },
        );
      },
    );
  }
}
