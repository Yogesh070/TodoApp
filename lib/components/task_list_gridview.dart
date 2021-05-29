import 'package:flutter/material.dart';
import 'package:todoapp/components/task_tile.dart';
import 'package:todoapp/controllers/task_data_controller.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/edit_screen.dart';

class TaskGridView extends StatefulWidget {
  @override
  _TaskGridViewState createState() => _TaskGridViewState();
}

class _TaskGridViewState extends State<TaskGridView> {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return GridView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: taskdata.taskCount,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: mediaWidth > 600 ? 30 : 16.0,
            ),
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
            });
      },
    );
  }
}
