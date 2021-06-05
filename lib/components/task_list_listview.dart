import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/components/task_tile.dart';
import 'package:todoapp/constants/contant.dart';
import 'package:todoapp/controllers/task_data_controller.dart';
import 'package:provider/provider.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return Container(
          width: double.infinity,
          child: ListView(
            children: [
              taskdata.pinnedTaskCount > 0
                  ? Row(
                      children: [
                        Image.asset(
                          'assets/icon/pin.png',
                          height: 20,
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text('Pinned Task'),
                      ],
                    )
                  : SizedBox.shrink(),
              ...taskdata.pinnedTask.map((task) => taskdata.pinnedTaskCount > 0
                  ? TaskTile(
                      task: task,
                    )
                  : SizedBox.shrink()),
              taskdata.pinnedTaskCount > 0 && taskdata.taskCount > 0
                  ? Divider(
                      color: kPrimaryColor.withOpacity(0.3),
                      thickness: 0.8,
                    )
                  : SizedBox.shrink(),
              ...taskdata.tasks.map(
                (task) => TaskTile(
                  task: task,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
